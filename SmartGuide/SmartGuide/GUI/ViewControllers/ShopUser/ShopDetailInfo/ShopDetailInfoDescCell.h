//
//  ShopDetailInfoDescCell.h
//  SmartGuide
//
//  Created by MacMini on 16/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

enum SHOP_DETAIL_INFO_DESCRIPTION_MODE {
    SHOP_DETAIL_INFO_DESCRIPTION_NORMAL = 0,
    SHOP_DETAIL_INFO_DESCRIPTION_FULL = 1,
};

@class ShopDetailInfoDescCell, Shop;

@protocol ShopDetailInfoDescCellDelegate <NSObject>

-(void) shopDetailInfoDescCellTouchedReadMore:(ShopDetailInfoDescCell*) cell;
-(void) shopDetailInfoDescCellTouchedReadLess:(ShopDetailInfoDescCell*) cell;

@end

@interface ShopDetailInfoDescCell : UITableViewCell<TableViewCellDynamicHeight>
{
    __weak IBOutlet UILabel *lbl;
    __weak IBOutlet UIView *lblView;
    __weak IBOutlet UIButton *btn;
    __weak IBOutlet UIImageView *blur;
    
    enum SHOP_DETAIL_INFO_DESCRIPTION_MODE _mode;
    __weak Shop *_shop;
    bool _isAnimation;
}

-(void) loadWithShop:(Shop*) shop mode:(enum SHOP_DETAIL_INFO_DESCRIPTION_MODE) mode;
-(bool) canReadMore;
-(void) switchToMode:(enum SHOP_DETAIL_INFO_DESCRIPTION_MODE) mode duration:(float) duration;

+(NSString *)reuseIdentifier;

@property (nonatomic, weak) id<ShopDetailInfoDescCellDelegate> delegate;

@end

@interface UITableView(ShopDetailInfoDescCell)

-(void) registerShopDetailInfoDescCell;
-(ShopDetailInfoDescCell*) shopDetailInfoDescCell;

@end