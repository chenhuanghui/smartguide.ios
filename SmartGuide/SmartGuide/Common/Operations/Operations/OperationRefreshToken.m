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

-(OperationRefreshToken *)initWithClientID:(NSString *)clientID secretID:(NSString *)secretID refreshToken:(NSString *)_refreshToken
{
    self=[super initGETWithRouter:SERVER_IP_MAKE_URL(API_REFRESH_TOKEN)];
    
    [self.keyValue setObject:@"refresh_token" forKey:@"grant_type"];
    [self.keyValue setObject:clientID forKey:@"client_id"];
    [self.keyValue setObject:secretID forKey:@"client_secret"];
    [self.keyValue setObject:_refreshToken forKey:@"refresh_token"];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    NSDictionary *dict=[json objectAtIndex:0];
    
    accessToken=[NSString stringWithStringDefault:dict[@"access_token"]];
    expiresIn=[NSString stringWithStringDefault:dict[@"expires_in"]];
    refreshToken=[NSString stringWithStringDefault:dict[@"refresh_token"]];
}

@end
