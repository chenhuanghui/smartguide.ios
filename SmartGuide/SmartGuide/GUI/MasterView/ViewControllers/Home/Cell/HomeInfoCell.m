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
    
    
    
//    [imgvCover l_v_setH:home.coverHeight.floatValue];
    [lblContent l_v_setY:165+home.titleHeight+home.coverHeight.floatValue];
    [lblTitle l_v_setY:145+home.coverHeight.floatValue];
    [lblTitle l_v_addH:-home.coverHeight.floatValue];
    [lblContent l_v_addH:-home.coverHeight.floatValue];
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

    //    [imgvCover l_v_setH:home.coverHeight.floatValue];
    [lblContent l_v_setY:165+home.titleHeight+home.coverHeight.floatValue];
    [lblTitle l_v_setY:145+home.coverHeight.floatValue];
    [lblTitle l_v_addH:-home.coverHeight.floatValue];
    [lblContent l_v_addH:-home.coverHeight.floatValue];
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
    
    NSLog(@"%f %f %f",obj.coverHeight.floatValue,obj.titleHeight,obj.contentHeight);
    
    [lblTitle l_v_setY:145+obj.coverHeight.floatValue];
    [lblContent l_v_setY:165+obj.titleHeight+obj.coverHeight.floatValue];
    [lblTitle l_v_setH:obj.titleHeight];
    [lblContent l_v_setH:obj.contentHeight];
    [imgvCover l_v_setH:obj.coverHeight.floatValue];
    
    lblTitle.backgroundColor=[UIColor redColor];
    lblContent.backgroundColor=[UIColor blueColor];
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
    float height=164;
    
    home.titleHeight=[home.title sizeWithFont:[UIFont fontWithName:@"Georgia-Bold" size:14] constrainedToSize:CGSizeMake(275, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height-20;
    home.titleHeight=MAX(0,home.titleHeight);
    
    height+=home.titleHeight;
    
    home.contentHeight=[home.content sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:13] constrainedToSize:CGSizeMake(265, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height;
    
    height+=home.contentHeight;
    height+=home.coverHeight.floatValue;
    
    return height;
}

+(float)heightWithHome7:(UserHome7 *)home
{
    float height=164;
    
    home.titleHeight=[home.title sizeWithFont:[UIFont fontWithName:@"Georgia-Bold" size:14] constrainedToSize:CGSizeMake(275, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height-20;
    home.titleHeight=MAX(0,home.titleHeight);
    
    height+=home.titleHeight;
    
    home.contentHeight=[home.content sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:13] constrainedToSize:CGSizeMake(265, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height;
    
    height+=home.contentHeight;
    height+=home.coverHeight.floatValue;
    
    return height;
}

+(float) heightWithUserPromotion:(UserPromotion *)obj
{
    float height=164;
    
    if(obj.titleHeight==-1)
        obj.titleHeight=[obj.title sizeWithFont:[UIFont fontWithName:@"Georgia-Bold" size:14] constrainedToSize:CGSizeMake(275, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height;
    
    obj.titleHeight=MAX(0,obj.titleHeight);
    
    height+=obj.titleHeight;
    
    if(obj.contentHeight==-1)
        obj.contentHeight=[obj.desc sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:13] constrainedToSize:CGSizeMake(265, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height;
    
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