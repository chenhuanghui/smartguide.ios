//
//  NotificationViewController.h
//  Infory
//
//  Created by XXX on 3/31/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"

enum USER_NOTIFICATION_DISPLAY_TYPE
{
    USER_NOTIFICATION_DISPLAY_ALL = 0,
    USER_NOTIFICATION_DISPLAY_UNREAD = 1,
    USER_NOTIFICATION_DISPLAY_READ = 2,
};

@interface UserNotificationViewController : SGViewController
{
    __weak IBOutlet UITableView *table;
    
    enum USER_NOTIFICATION_DISPLAY_TYPE _displayType;
    
    NSMutableArray *_userNotification;
}

@end
