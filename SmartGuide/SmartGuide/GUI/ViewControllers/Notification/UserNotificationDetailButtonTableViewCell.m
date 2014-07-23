//
//  UserNotificationDetailButtonTableViewCell.m
//  Infory
//
//  Created by XXX on 6/20/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "UserNotificationDetailButtonTableViewCell.h"
#import "UserNotificationAction.h"

@implementation UserNotificationDetailButtonTableViewCell

-(void)loadWithAction:(UserNotificationAction *)action cellPos:(enum CELL_POSITION)cellPos
{
    _action=action;
    [btn setTitle:action.actionTitle forState:UIControlStateNormal];
    
    imgvLine.hidden=cellPos==CELL_POSITION_BOTTOM;
}

-(UserNotificationAction *)action
{
    return _action;
}

-(IBAction) btnTouchUpInside:(id)sender
{
    [self.delegate userNotificationDetailButtonTableViewCellTouchedAction:self];
}

+(NSString *)reuseIdentifier
{
    return @"UserNotificationDetailButtonTableViewCell";
}

+(float)heightWithAction:(UserNotificationAction *)action
{
    return 37;
}

@end

@implementation UITableView(UserNotificationDetailButtonTableViewCell)

-(void)registerUserNotificationDetailButtonTableViewCell
{
    [self registerNib:[UINib nibWithNibName:[UserNotificationDetailButtonTableViewCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[UserNotificationDetailButtonTableViewCell reuseIdentifier]];
}

-(UserNotificationDetailButtonTableViewCell *)userNotificationDetailButtonTableViewCell
{
    return [self dequeueReusableCellWithIdentifier:[UserNotificationDetailButtonTableViewCell reuseIdentifier]];
}

@end