//
//  OperationFBGetProfile.m
//  SmartGuide
//
//  Created by XXX on 7/24/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationFBGetProfile.h"

@implementation OperationFBGetProfile

-(OperationFBGetProfile *)initWithAccessToken:(NSString *)accessToken
{
    self=[super initGETWithRouter:URL(FACEBOOK_GET_PROFILE)];
    
    NSString *fieldParams=@"picture.width(100).height(100),birthday,email,gender,id,name,name_format,first_name,last_name,work";
    
    [self.keyValue setObject:fieldParams forKey:@"fields"];
    [self.keyValue setObject:accessToken forKey:@"access_token"];
    
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
    
    self.jsonData=[NSString stringWithStringDefault:json[0]];
}

@end