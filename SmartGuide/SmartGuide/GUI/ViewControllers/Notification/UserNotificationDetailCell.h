//
//  UserNotificationDetailCell.h
//  Infory
//
//  Created by XXX on 4/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

enum USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE
{
    USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_TITLE=0,
    USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_FULL=1,
};

@class UserNotificationDetailCell,ScrollNotificationContent, MPMoviePlayerController, UserNotificationAction, UserNotificationContent;

@protocol UserNotificationDetailCellDelegate <NSObject>

-(void) userNotificationDetailCellTouchedAction:(UserNotificationDetailCell*) cell action:(UserNotificationAction*) action;
-(void) userNotificationDetailCellTouchedLogo:(UserNotificationDetailCell*) cell;
-(void) userNotificationDetailCellTouchedRemove:(UserNotificationDetailCell*) cell;
-(void) userNotificationDetailCellTouchedDetail:(UserNotificationDetailCell*) cell;
-(MPMoviePlayerController*) userNotificationDetailCellRequestPlayer:(UserNotificationDetailCell*) cell;

@end

@interface UserNotificationDetailCell : UITableViewCell<TableViewCellDynamicHeight>
{
    __weak IBOutlet UILabel *lblTime;
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet UILabel *lblContent;
    __weak IBOutlet UIView *displayView;
    __weak IBOutlet UIImageView *imgvIcon;
    __weak IBOutlet UIButton *btnLogo;
    __weak IBOutlet ScrollNotificationContent *scroll;
    __weak IBOutlet UIView *leftView;
    __weak IBOutlet UIView *rightView;
    __weak IBOutlet UIImageView *imgvImage;
    __weak IBOutlet UIView *videoContain;
    __weak IBOutlet UIImageView *imgvVideoThumbnail;
    __weak IBOutlet UIButton *btnMovie;
    __weak IBOutlet UIView *movideBGView;
    __weak IBOutlet UIView *avatarMaskView;
    __weak IBOutlet UITableView *tableButtons;
    __weak IBOutlet UIView *markUnreadView;
    
    __weak UserNotificationContent *_obj;
    NSArray *_actions;
}

-(void) loadWithUserNotificationDetail:(UserNotificationContent*) obj;
-(UserNotificationContent*) userNotificationDetail;

+(NSString *)reuseIdentifier;

@property (nonatomic, weak) id<UserNotificationDetailCellDelegate> delegate;

@end

@interface ScrollNotificationContent : UIScrollView

@end

@interface UITableView(UserNotificationDetailCell)

-(void) registerUserNotificationDetailCell;
-(UserNotificationDetailCell*) userNotificationDetailCell;

@end