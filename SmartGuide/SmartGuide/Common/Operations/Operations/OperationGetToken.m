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
    NSURL *url=[NSURL URLWithString:API_GET_TOKEN(phone, activeCode)];
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

@end
