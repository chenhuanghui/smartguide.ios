//
//  UserNotificationDetailButtonTableViewCell.h
//  Infory
//
//  Created by XXX on 6/20/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserNotificationAction, UserNotificationDetailButtonTableViewCell;

@protocol  UserNotificationDetailButtonTableViewCellDelegate <NSObject>

-(void) userNotificationDetailButtonTableViewCellTouchedAction:(UserNotificationDetailButtonTableViewCell*) cell;

@end

@interface UserNotificationDetailButtonTableViewCell : UITableViewCell
{
    __weak IBOutlet UIButton *btn;

    __weak UserNotificationAction *_action;
}

-(void) loadWithAction:(UserNotificationAction*) action;
-(UserNotificationAction*) action;
+(float) heightWithAction:(UserNotificationAction*) action;
+(NSString *)reuseIdentifier;

@property (nonatomic, weak) id<UserNotificationDetailButtonTableViewCellDelegate> delegate;

@end

@interface UITableView(UserNotificationDetailButtonTableViewCell)

-(void) registerUserNotificationDetailButtonTableViewCell;
-(UserNotificationDetailButtonTableViewCell*) userNotificationDetailButtonTableViewCell;

@end