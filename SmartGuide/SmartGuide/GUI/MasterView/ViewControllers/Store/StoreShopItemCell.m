//
//  StoreShopItemCell.m
//  SmartGuide
//
//  Created by MacMini on 09/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "StoreShopItemCell.h"

@implementation StoreShopItemCell

- (id)init
{
    self = [[NSBundle mainBundle] loadNibNamed:[StoreShopItemCell reuseIdentifier] owner:nil options:nil][0];
    if (self) {
        
    }
    return self;
}

+(NSString *)reuseIdentifier
{
    return @"StoreShopItemCell";
}

+(CGSize)size
{
    return CGSizeMake(163, 131);
}

@end
