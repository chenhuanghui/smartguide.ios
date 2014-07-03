//
//  ScanResultInforyButtonCell.m
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultInforyButtonCell.h"
#import "ScanCodeDecode.h"
#import "UserNotificationAction.h"

@implementation ScanResultInforyButtonCell

-(void)loadWithDecode:(ScanCodeDecode *)decode
{
//    float textWidth=decode.action.actionTitleWidth.floatValue+30;
//    
//    btn.frame=CGRectMake((self.l_v_w-textWidth)/2, btn.l_v_y, textWidth, btn.l_v_h);
//    [btn setTitle:decode.action.actionTitle forState:UIControlStateNormal];
//    
//    UIImage *img=[[UIImage imageNamed:@"bg_viewer_button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(23, 23, 23, 23)];
//    [btn setBackgroundImage:img forState:UIControlStateNormal];
}

-(IBAction)btnTouchUpInside:(id)sender
{
    
}

+(NSString *)reuseIdentifier
{
    return @"ScanResultInforyButtonCell";
}

+(float)heightWithDecode:(ScanCodeDecode *)decode
{
//    if(decode.action.actionTitleWidth.floatValue==-1)
//    {
//        decode.action.actionTitleWidth=@([decode.action.actionTitle sizeWithFont:FONT_SIZE_REGULAR(12) constrainedToSize:CGSizeMake(MAXFLOAT, 47) lineBreakMode:NSLineBreakByWordWrapping].width);
//    }
    
    return 47+20;
}

@end

@implementation UITableView(ScanResultInforyButtonCell)

-(void)registerScanResultInforyButtonCell
{
    [self registerNib:[UINib nibWithNibName:[ScanResultInforyButtonCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ScanResultInforyButtonCell reuseIdentifier]];
}

-(ScanResultInforyButtonCell *)scanResultInforyButtonCell
{
    return [self dequeueReusableCellWithIdentifier:[ScanResultInforyButtonCell reuseIdentifier]];
}

@end