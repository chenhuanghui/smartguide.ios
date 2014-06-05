//
//  UserNotificationDetailCell.h
//  Infory
//
//  Created by XXX on 4/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserNotificationContent.h"
#import "TokenView.h"

enum USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE
{
    USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_TITLE=0,
    USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_FULL=1,
};

@class UserNotificationDetailCell,ScrollNotificationContent;

@protocol UserNotificationDetailCellDelegate <NSObject>

-(void) userNotificationDetailCellTouchedAction:(UserNotificationDetailCell*) cell action:(UserNotificationAction*) action;
-(void) userNotificationDetailCellTouchedLogo:(UserNotificationDetailCell*) cell;
-(void) userNotificationDetailCellTouchedRemove:(UserNotificationDetailCell*) cell;
-(void) userNotificationDetailCellTouchedDetail:(UserNotificationDetailCell*) cell;

@end

@interface UserNotificationDetailCell : UITableViewCell
{
    __weak IBOutlet UILabel *lblTime;
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet UILabel *lblContent;
    __weak IBOutlet UIView *displayView;
    __weak IBOutlet UIImageView *imgvIcon;
    __weak IBOutlet UIButton *btnLogo;
    __weak IBOutlet TokenView *tokens;
    __weak IBOutlet ScrollNotificationContent *scroll;
    __weak IBOutlet UIView *leftView;
    __weak IBOutlet UIView *rightView;
    __weak IBOutlet UIImageView *imgvImage;
    
    __weak UserNotificationContent *_obj;
    enum USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE _displayType;
}

-(void) loadWithUserNotificationDetail:(UserNotificationContent*) obj displayType:(enum USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE) displayType;
-(UserNotificationContent*) userNotificationDetail;
-(enum USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE) displayType;

+(NSString *)reuseIdentifier;
+(float) heightWithUserNotificationDetail:(UserNotificationContent*) obj displayType:(enum USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE) displayType;

@property (nonatomic, weak) id<UserNotificationDetailCellDelegate> delegate;

@end

@interface ScrollNotificationContent : UIScrollView

@end