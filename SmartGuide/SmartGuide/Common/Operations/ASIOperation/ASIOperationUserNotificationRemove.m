//
//  ASIOperationUserNotificationRemove.m
//  Infory
//
//  Created by XXX on 5/20/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationUserNotificationRemove.h"

@implementation ASIOperationUserNotificationRemove

-(ASIOperationUserNotificationRemove *)initWithIDNotification:(int)idNotification userLat:(double)userLat userLng:(double)userLng uuid:(NSString *)uuid
{
    self=[super initWithURL:SERVER_API_URL_MAKE(API_USER_NOTIFICATION_REMOVE)];
    
    [self.keyValue setObject:@(idNotification) forKey:@"idNotification"];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    [self.keyValue setObject:UUID() forKey:@"uuid"];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    
}

@end
