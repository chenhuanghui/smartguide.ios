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
    
    [line l_v_setY:44+shop.shopNameHeight];
    [btnShopType l_v_setY:19+shop.shopNameHeight];
    [lblFullAddress l_v_setY:55+shop.shopNameHeight];
}

+(NSString *)reuseIdentifier
{
    return @"ShopDetailInfoCell";
}

+(float)heightWithShop:(Shop *)shop
{
    float height=75;
    
    shop.shopNameHeight=[shop.shopName sizeWithFont:[UIFont fontWithName:@"Avenir-Heavy" size:14] constrainedToSize:CGSizeMake(242, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height;
    height+=shop.shopNameHeight;
    
    shop.addressHeight=[shop.address sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:12] constrainedToSize:CGSizeMake(242, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height;
    height+=shop.addressHeight;
    
    return height;
}

@end
