//
//  NotificationViewController.h
//  Infory
//
//  Created by XXX on 3/31/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class  UserNotificationHeaderView,UserNotificationViewController, UserNotification;

@protocol UserNotificationViewControllerDelegate <SGViewControllerDelegate>

-(void) userNotificationViewControllerTouchedBack:(UserNotificationViewController*) controller;
-(void) userNotificationViewControllerTouchedNotification:(UserNotificationViewController*) controlelr userNotification:(UserNotification*) obj;

@end

@interface UserNotificationViewController : SGViewController
{
    __weak IBOutlet UITableView *table;
    __weak IBOutlet UILabel *lblTitle;
    
    NSMutableArray *_userNotification;
    NSArray *_userNotificationUnread;
    NSArray *_userNotificationRead;
    NSArray *_userNotificationFromAPI;
    
    int _numberNotificationUnread;
    NSString *_totalNotificationUnread;
    int _numberNotificationAll;
    NSString *_totalNotificationAll;
    
    int _page;
    bool _canLoadMore;
    bool _isLoadingMore;
    bool _isHasReadNotification;
    
    __weak UserNotificationHeaderView *_headerView;
}

@property (nonatomic, weak) id<UserNotificationViewControllerDelegate> delegate;

@end
