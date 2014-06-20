//
//  ASIOperationUserNotificationRead.m
//  Infory
//
//  Created by XXX on 3/31/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationUserNotificationMarkRead.h"
#import "UserNotification.h"
#import "UserNotificationContent.h"

@implementation ASIOperationUserNotificationMarkRead

-(ASIOperationUserNotificationMarkRead *)initWithIDMessage:(int)idMessage userLat:(double)userLat userLng:(double)userLng
{
    self=[super initPOSTWithURL:SERVER_API_URL_MAKE(API_USER_NOTIFICATION_MARK_READ)];
    
    [self.keyValue setObject:@(idMessage) forKey:@"idMessage"];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
}

@end
