//
//  UserNotificationDetailCell.h
//  Infory
//
//  Created by XXX on 4/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserNotificationDetail.h"

@class UserNotificationDetailCell;

@protocol UserNotificationDetailCellDelegate <NSObject>

-(void) userNotificationDetailCellTouchedGo:(UserNotificationDetailCell*) cell userNotificationDetail:(UserNotificationDetail*) obj;

@end

@interface UserNotificationDetailCell : UITableViewCell
{
    __weak IBOutlet UILabel *lblTime;
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet UILabel *lblContent;
    __weak IBOutlet UIButton *btnGo;
    __weak IBOutlet UIView *displayView;
    __weak IBOutlet UIImageView *imgvIcon;
    
    __weak UserNotificationDetail *_obj;
}

-(void) loadWithUserNotificationDetail:(UserNotificationDetail*) obj;
-(UserNotificationDetail*) userNotificationDetail;

+(NSString *)reuseIdentifier;
+(float) heightWithUserNotificationDetail:(UserNotificationDetail*) obj;

@property (nonatomic, weak) id<UserNotificationDetailCellDelegate> delegate;

@end
