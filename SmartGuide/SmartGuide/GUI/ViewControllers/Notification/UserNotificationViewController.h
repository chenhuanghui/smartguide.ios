//
//  NotificationViewController.h
//  Infory
//
//  Created by XXX on 3/31/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "ASIOperationUserNotification.h"

@class  UserNotificationHeaderView;

@interface UserNotificationViewController : SGViewController
{
    __weak IBOutlet UITableView *table;
    
    enum USER_NOTIFICATION_DISPLAY_TYPE _displayType;
    
    NSMutableArray *_userNotification;
    NSArray *_userNotificationUnread;
    NSArray *_userNotificationRead;
    ASIOperationUserNotification *_operationUserNotification;
    int _page;
    bool _canLoadMore;
    bool _isLoadingMore;
    bool _isHasReadNotification;
    
    __weak UserNotificationHeaderView *_headerView;
}

@end
