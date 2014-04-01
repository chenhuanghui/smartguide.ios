//
//  UserNotificationDetailCell.m
//  Infory
//
//  Created by XXX on 4/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "UserNotificationDetailCell.h"

@implementation UserNotificationDetailCell

-(void)loadWithUserNotificationDetail:(UserNotificationDetail *)obj
{
    _obj=obj;
    
    lblTime.text=obj.time;
    lblContent.text=obj.desc;
    lblTitle.text=obj.title;
}

-(UserNotificationDetail *)userNotificationDetail
{
    return _obj;
}

+(NSString *)reuseIdentifier
{
    return @"UserNotificationDetailCell";
}

+(float)heightWithUserNotificationDetail:(UserNotificationDetail *)obj
{
    return 0;
}

- (IBAction)btnGoTouchUpInside:(id)sender {
    [self.delegate userNotificationDetailCellTouchedGo:self userNotificationDetail:_obj];
}

@end
