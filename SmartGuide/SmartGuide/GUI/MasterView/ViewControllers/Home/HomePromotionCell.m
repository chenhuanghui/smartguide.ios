//
//  NewFeedPromotionCell.m
//  SmartGuide
//
//  Created by MacMini on 24/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "HomePromotionCell.h"
#import "ImageManager.h"
#import "Constant.h"
#import "Utility.h"

@implementation HomePromotionCell

-(void)loadWithHome1:(UserHome1 *)home
{
    [imgv loadShopLogoWithURL:home.logo];
    lbl.text=home.content;
}

-(void) loadWithHome8:(UserHome8 *)home
{
    [imgv loadShopLogoWithURL:home.shop.logo];
    lbl.text=home.content;
}

-(void)alignContent
{
    float height=MAX(self.l_v_h-10,53-NEW_FEED_CELL_SPACING);
    
    [bg l_v_setH:height];
}

+(float)heightWithHome1:(UserHome1 *)home
{
    UIFont *font=[UIFont fontWithName:@"Avenir-Roman" size:13];
    float height=6;
    height+=[home.content sizeWithFont:font constrainedToSize:CGSizeMake(202, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height+15;
    
    return MAX(height,53+NEW_FEED_CELL_SPACING);
}

+(float)heightWithHome8:(UserHome8 *)home
{
    UIFont *font=[UIFont fontWithName:@"Avenir-Roman" size:13];
    float height=6;
    height+=[home.content sizeWithFont:font constrainedToSize:CGSizeMake(202, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height+15;
    
    return MAX(height,53+NEW_FEED_CELL_SPACING);
}

+(NSString *)reuseIdentifier
{
    return @"HomePromotionCell";
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    bg.layer.cornerRadius=2;
    bg.layer.masksToBounds=true;
}

@end
