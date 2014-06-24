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
    [btnName setTitle:home.shopName forState:UIControlStateNormal];
    lblDate.text=home.date;
    lblTitle.text=home.title;
//    lblContent.text=home.content;
    
    NSMutableParagraphStyle *paraStyle=[NSMutableParagraphStyle new];
    paraStyle.alignment=NSTextAlignmentJustified;
    lblContent.attributedText=[[NSAttributedString alloc] initWithString:home.content attributes:@{NSParagraphStyleAttributeName:paraStyle}];
    
    lblGoTo.text=home.gotoshop;
    
    [self makeButtonSize];

    [imgvCover l_v_setH:home.homeSize.height];
    [btnCover l_v_setH:home.homeSize.height];
    [lblTitle l_v_setY:imgvCover.l_v_y+imgvCover.l_v_h+5];
    [lblTitle l_v_setH:home.titleHeight];
    
    [lblContent l_v_setY:lblTitle.l_v_y+lblTitle.l_v_h+5];
    [lblContent l_v_setH:home.contentHeight];
    
    [imgvCover loadHome6CoverWithURL:home.cover];
}

-(void)loadWithUserPromotion:(UserPromotion *)obj
{
    _obj=obj;
    
    [imgvLogo loadShopLogoPromotionHome:obj.logo];
    [btnName setTitle:obj.brandName forState:UIControlStateNormal];
    lblDate.text=obj.date;
    lblTitle.text=obj.title;
    NSMutableParagraphStyle *paraStyle=[NSMutableParagraphStyle new];
    paraStyle.alignment=NSTextAlignmentJustified;
    lblContent.attributedText=[[NSAttributedString alloc] initWithString:obj.desc attributes:@{NSParagraphStyleAttributeName:paraStyle}];
    
    lblGoTo.text=obj.goTo;
    
    [self makeButtonSize];
    
    [imgvCover l_v_setH:obj.homeSize.height];
    [btnCover l_v_setH:obj.homeSize.height];
    [lblTitle l_v_setY:imgvCover.l_v_y+imgvCover.l_v_h+5];
    [lblTitle l_v_setH:obj.titleHeight];

    [lblContent l_v_setY:lblTitle.l_v_y+lblTitle.l_v_h+5];
    [lblContent l_v_setH:obj.contentHeight];

    [imgvCover loadUserPromotionCoverWithURL:obj.cover];
}

-(IBAction) btnCoverTouchRepear:(id) sender event:(UIEvent*) event
{
    UITouch *touch=[[event allTouches] anyObject];
    if(touch.tapCount==2)
        [self btnGoToTouchUpInside:btnGoTo];
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
    height+=home.homeSize.height;
    
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
    height+=obj.homeSize.height;
    
    return height;
}

+(NSString *)reuseIdentifier
{
    return @"HomeInfoCell";
}

- (IBAction)btnGoToTouchUpInside:(id)sender {
    [self.delegate homeInfoCellTouchedGoTo:_obj];
}

- (IBAction)btnNameTouchUpInside:(id)sender {
    [self.delegate homeInfoCellTouchedGoTo:_obj];
}

- (IBAction)btnLogoTouchUpInside:(id)sender {
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