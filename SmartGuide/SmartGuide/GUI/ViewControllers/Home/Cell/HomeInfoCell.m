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
#import "UserHome6.h"
#import "UserPromotion.h"

@implementation HomeInfoCell
@synthesize delegate, suggestHeight;

-(void)loadWithHome6:(UserHome6 *)home
{
    _obj=home;
    
    [self setNeedsLayout];
}

-(void)loadWithUserPromotion:(UserPromotion *)obj
{
    _obj=obj;
    
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if([_obj isKindOfClass:[UserHome6 class]])
    {
        UserHome6 *home=_obj;
        
        if(!home.contentAttribute)
        {
            home.contentAttribute=[[NSAttributedString alloc] initWithString:home.content attributes:@{NSFontAttributeName:lblContent.font
                                                                                                       , NSParagraphStyleAttributeName:[NSMutableParagraphStyle paraStyleWithTextAlign:NSTextAlignmentJustified]}];
        }
        
        [imgvLogo loadImageHomeWithURL:home.logo];
        [btnName setTitle:home.shopName forState:UIControlStateNormal];
        lblDate.text=home.date;
        lblTitle.text=home.title;
        lblContent.attributedText=home.contentAttribute;
        lblGoTo.text=home.gotoshop;
        
        [imgvCover l_v_setH:CGSizeResizeToWidth(imgvCover.l_v_w, CGSizeMake(home.coverWidth.floatValue, home.coverHeight.floatValue)).height];
        
        [imgvCover loadHome6CoverWithURL:home.cover];
    }
    else if([_obj isKindOfClass:[UserPromotion class]])
    {
        UserPromotion *obj=_obj;
        
        if(!obj.contentAttribute)
        {
            obj.contentAttribute=[[NSAttributedString alloc] initWithString:obj.desc attributes:@{NSFontAttributeName:lblContent.font
                                                                                                  , NSParagraphStyleAttributeName:[NSMutableParagraphStyle paraStyleWithTextAlign:NSTextAlignmentJustified]}];
        }
        
        [imgvLogo loadShopLogoPromotionHome:obj.logo];
        [btnName setTitle:obj.brandName forState:UIControlStateNormal];
        lblDate.text=obj.date;
        lblTitle.text=obj.title;
        lblContent.attributedText=obj.contentAttribute;
        lblGoTo.text=obj.goTo;
        
        if(CGSizeEqualToSize(obj.homeSize, CGSizeZero))
            obj.homeSize=CGSizeMake(imgvCover.l_v_w, MAX(0,imgvCover.l_v_w*obj.coverHeight.floatValue/obj.coverWidth.floatValue));
        
        [imgvCover l_v_setH:obj.homeSize.height];
        [imgvCover loadUserPromotionCoverWithURL:obj.cover];
    }
    
    btnName.frame=CGRectMake(56, 10, 238, 0);
    [btnName sizeToFitTitle];
    
    lblDate.frame=CGRectMake(56, btnName.l_v_y+btnName.l_v_h+5, 238, 0);
    [lblDate sizeToFit];
    [lblDate l_v_setW:238];
    
    btnCover.frame=imgvCover.frame;
    
    float y=btnCover.l_v_y+btnCover.l_v_h;
    
    if(btnCover.l_v_h>0)
        y+=12;
    
    lblTitle.frame=CGRectMake(16, y, 275, 0);
    [lblTitle sizeToFit];
    
    y=lblTitle.l_v_y+lblTitle.l_v_h;
    
    if(lblTitle.l_v_h>0)
        y+=5;
    
    lblContent.frame=CGRectMake(26, y, 265, 0);
    [lblContent sizeToFit];
    
    y=lblContent.l_v_y+lblContent.l_v_h;
    
    if(lblContent.l_v_h>0)
        y+=20;
    
    [lblGoTo l_v_setY:y];
    [btnGoTo l_v_setY:y];

    lblGoTo.hidden=lblGoTo.text.length==0;
    btnGoTo.hidden=lblGoTo.hidden;
    
    UIView *botView=nil;
    
    if(btnGoTo.hidden)
        botView=lblContent;
    else
        botView=btnGoTo;
    
    suggestHeight=botView.l_v_y+botView.l_v_h+40;
}

-(IBAction) btnCoverTouchRepear:(id) sender event:(UIEvent*) event
{
    UITouch *touch=[[event allTouches] anyObject];
    if(touch.tapCount==2)
        [self btnGoToTouchUpInside:btnGoTo];
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

@implementation UITableView(HomeInfoCell)

-(void)registerHomeInfoCell
{
    [self registerNib:[UINib nibWithNibName:[HomeInfoCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[HomeInfoCell reuseIdentifier]];
}

-(HomeInfoCell *)homeInfoCell
{
    return [self dequeueReusableCellWithIdentifier:[HomeInfoCell reuseIdentifier]];
}

@end