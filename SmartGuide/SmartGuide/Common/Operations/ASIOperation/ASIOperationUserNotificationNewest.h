//
//  ASIOperationUserNotification.h
//  Infory
//
//  Created by XXX on 3/31/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"
#import "UserNotification.h"

enum USER_NOTIFICATION_DISPLAY_TYPE
{
    USER_NOTIFICATION_DISPLAY_ALL = 0,
    USER_NOTIFICATION_DISPLAY_UNREAD = 1,
    USER_NOTIFICATION_DISPLAY_READ = 2,
};

@interface ASIOperationUserNotificationNewest : ASIOperationPost

-(ASIOperationUserNotificationNewest*) initWithPage:(int) page userLat:(double) userLat userLng:(double) userLng type:(enum USER_NOTIFICATION_DISPLAY_TYPE) type;

@property (nonatomic, strong) NSMutableArray *userNotifications;

@end
