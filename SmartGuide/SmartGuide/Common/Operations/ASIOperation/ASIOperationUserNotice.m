//
//  ASIOperationUserNotice.m
//  Infory
//
//  Created by XXX on 4/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationUserNotice.h"

@implementation ASIOperationUserNotice

-(ASIOperationUserNotice *)initWithUserLat:(double)userLat userLng:(double)userLng
{
    self=[super initWithURL:SERVER_API_URL_MAKE(API_USER_NOTICE)];
    
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    self.notifce=@"";
    
    if([self isNullData:json])
        return;
    
    NSDictionary *dict=json[0];
    
    self.notifce=[NSString stringWithStringDefault:dict[@"notice"]];
}

@end