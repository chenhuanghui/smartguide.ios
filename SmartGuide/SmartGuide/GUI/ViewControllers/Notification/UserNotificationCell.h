//
//  UserNotificationCell.h
//  Infory
//
//  Created by XXX on 3/31/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserNotification.h"
#import "TokenView.h"

@class UserNotificationCell,ScrollUserNotification;

@protocol UserNotificationCellDelegate <NSObject>

-(void) userNotificationCellTouchedAction:(UserNotificationCell*) cell action:(UserNotificationAction*) action;
-(void) userNotificationCellTouchedDetail:(UserNotificationCell*) cell obj:(UserNotification*) obj;
-(void) userNotificationCellTouchedRemove:(UserNotificationCell*) cell obj:(UserNotification*) obj;

@end

@interface UserNotificationCell : UITableViewCell
{
    __weak IBOutlet ScrollUserNotification *scroll;
    __weak IBOutlet UIView *leftView;
    __weak IBOutlet UIView *rightView;
    __weak IBOutlet UILabel *lblContent;
    __weak IBOutlet UILabel *lblTime;
    __weak IBOutlet UIButton *btnRemove;
    __weak IBOutlet UIView *displayContentView;
    __weak IBOutlet UIView *lineView;
    __weak IBOutlet TokenView *tokensView;
    
    __weak UserNotification* _obj;
    bool _isAddedObserverHighlightUnread;
}

-(void) loadWithUserNotification:(UserNotification*) obj;
-(UserNotification*) userNotification;
-(void) tableDidEndDisplayCell;
-(void) tableWillDisplayCell;
-(void) addObserverHighlightUnread;
-(void) removeObserverHighlightUnread;

+(NSString *)reuseIdentifier;
+(float) heightWithUserNotification:(UserNotification*) obj;

@property (nonatomic, weak) id<UserNotificationCellDelegate> delegate;

@end

@interface ScrollUserNotification : UIScrollView

@end