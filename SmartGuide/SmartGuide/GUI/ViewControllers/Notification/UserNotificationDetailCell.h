//
//  UserNotificationDetailCell.h
//  Infory
//
//  Created by XXX on 4/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserNotificationContent.h"

@class UserNotificationDetailCell;

@protocol UserNotificationDetailCellDelegate <NSObject>

-(void) userNotificationDetailCellTouchedGo:(UserNotificationDetailCell*) cell userNotificationDetail:(UserNotificationContent*) obj;

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
    
    __weak UserNotificationContent *_obj;
}

-(void) loadWithUserNotificationDetail:(UserNotificationContent*) obj;
-(UserNotificationContent*) userNotificationDetail;

+(NSString *)reuseIdentifier;
+(float) heightWithUserNotificationDetail:(UserNotificationContent*) obj;

@property (nonatomic, weak) id<UserNotificationDetailCellDelegate> delegate;

@end
