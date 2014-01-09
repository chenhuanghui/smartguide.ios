//
//  NewFeedInfoCell.m
//  SmartGuide
//
//  Created by MacMini on 24/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "HomeInfoCell.h"
#import "ImageManager.h"
#import "Utility.h"

@implementation HomeInfoCell
@synthesize delegate;

-(void)loadWithHome6:(UserHome6 *)home
{
    _home6=home;
    _home7=nil;
    
    [imgvLogo loadImageHomeWithURL:home.logo];
    lblName.text=home.shopName;
    lblDate.text=home.date;
    [imgvCover loadImageHomeWithURL:home.cover];
    lblTitle.text=home.title;
    lblContent.text=home.content;
    
    [btnGoTo setTitle:@"GO" forState:UIControlStateNormal];
    
    if(home.gotoshop.length>0)
        [btnGoTo setTitle:home.gotoshop forState:UIControlStateNormal];
    
//    [btnGoTo setTitle:@"Đến cửa hàng ngay" forState:UIControlStateNormal];
    
    [self makeButtonSize];
    
    
}

-(void)loadWithHome7:(UserHome7 *)home
{
    _home6=nil;
    _home7=home;
    
    [imgvLogo loadImageHomeWithURL:home.store.logo];
    lblName.text=home.storeName;
    lblDate.text=home.date;
    [imgvCover loadImageHomeWithURL:home.cover];
    lblTitle.text=home.title;
    lblContent.text=home.content;
    
    [btnGoTo setTitle:@"GO" forState:UIControlStateNormal];
    
    if(home.gotostore.length>0)
        [btnGoTo setTitle:home.gotostore forState:UIControlStateNormal];
    
//    [btnGoTo setTitle:@"Đến cửa hàng ngay" forState:UIControlStateNormal];
    
    [self makeButtonSize];

    [lblContent l_v_setY:174+home.titleHeight];
}

-(void) makeButtonSize
{
    float width=[[btnGoTo titleForState:UIControlStateNormal] sizeWithFont:btnGoTo.titleLabel.font constrainedToSize:CGSizeMake(295, 44) lineBreakMode:btnGoTo.titleLabel.lineBreakMode].width+50;
    
    [btnGoTo l_v_setW:width];
    [btnGoTo l_c_setX:self.l_v_w/2];
}

+(float)heightWithHome6:(UserHome6 *)home
{
    float height=242;
    height+=[home.content sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:13] constrainedToSize:CGSizeMake(257, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height-10;
    
    return height;
}

+(float)heightWithHome7:(UserHome7 *)home
{
    float height=273;
    
    home.titleHeight=[home.title sizeWithFont:[UIFont fontWithName:@"Avenir-Heavy" size:13] constrainedToSize:CGSizeMake(275, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height-30;
    
    height+=home.titleHeight;
    
    home.contentHeight=[home.content sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:13] constrainedToSize:CGSizeMake(265, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height+30-15;
    
    height+=home.contentHeight;
    
    return height;
}

+(float) heightWithTitle:(NSString*) title content:(NSString*) content
{
    float height=242;
    
    height+=[title sizeWithFont:[UIFont fontWithName:@"Avenir-Heavy" size:13] constrainedToSize:CGSizeMake(284, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height;
    height+=[title sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:13] constrainedToSize:CGSizeMake(257, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height;
    
    return height;
}

+(NSString *)reuseIdentifier
{
    return @"HomeInfoCell";
}

- (IBAction)btnGoToTouchUpInside:(id)sender {
    [self.delegate homeInfoCellTouchedGoTo:_home6?_home6:_home7];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    imgvCover.transform=CGAffineTransformMakeScale(0.99f, 1);
}

@end

@implementation ButtonGoTo

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if(!imgLeft)
    {
        imgLeft=[UIImage imageNamed:@"button_green_left_home.png"];
        imgMid=[UIImage imageNamed:@"button_green_mid_home.png"];
        imgRight=[UIImage imageNamed:@"button_green_right_home.png"];
        imgIcon=[UIImage imageNamed:@"icon_go.png"];
    }
    
    [imgLeft drawAtPoint:CGPointZero];
    [imgMid drawAsPatternInRect:CGRectMake(imgLeft.size.width, 0, rect.size.width-imgLeft.size.width-imgRight.size.width, rect.size.height)];
    [imgRight drawAtPoint:CGPointMake(rect.size.width-imgRight.size.width, 0)];
    [imgIcon drawAtPoint:CGPointMake(rect.size.width-imgRight.size.width-imgIcon.size.width/2, (rect.size.height-imgIcon.size.height)/2)];
}

@end