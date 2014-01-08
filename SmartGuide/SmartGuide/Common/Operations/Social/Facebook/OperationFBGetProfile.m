//
//  OperationFBGetProfile.m
//  SmartGuide
//
//  Created by XXX on 7/24/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationFBGetProfile.h"

@implementation OperationFBGetProfile
@synthesize jsonData;

-(OperationFBGetProfile *)initWithAccessToken:(NSString *)accessToken
{
    NSString *fieldParams=@"picture.width(100).height(100),birthday,email,gender,id,name,name_format,first_name,last_name,work";

    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:fieldParams forKey:@"fields"];
    [dict setObject:accessToken forKey:@"access_token"];
    
    self=[super initWithRouter:FACEBOOK_GET_PROFILE params:dict];
    
    _accessToken=[[NSString alloc] initWithString:accessToken];
    
    return self;
}

-(bool)canManualHandleData:(id)responseObject
{
    return true;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    jsonData=@"";
    if([self isNullData:json])
        return;
    
    NSData* data = [json objectAtIndex:0];
    jsonData = [[NSString alloc] initWithData:data encoding:self.responseStringEncoding];
    
    if(!jsonData || jsonData.length==0)
    {
        jsonData=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    if(!jsonData)
        jsonData=@"";}

@end