//
//  ASIOperationUserNotificationRemove.m
//  Infory
//
//  Created by XXX on 5/20/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationUserNotificationRemove.h"

@implementation ASIOperationUserNotificationRemove

-(ASIOperationUserNotificationRemove *)initWithIDNotification:(NSNumber *)idNotification idSender:(NSNumber *)idSender userLat:(double)userLat userLng:(double)userLng
{
    self=[super initWithURL:SERVER_API_URL_MAKE(API_USER_NOTIFICATION_REMOVE)];
    
    if(idSender)
        [self.keyValue setObject:idSender forKey:@"idSender"];
    
    if(idNotification)
        [self.keyValue setObject:idNotification forKey:@"idNotification"];
    
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    
}

@end
