//
//  NotificationDetailViewController.h
//  Infory
//
//  Created by XXX on 3/31/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "UserNotification.h"
#import "UserNotificationContent.h"

@class UserNotificationViewController,MPMoviePlayerController, UserNotificationDetailViewController;

@protocol UserNotificationDetailViewControllerDelegate <SGViewControllerDelegate>

-(void) userNotificationDetailControllerTouchedBack:(UserNotificationDetailViewController*) controller;

@end

@interface UserNotificationDetailViewController : SGViewController
{
    NSNumber *_idSender;
    __weak IBOutlet UITableView *table;
    __weak IBOutlet UILabel *lblTitle;
    NSMutableArray *_userNotificationContents;
    __weak UserNotification *_userNotification;
    
    int _page;
    bool _canLoadMore;
    bool _isLoadingMore;
    
    NSMutableDictionary *_timerMovide;
    
    __strong MPMoviePlayerController *_player;
}

-(UserNotificationDetailViewController*) initWithIDSender:(NSNumber*) idSender;
-(UserNotificationDetailViewController*) initWithUserNotification:(UserNotification*) obj;

@property (nonatomic, weak) id<UserNotificationDetailViewControllerDelegate> delegate;

@end

@interface UserNotificationContent(DisplayType)

-(enum USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE) enumDisplayType;

@end