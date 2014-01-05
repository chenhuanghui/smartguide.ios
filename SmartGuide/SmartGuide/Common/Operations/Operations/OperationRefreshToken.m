//
//  OperationRefreshToken.m
//  SmartGuide
//
//  Created by XXX on 8/4/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationRefreshToken.h"

@implementation OperationRefreshToken
@synthesize accessToken,expiresIn,refreshToken;

+(void)refreshTokenWithClientID:(NSString *)clientID secretID:(NSString *)secretID refreshToken:(NSString *)refresh onCompleted:(void (^)(NSString *, NSString *))onCompleted
{
    OperationRefreshToken *ope=[[OperationRefreshToken alloc] initWithClientID:clientID secretID:secretID refreshToken:refresh];
    [ope setRefreshCompleted:onCompleted];
    ope.delegate=ope;
    
    [ope start];
}

-(OperationRefreshToken *)initWithClientID:(NSString *)clientID secretID:(NSString *)secretID refreshToken:(NSString *)_refreshToken
{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:@"refresh_token" forKey:@"grant_type"];
    [dict setObject:clientID forKey:@"client_id"];
    [dict setObject:secretID forKey:@"client_secret"];
    [dict setObject:_refreshToken forKey:@"refresh_token"];
    
    self=[super initWithRouter:SERVER_IP_MAKE(API_REFRESH_TOKEN) params:dict];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    NSDictionary *dict=[json objectAtIndex:0];
    
    accessToken=[dict objectForKey:@"access_token"];
    expiresIn=[dict objectForKey:@"expires_in"];
    refreshToken=[dict objectForKey:@"refresh_token"];
}

-(void)setRefreshCompleted:(void (^)(NSString *, NSString *))completed
{
    _refreshCompleted=[completed copy];
}

-(void)operationURLFinished:(OperationURL *)operation
{
    if(_refreshCompleted)
    {
        OperationRefreshToken *ref=(OperationRefreshToken*)operation;
        _refreshCompleted(ref.accessToken,ref.refreshToken);
        _refreshCompleted=nil;
    }
}

-(void)operationURLFailed:(OperationURL *)operation
{
    if(_refreshCompleted)
    {
        _refreshCompleted(nil,nil);
        _refreshCompleted=nil;
    }
}

@end
