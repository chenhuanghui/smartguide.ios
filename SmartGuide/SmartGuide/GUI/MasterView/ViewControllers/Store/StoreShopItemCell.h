//
//  StoreShopItemCell.h
//  SmartGuide
//
//  Created by MacMini on 09/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonPrice.h"
#import "StoreShopItem.h"

@interface StoreShopItemCell : UIView
{
    __weak IBOutlet UIImageView *imgvLineVer;
    __weak IBOutlet UIImageView *imgvHor1;
    __weak IBOutlet UIImageView *imgvHor2;
    __weak IBOutlet UIImageView *imgvItem;
    __weak IBOutlet UIButton *btnBuy;
    __weak IBOutlet ButtonPrice *btnPrice;
    __weak IBOutlet UIButton *btnMore;
    __weak IBOutlet UILabel *lblName;
    __weak IBOutlet UIView *imageContainView;
    __weak IBOutlet UIView *displayView;
    __weak IBOutlet UIActivityIndicatorView *indicator;
}

-(void) loadWithItem:(StoreShopItem*) item;
-(void) loadingCell;
-(void) emptyCell;

+(NSString *)reuseIdentifier;
+(CGSize) size;

@end