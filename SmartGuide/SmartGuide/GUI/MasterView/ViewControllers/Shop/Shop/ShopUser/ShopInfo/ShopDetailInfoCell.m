//
//  ShopDetailInfoCell.m
//  SmartGuide
//
//  Created by MacMini on 23/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopDetailInfoCell.h"

@implementation ShopDetailInfoCell

-(void)loadWithShop:(Shop *)shop
{
    lblShopName.text=shop.shopName;
    [btnShopType setTitle:shop.shopTypeDisplay forState:UIControlStateNormal];
    lblFullAddress.text=[NSString stringWithFormat:@"%@, %@", shop.address, shop.city];
}

-(void)loadWithShopList:(ShopList *)shop
{
    lblShopName.text=shop.shopName;
    [btnShopType setTitle:shop.shopTypeDisplay forState:UIControlStateNormal];
    lblFullAddress.text=shop.address;
}

+(NSString *)reuseIdentifier
{
    return @"ShopDetailInfoCell";
}

+(float)heightWithShopName:(NSString*) shopName
{
    float height=130;
    
    height+=MAX(0,[shopName sizeWithFont:[UIFont fontWithName:@"Avenir-Heavy" size:14] constrainedToSize:CGSizeMake(234, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height-21);
    
    return height;
}

@end
