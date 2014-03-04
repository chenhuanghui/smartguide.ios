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
    _obj=home;
    
    [imgvLogo loadImageHomeWithURL:home.logo];
    lblName.text=home.shopName;
    lblDate.text=home.date;
    [imgvCover loadHome6CoverWithURL:home.cover];
    lblTitle.text=home.title;
    lblContent.text=home.content;
    
    lblGoTo.text=home.gotoshop;
    
    [self makeButtonSize];
    
    
    
    [imgvCover l_v_setH:home.coverHeight.floatValue];
    [lblTitle l_v_setY:imgvCover.l_v_y+imgvCover.l_v_h+10];
    [lblTitle l_v_setH:home.titleHeight];
    
    [lblContent l_v_setY:lblTitle.l_v_y+lblTitle.l_v_h+10];
    [lblContent l_v_setH:home.contentHeight];
}

-(void)loadWithHome7:(UserHome7 *)home
{
    _obj=home;
    
    [imgvLogo loadImageHomeWithURL:home.store.logo];
    lblName.text=home.storeName;
    lblDate.text=home.date;
    [imgvCover loadHome7CoverWithURL:home.cover];
    lblTitle.text=home.title;
    lblContent.text=home.content;
    
    lblGoTo.text=home.gotostore;
    
    [self makeButtonSize];

    [imgvCover l_v_setH:home.coverHeight.floatValue];
    [lblTitle l_v_setY:imgvCover.l_v_y+imgvCover.l_v_h+10];
    [lblTitle l_v_setH:home.titleHeight];
    
    [lblContent l_v_setY:lblTitle.l_v_y+lblTitle.l_v_h+10];
    [lblContent l_v_setH:home.contentHeight];
}

-(void)loadWithUserPromotion:(UserPromotion *)obj
{
    _obj=obj;
    
    [imgvLogo loadImageHomeWithURL:obj.logo];
    lblName.text=obj.brandName;
    lblDate.text=obj.date;
    [imgvCover loadUserPromotionCoverWithURL:obj.cover];
    lblTitle.text=obj.title;
    lblContent.text=obj.desc;
    
    lblGoTo.text=obj.goTo;
    
    [self makeButtonSize];
    
    [imgvCover l_v_setH:obj.coverHeight.floatValue];
    [lblTitle l_v_setY:imgvCover.l_v_y+imgvCover.l_v_h+10];
    [lblTitle l_v_setH:obj.titleHeight];

    [lblContent l_v_setY:lblTitle.l_v_y+lblTitle.l_v_h+10];
    [lblContent l_v_setH:obj.contentHeight];
    
//    lblTitle.backgroundColor=[UIColor redColor];
//    lblContent.backgroundColor=[UIColor blueColor];
}

-(void) makeButtonSize
{
    return;
    float width=[[btnGoTo titleForState:UIControlStateNormal] sizeWithFont:btnGoTo.titleLabel.font constrainedToSize:CGSizeMake(295, 44) lineBreakMode:btnGoTo.titleLabel.lineBreakMode].width+50;
    
    [btnGoTo l_v_setW:width];
    [btnGoTo l_c_setX:self.l_v_w/2];
}

+(float)heightWithHome6:(UserHome6 *)home
{
    float height=154;
    
    if(home.titleHeight==-1)
        home.titleHeight=[home.title sizeWithFont:[UIFont fontWithName:@"Georgia-Bold" size:14] constrainedToSize:CGSizeMake(275, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height+5;
    
    home.titleHeight=MAX(0,home.titleHeight);
    
    height+=home.titleHeight;
    
    if(home.contentHeight==-1)
        home.contentHeight=[home.content sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:13] constrainedToSize:CGSizeMake(265, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height+5;
    
    height+=home.contentHeight;
    height+=home.coverHeight.floatValue;
    
    return height;
}

+(float)heightWithHome7:(UserHome7 *)home
{
    float height=154;
    
    if(home.titleHeight==-1)
        home.titleHeight=[home.title sizeWithFont:[UIFont fontWithName:@"Georgia-Bold" size:14] constrainedToSize:CGSizeMake(275, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height+5;
    
    home.titleHeight=MAX(0,home.titleHeight);
    
    height+=home.titleHeight;
    
    if(home.contentHeight==-1)
        home.contentHeight=[home.content sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:13] constrainedToSize:CGSizeMake(265, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height+5;
    
    height+=home.contentHeight;
    height+=home.coverHeight.floatValue;
    
    return height;
}

+(float) heightWithUserPromotion:(UserPromotion *)obj
{
    float height=154;
    
    if(obj.titleHeight==-1)
        obj.titleHeight=[obj.title sizeWithFont:[UIFont fontWithName:@"Georgia-Bold" size:14] constrainedToSize:CGSizeMake(275, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height+5;
    
    obj.titleHeight=MAX(0,obj.titleHeight);
    
    height+=obj.titleHeight;
    
    if(obj.contentHeight==-1)
        obj.contentHeight=[obj.desc sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:13] constrainedToSize:CGSizeMake(265, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height+5;
    
    height+=obj.contentHeight;
    height+=obj.coverHeight.floatValue;
    
    return height;
}

+(NSString *)reuseIdentifier
{
    return @"HomeInfoCell";
}

- (IBAction)btnGoToTouchUpInside:(id)sender {
    [self.delegate homeInfoCellTouchedGoTo:_obj];
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