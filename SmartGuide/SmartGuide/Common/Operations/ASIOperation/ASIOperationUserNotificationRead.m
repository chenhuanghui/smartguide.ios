//
//  ASIOperationUserNotificationRead.m
//  Infory
//
//  Created by XXX on 3/31/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationUserNotificationRead.h"
#import "UserNotification.h"
#import "UserNotificationContent.h"

@implementation ASIOperationUserNotificationRead

-(ASIOperationUserNotificationRead *)initWithIDNotification:(int)idNotification userLat:(double)userLat userLng:(double)userLng uuid:(NSString *)uuid
{
    self=[super initWithURL:SERVER_API_URL_MAKE(API_USER_NOTIFICATION_READ)];
    
    [self.keyValue setObject:@(idNotification) forKey:@"idNotification"];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    [self.keyValue setObject:uuid forKey:@"uuid"];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    NSArray *array=[UserNotification allObjects];
    bool hasChanged=false;
    int idNotification=[self.keyValue[@"idNotification"] integerValue];
    
    for(UserNotification *obj in array)
    {
        if(obj.idNotification.integerValue==idNotification && obj.enumStatus==USER_NOTIFICATION_STATUS_UNREAD && !obj.highlightUnread.boolValue)
        {
            obj.highlightUnread=@(false);
            hasChanged=true;
        }
    }
    
    array=[UserNotificationContent allObjects];
    
    for(UserNotificationContent *obj in array)
    {
        if(obj.idNotification.integerValue==idNotification && obj.enumStatus==USER_NOTIFICATION_CONTENT_STATUS_UNREAD)
        {
            obj.status=@(USER_NOTIFICATION_CONTENT_STATUS_READ);
            hasChanged=true;
        }
    }
    
    if(hasChanged)
        [[DataManager shareInstance] save];
}

@end
