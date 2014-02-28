//
//  ShopPinInfoView.m
//  SmartGuide
//
//  Created by MacMini on 28/02/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopPinInfoView.h"
#import "Utility.h"

@implementation ShopPinInfoView

- (id)init
{
    self = [[NSBundle mainBundle] loadNibNamed:@"ShopPinInfoView" owner:nil options:nil][0];
    if (self) {
        btnArrow.transform=CGAffineTransformMakeScale(-1, 1);
    }
    
    return self;
}

-(void)setShop:(ShopList *)shop
{
    _shop=shop;
    
    lblShopName.text=shop.shopName;
    [lblShopName sizeToFit];
    
    lblShopType.text=shop.shopTypeDisplay;
    [lblShopName sizeToFit];
    
    [lblShopType l_v_setY:lblShopName.l_v_h];
    
    [self l_v_setH:lblShopType.l_v_y+lblShopType.l_v_h];
    [self l_v_setW:MAX(lblShopType.l_v_w, lblShopName.l_v_w)+44+5];
    [self l_v_setX:-self.l_v_w/2];
    
    [self addShadow:cornerView.layer.cornerRadius];
}

-(void)setShopUser:(Shop *)shop
{
    lblShopName.text=shop.shopName;
    [lblShopName sizeToFit];
    
    lblShopType.text=shop.shopTypeDisplay;
    [lblShopName sizeToFit];
    
    [lblShopType l_v_setY:lblShopName.l_v_h];
    
    [self l_v_setH:lblShopType.l_v_y+lblShopType.l_v_h];
    [self l_v_setW:MAX(lblShopType.l_v_w, lblShopName.l_v_w)+44+5];
    [self l_v_setX:-self.l_v_w/2];
    
    [self addShadow:cornerView.layer.cornerRadius];
}

-(ShopList *)shop
{
    return _shop;
}

@end
