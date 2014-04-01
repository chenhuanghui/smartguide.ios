//
//  NotificationDetailViewController.h
//  Infory
//
//  Created by XXX on 3/31/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "UserNotification.h"

@interface UserNotificationDetailViewController : SGViewController
{
    __weak UserNotification *_obj;
    __weak IBOutlet UITableView *table;
    NSMutableArray *_userNotificationDetails;
}

-(UserNotificationDetailViewController*) initWithUserNotification:(UserNotification*) obj;

@end
