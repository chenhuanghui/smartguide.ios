//
//  TokenManager.m
//  SmartGuide
//
//  Created by XXX on 8/6/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "TokenManager.h"
#import "Flags.h"

@interface TokenManager()



@end

static TokenManager *_tokenManager=nil;
@implementation TokenManager
@synthesize refreshTokenString,retryCount,accessToken,activeCode,phone,retryGetTokenCount;

+(TokenManager *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tokenManager=[[TokenManager alloc] init];
    });
    
    return _tokenManager;
}

-(void)refreshToken
{
    if(_isRefreshingToken)
        return;
    
    retryCount++;
    
    _isRefreshingToken=true;
    
    _operationRefreshToken=[[OperationRefreshToken alloc] initWithClientID:CLIENT_ID secretID:SECRET_ID refreshToken:self.refreshTokenString];
    _operationRefreshToken.delegate=self;
    [_operationRefreshToken start];
}

-(void)operationURLFailed:(OperationURL *)operation
{
    if([operation isKindOfClass:[OperationRefreshToken class]])
    {
        _isRefreshingToken=false;
        _operationRefreshToken=nil;
        
        if(retryCount<2)
            [self refreshToken];
        else
        {
            retryGetTokenCount=0;
            _isGettingToken=false;
            
            [self getToken];
        }
    }
    else if([operation isKindOfClass:[OperationGetToken class]])
    {
        _isGettingToken=false;
        _operationGetToken=nil;
        
        if(retryGetTokenCount<2)
            [self getToken];
        else
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_REFRESH_TOKEN_FAILED object:nil];
    }
}

-(void) getToken
{
    if(_isGettingToken)
        return;
    
    _isGettingToken=true;
    retryGetTokenCount++;
    
    _operationGetToken=[[OperationGetToken alloc] initWithPhone:self.phone activeCode:self.activeCode];
    _operationGetToken.delegate=self;
    [_operationGetToken start];
}

-(void)operationURLFinished:(OperationURL *)operation
{
    if([operation isKindOfClass:[OperationRefreshToken class]])
    {
        OperationRefreshToken *refresh=(OperationRefreshToken*)operation;
        
        retryCount=0;
        _isRefreshingToken=false;
        
        self.accessToken=refresh.accessToken;
        self.refreshTokenString=refresh.refreshToken;
        
        _operationRefreshToken=nil;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_REFRESH_TOKEN_SUCCESS object:self.accessToken];
    }
    else if([operation isKindOfClass:[OperationGetToken class]])
    {
        _isGettingToken=false;
        
        OperationGetToken *ope=(OperationGetToken*)operation;
        
        self.accessToken=ope.accessToken;
        self.refreshTokenString=ope.refreshToken;
        
        _operationGetToken=nil;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_REFRESH_TOKEN_SUCCESS object:self.accessToken];
    }
}

-(NSString *)accessToken
{
    return [Flags accessToken];
}

-(void)setAccessToken:(NSString *)_accessToken
{
    [Flags setAccessToken:_accessToken];
}

-(NSString *)refreshTokenString
{
    return [Flags refreshToken];
}

-(void)setRefreshTokenString:(NSString *)_refreshToken
{
    [Flags setRefreshToken:_refreshToken];
}

-(bool)isRefreshingToken
{
    return _isRefreshingToken;
}

-(void)setActiveCode:(NSString *)_activeCode
{
    [Flags setActiveCode:activeCode];
}

-(NSString *)activeCode
{
    return [Flags activeCode];
}

-(void)setPhone:(NSString *)_phone
{
    [Flags setLastPhoneUser:_phone];
}

-(NSString *)phone
{
    return [Flags lastPhoneUser];
}

@end
