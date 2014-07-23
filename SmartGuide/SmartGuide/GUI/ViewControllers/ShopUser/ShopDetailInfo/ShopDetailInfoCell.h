//
//  ShopDetailInfoCell.h
//  SmartGuide
//
//  Created by MacMini on 23/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@class ShopDetailInfoCell, Shop;

@interface ShopDetailInfoCell : UITableViewCell<TableViewCellDynamicHeight>
{
    __weak IBOutlet UILabel *lblShopName;
    __weak IBOutlet UIButton *btnShopType;
    __weak IBOutlet UILabel *lblFullAddress;
    __weak IBOutlet UIImageView *line;
}

-(void) loadWithShop:(Shop*) shop;

+(NSString *)reuseIdentifier;

@end

@interface UITableView(ShopDetailInfoCell)

-(void) registerShopDetailInfoCell;
-(ShopDetailInfoCell*) shopDetailInfoCell;

@end