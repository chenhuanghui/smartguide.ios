//
//  OperationGetToken.m
//  SmartGuide
//
//  Created by XXX on 8/4/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationGetToken.h"

@implementation OperationGetToken
@synthesize accessToken,expiresIn,refreshToken;

-(OperationGetToken *)initWithPhone:(NSString *)phone activeCode:(NSString *)activeCode
{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:@"http://dev.smartguide.com/app_dev.php/grants/bingo" forKey:@"grant_type"];
    [dict setObject:CLIENT_ID forKey:@"client_id"];
    [dict setObject:SECRET_ID forKey:@"client_secret"];
    [dict setObject:phone forKey:@"phone"];
    [dict setObject:activeCode forKey:@"code"];
    
    self=[super initWithRouter:SERVER_IP_MAKE(API_GET_TOKEN) params:dict];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    NSDictionary *dict=[json objectAtIndex:0];
    
    accessToken=[dict objectForKey:@"access_token"];
    expiresIn=[dict objectForKey:@"expires_in"];
    refreshToken=[dict objectForKey:@"refresh_token"];
}

@end
