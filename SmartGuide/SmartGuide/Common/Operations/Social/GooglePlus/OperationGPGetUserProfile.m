//
//  OperationGPGetUserProfile.m
//  SmartGuide
//
//  Created by MacMini on 08/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "OperationGPGetUserProfile.h"

@implementation OperationGPGetUserProfile
@synthesize jsonData;

-(OperationGPGetUserProfile *)initWithAccessToken:(NSString *)accessToken clientID:(NSString *)clientID
{
    NSString *router=@"https://www.googleapis.com/plus/v1/people/me";
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    
    [dict setObject:accessToken forKey:@"access_token"];
    [dict setObject:clientID forKey:@"key"];
    
    self=[super initWithRouter:router params:dict];
    
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
        jsonData=@"";
}

@end
