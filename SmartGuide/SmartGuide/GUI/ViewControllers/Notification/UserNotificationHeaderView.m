//
//  UserNotificationHeaderView.m
//  Infory
//
//  Created by XXX on 3/31/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "UserNotificationHeaderView.h"

@implementation UserNotificationHeaderView

- (instancetype)init
{
    self = [[NSBundle mainBundle] loadNibNamed:@"UserNotificationHeaderView" owner:nil options:nil][0];
    if (self) {
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

+(float)height
{
    return 26;
}

@end
