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
    lblShopType.text=shop.shopTypeDisplay;
    lblFullAddress.text=[NSString stringWithFormat:@"%@, %@", shop.address, shop.city];
}

-(void)loadWithShopList:(ShopList *)shop
{
    lblShopName.text=shop.shopName;
    lblShopType.text=shop.shopTypeDisplay;
    lblFullAddress.text=shop.address;
}

+(NSString *)reuseIdentifier
{
    return @"ShopDetailInfoCell";
}

+(float)height
{
    return 123;
}

@end
