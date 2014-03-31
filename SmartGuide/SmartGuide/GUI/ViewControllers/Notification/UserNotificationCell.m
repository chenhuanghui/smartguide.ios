//
//  UserNotificationCell.m
//  Infory
//
//  Created by XXX on 3/31/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "UserNotificationCell.h"

@implementation UserNotificationCell

-(void)loadWithUserNotification:(UserNotification *)obj
{
    _obj=obj;
    
    lblContent.text=obj.content;
    lblTime.text=obj.time;
    
    displayContentView.backgroundColor=obj.enumStatus==USER_NOTIFICATION_STATUS_READ?[UIColor darkGrayColor]:[UIColor whiteColor];
    scroll.contentOffset=CGPointZero;
    scroll.contentSize=CGSizeMake(leftView.l_v_w+rightView.l_v_w, 0);
}

+(NSString *)reuseIdentifier
{
    return @"UserNotificationCell";
}

+(float)heightWithUserNotification:(UserNotification *)obj
{
    float height=77;
    
    if(obj.contentHeight.floatValue==-1)
    {
        obj.contentHeight=@([obj.content sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:13] constrainedToSize:CGSizeMake(264, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height);
    }
    
    height+=MAX(0,obj.contentHeight.floatValue-22);
    
    return height;
}

- (IBAction)btnDetailTouchUpInside:(id)sender {
    [scroll setContentOffset:CGPointZero animated:true];
    [[self delegate] userNotificationCellTouchedDetail:self obj:_obj];
}

- (IBAction)btnRemoveTouchUpInside:(id)sender {
    [scroll setContentOffset:CGPointZero animated:true];
}

@end
