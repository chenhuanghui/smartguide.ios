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

+(float)heightWithHome1:(UserHome1 *)home
{
    return [HomePromotionCell heightWithContent:home.content];
}

+(float) heightWithContent:(NSString*) content
{
    float height=61;
    height+=[content sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:13] constrainedToSize:CGSizeMake(236, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height-35;
    
    height=MAX(61,height);
    
    return height;
}

+(float)heightWithHome8:(UserHome8 *)home
{
    return [HomePromotionCell heightWithContent:home.content];
}

+(NSString *)reuseIdentifier
{
    return @"HomePromotionCell";
}

@end
