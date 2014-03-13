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
    imgvFrame.hidden=false;
    imgvFrame.image=[UIImage imageNamed:@"icon_avashop_home.png"];
    imgv.hidden=true;
    [imgv loadShopLogoPromotionHome:home.logo completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if(image)
        {
            imgv.hidden=false;
            imgv.image=image;
            imgvFrame.hidden=false;
            imgvFrame.image=[UIImage imageNamed:@"frame_avashop_home.png"];
        }
        else
        {
            imgv.hidden=true;
            imgvFrame.hidden=false;
            imgvFrame.image=[UIImage imageNamed:@"icon_avashop_home.png"];
        }
    }];
    lbl.text=home.content;
}

-(void) loadWithHome8:(UserHome8 *)home
{
    imgvFrame.hidden=false;
    imgvFrame.image=[UIImage imageNamed:@"icon_avashop_home.png"];
    imgv.hidden=true;
    [imgv loadShopLogoPromotionHome:home.shop.logo completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if(image)
        {
            imgv.hidden=false;
            imgv.image=image;
            imgvFrame.hidden=false;
            imgvFrame.image=[UIImage imageNamed:@"frame_avashop_home.png"];
        }
        else
        {
            imgv.hidden=true;
            imgvFrame.hidden=false;
            imgvFrame.image=[UIImage imageNamed:@"icon_avashop_home.png"];
        }
    }];
    
    lbl.text=home.content;
}

+(float)heightWithHome1:(UserHome1 *)home
{
    return [HomePromotionCell heightWithContent:home.content];
}

+(float) heightWithContent:(NSString*) content
{
    float height=69;
    return height;
    height+=MAX(0,[content sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:13] constrainedToSize:CGSizeMake(236, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height-35);
    
    height=MIN(height,61);
    
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
