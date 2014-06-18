//
//  ASIOperationNotificationCheck.m
//  Infory
//
//  Created by XXX on 4/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationNotificationCount.h"

@implementation ASIOperationNotificationCount

-(ASIOperationNotificationCount *)initWithUserLat:(double)userLat userLng:(double)userLng uuid:(NSString *)uuid
{
    self=[super initWithURL:SERVER_API_URL_MAKE(API_USER_NOTIFICATION_COUNT)];
    
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    [self.keyValue setObject:uuid forKey:@"uuid"];
    [self.keyValue setObject:@(1) forKey:@"type"];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    self.numOfNotification=@"";
    self.totalNotification=@(0);
    
    if([json isNullData])
        return;
    
    NSDictionary *dict=json[0];
    
    self.numOfNotification=[NSString stringWithStringDefault:dict[@"numOfNotification"]];
    self.totalNotification=[NSNumber numberWithObject:dict[@"totalNotification"]];
}

@end
