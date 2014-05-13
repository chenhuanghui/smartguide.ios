//
//  UserNotificationDetailCell.h
//  Infory
//
//  Created by XXX on 4/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserNotificationContent.h"

enum USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE
{
    USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_TITLE=0,
    USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_FULL=1,
};

@class UserNotificationDetailCell;

@protocol UserNotificationDetailCellDelegate <NSObject>

-(void) userNotificationDetailCellTouchedGo:(UserNotificationDetailCell*) cell;
-(void) userNotificationDetailCellTouchedLogo:(UserNotificationDetailCell*) cell;

@end

@interface UserNotificationDetailCell : UITableViewCell
{
    __weak IBOutlet UILabel *lblTime;
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet UILabel *lblContent;
    __weak IBOutlet UIButton *btnGo;
    __weak IBOutlet UIView *displayView;
    __weak IBOutlet UIImageView *imgvIcon;
    __weak IBOutlet UILabel *lblGoTo;
    __weak IBOutlet UIButton *btnLogo;
    
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
