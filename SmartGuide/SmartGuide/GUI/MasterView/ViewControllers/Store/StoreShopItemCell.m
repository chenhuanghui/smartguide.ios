//
//  StoreShopItemCell.m
//  SmartGuide
//
//  Created by MacMini on 09/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "StoreShopItemCell.h"
#import "ImageManager.h"

@implementation StoreShopItemCell
@synthesize delegate;

- (id)init
{
    self = [[NSBundle mainBundle] loadNibNamed:[StoreShopItemCell reuseIdentifier] owner:nil options:nil][0];
    if (self) {
        
    }
    return self;
}

-(void)loadingCell
{
    indicator.hidden=false;
    [indicator startAnimating];
    displayView.hidden=true;
    
    _item=nil;
}

-(void)emptyCell
{
    indicator.hidden=true;
    displayView.hidden=true;
    
    _item=nil;
}

-(void)loadWithItem:(StoreShopItem *)item
{
    displayView.hidden=false;
    indicator.hidden=true;
    
    [imgvItem loadStoreLogoWithURL:item.image];
    [btnPrice setTitle:item.price forState:UIControlStateNormal];
    lblName.text=item.desc;
    
    _item=item;
}

+(NSString *)reuseIdentifier
{
    return @"StoreShopItemCell";
}

+(CGSize)size
{
    return CGSizeMake(163, 131);
}

-(IBAction) btnBuyTouchUpInside:(id)sender
{
    [self.delegate storeShopItemTouchedBuy:_item];
}

@end
