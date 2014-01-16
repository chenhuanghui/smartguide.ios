//
//  ShopDetailInfoCell.h
//  SmartGuide
//
//  Created by MacMini on 23/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shop.h"
#import "ShopList.h"
#import "LabelTopText.h"
#import "InfoTypeBGView.h"

@class ShopDetailInfoCell;

@interface ShopDetailInfoCell : UITableViewCell
{
    __weak IBOutlet UILabel *lblShopName;
    __weak IBOutlet UILabel *lblShopType;
    __weak IBOutlet UIImageView *imgvIcon;
    __weak IBOutlet LabelTopText *lblFullAddress;
}

-(void) loadWithShop:(Shop*) shop;
-(void) loadWithShopList:(ShopList*) shop;

+(NSString *)reuseIdentifier;
+(float) height;

@end
