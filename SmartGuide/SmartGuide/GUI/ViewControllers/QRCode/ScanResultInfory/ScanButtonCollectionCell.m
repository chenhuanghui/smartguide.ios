//
//  ScanButtonCollectionCell.m
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanButtonCollectionCell.h"
#import "UserNotificationAction.h"

@implementation ScanButtonCollectionCell

-(void)loadWithAction:(UserNotificationAction *)action
{
    _action=action;

    float textWidth=[ScanButtonCollectionCell widthWithAction:action];
    
    btn.frame=CGRectMake((self.l_v_w-textWidth)/2, btn.l_v_y, textWidth, btn.l_v_h);
    [btn setTitle:action.actionTitle forState:UIControlStateNormal];
    
    UIImage *img=nil;
    if(action.color.boolValue)
        img=[[UIImage imageNamed:@"bg_viewer_buttongrey.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(23, 23, 23, 23)];
    else
        img=[[UIImage imageNamed:@"bg_viewer_button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(23, 23, 23, 23)];
    
    [btn setBackgroundImage:img forState:UIControlStateNormal];
}

-(UserNotificationAction *)action
{
    return _action;
}

-(IBAction) btnTouchUpInside:(id)sender
{
    [self.delegate scanButtonCollectionCellTouchedAction:self];
}

+(NSString *)reuseIdentifier
{
    return @"ScanButtonCollectionCell";
}

+(float)widthWithAction:(UserNotificationAction *)action
{
    if(action.actionTitleWidth.floatValue==-1)
        action.actionTitleWidth=@([action.actionTitle sizeWithFont:FONT_SIZE_REGULAR(12) constrainedToSize:CGSizeMake(MAXFLOAT, 47) lineBreakMode:NSLineBreakByWordWrapping].width);
    
    return action.actionTitleWidth.floatValue+60;
}

@end

@implementation UICollectionView(ScanButtonCollectionCell)

-(void)registerScanButtonCollectionCell
{
    [self registerNib:[UINib nibWithNibName:[ScanButtonCollectionCell reuseIdentifier] bundle:nil] forCellWithReuseIdentifier:[ScanButtonCollectionCell reuseIdentifier]];
}

-(ScanButtonCollectionCell *)scanButtonCollectionCellForIndexPath:(NSIndexPath *)indexPath
{
    return [self dequeueReusableCellWithReuseIdentifier:[ScanButtonCollectionCell reuseIdentifier] forIndexPath:indexPath];
}

@end