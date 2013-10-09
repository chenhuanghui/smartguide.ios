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
    
    NSString *str=[NSString stringWithFormat:@"%@/oauth/v2/token?grant_type=refresh_token&client_id=%@&client_secret=%@&refresh_token=%@",SERVER_IP,clientID,secretID,_refreshToken];
    NSURL *url=[NSURL URLWithString:str];
    self=[super initWithURL:url];
    
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
