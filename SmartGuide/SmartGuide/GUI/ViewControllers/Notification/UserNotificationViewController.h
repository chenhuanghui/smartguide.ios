//
//  NotificationViewController.h
//  Infory
//
//  Created by XXX on 3/31/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class  UserNotificationHeaderView,UserNotificationViewController;

@interface UserNotificationViewController : SGViewController
{
    __weak IBOutlet UITableView *table;
    
    NSMutableArray *_userNotification;
    NSArray *_userNotificationUnread;
    NSArray *_userNotificationRead;
    NSArray *_userNotificationFromAPI;
    
    int _page;
    bool _canLoadMore;
    bool _isLoadingMore;
    bool _isHasReadNotification;
    
    __weak UserNotificationHeaderView *_headerView;
}

@end
