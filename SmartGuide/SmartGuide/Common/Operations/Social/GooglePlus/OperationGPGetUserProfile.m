//
//  OperationGPGetUserProfile.m
//  SmartGuide
//
//  Created by MacMini on 08/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "OperationGPGetUserProfile.h"

@implementation OperationGPGetUserProfile

-(OperationGPGetUserProfile *)initWithAccessToken:(NSString *)accessToken clientID:(NSString *)clientID
{
    NSString *router=@"https://www.googleapis.com/plus/v1/people/me";
    self=[super initGETWithRouter:URL(router)];
    
    [self.keyValue setObject:accessToken forKey:@"access_token"];
    [self.keyValue setObject:clientID forKey:@"key"];
    
    return self;
}

-(void)onFinishLoading
{
    self.jsonData=@"";
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if([json isNullData])
        return;
    
    self.jsonData = [NSString stringWithStringDefault:json[0]];
}

@end
