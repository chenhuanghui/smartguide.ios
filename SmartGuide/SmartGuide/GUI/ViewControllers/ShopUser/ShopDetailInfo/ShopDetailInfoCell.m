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
#import "Shop.h"

@interface ShopDetailInfoCell()
{
    __weak Shop *_shop;
}

@end

@implementation ShopDetailInfoCell
@synthesize suggestHeight,isCalculatingSuggestHeight;

-(void)loadWithShop:(Shop *)shop
{
    _shop=shop;
}

-(void)calculatingSuggestHeight
{
    [self layoutSubviews];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    suggestHeight=0;
    
    [lblShopName l_v_setW:272];
    [lblFullAddress l_v_setW:272];
    
    lblShopName.text=_shop.shopName;
    [lblShopName sizeToFit];
    
    if(lblShopName.l_v_h<=20 && lblShopName.l_v_w<272)
        [lblShopName l_v_setW:272];
    
    [btnShopType setTitle:_shop.shopTypeDisplay forState:UIControlStateNormal];
    [btnShopType setImage:[[ImageManager sharedInstance] shopImageTypeWithType:_shop.enumShopType] forState:UIControlStateNormal];
    
    [btnShopType l_v_setY:19+lblShopName.l_v_h];
    [line l_v_setY:44+lblShopName.l_v_h];
    [lblFullAddress l_v_setY:55+lblShopName.l_v_h];
    [lblFullAddress sizeToFit];
    
    suggestHeight=lblFullAddress.l_v_y+lblFullAddress.l_v_h;
    
    suggestHeight+=20;// align top button back
}

+(NSString *)reuseIdentifier
{
    return @"ShopDetailInfoCell";
}

@end

@implementation UITableView(ShopDetailInfoCell)

-(void)registerShopDetailInfoCell
{
    [self registerNib:[UINib nibWithNibName:[ShopDetailInfoCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopDetailInfoCell reuseIdentifier]];
}

-(ShopDetailInfoCell *)shopDetailInfoCell
{
    return [self dequeueReusableCellWithIdentifier:[ShopDetailInfoCell reuseIdentifier]];
}

@end