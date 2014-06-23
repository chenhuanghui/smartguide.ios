//
//  ShopDetailInfoCell.m
//  SmartGuide
//
//  Created by MacMini on 23/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopDetailInfoCell.h"
#import "Utility.h"
#import "ImageManager.h"

@implementation ShopDetailInfoCell

-(void)loadWithShop:(Shop *)shop
{
    lblShopName.text=shop.shopName;
    [btnShopType setTitle:shop.shopTypeDisplay forState:UIControlStateNormal];
    [btnShopType setImage:[[ImageManager sharedInstance] shopImageTypeWithType:shop.enumShopType] forState:UIControlStateNormal];
    lblFullAddress.text=shop.address;
    
    [line l_v_setY:44+shop.shopNameHeight.floatValue];
    [btnShopType l_v_setY:19+shop.shopNameHeight.floatValue];
    [lblFullAddress l_v_setY:55+shop.shopNameHeight.floatValue];
}

+(NSString *)reuseIdentifier
{
    return @"ShopDetailInfoCell";
}

+(float)heightWithShop:(Shop *)shop
{
    float height=75;
    
    if(shop.shopNameHeight.floatValue==-1)
    shop.shopNameHeight=@([shop.shopName sizeWithFont:FONT_SIZE_BOLD(14) constrainedToSize:CGSizeMake(272, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail].height);
    
    height+=shop.shopNameHeight.floatValue;
    
    if(shop.addressHeightforShopDetailInfo.floatValue==-1)
    shop.addressHeightforShopDetailInfo=@([shop.address sizeWithFont:FONT_SIZE_NORMAL(12) constrainedToSize:CGSizeMake(272, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail].height);
    
    height+=shop.addressHeightforShopDetailInfo.floatValue;
    
    return height;
}

@end
