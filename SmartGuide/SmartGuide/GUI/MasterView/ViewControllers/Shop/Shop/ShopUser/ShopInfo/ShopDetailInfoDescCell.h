//
//  ShopDetailInfoDescCell.h
//  SmartGuide
//
//  Created by MacMini on 16/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LabelTopText.h"
#import "Shop.h"

enum SHOP_DETAIL_INFO_DESCRIPTION_MODE {
    SHOP_DETAIL_INFO_DESCRIPTION_NORMAL = 0,
    SHOP_DETAIL_INFO_DESCRIPTION_FULL = 1,
};

@class ShopDetailInfoDescCell;

@protocol ShopDetailInfoDescCellDelegate <NSObject>

-(void) shopDetailInfoDescCellTouchedReadMore:(ShopDetailInfoDescCell*) cell;
-(void) shopDetailInfoDescCellTouchedReadLess:(ShopDetailInfoDescCell*) cell;

@end

@interface ShopDetailInfoDescCell : UITableViewCell
{
    __weak IBOutlet LabelTopText *lbl;
    __weak IBOutlet UIButton *btn;
    
    enum SHOP_DETAIL_INFO_DESCRIPTION_MODE _mode;
}

-(void) loadWithShop:(Shop*) shop mode:(enum SHOP_DETAIL_INFO_DESCRIPTION_MODE) mode;

+(float) heightWithShop:(Shop*) shop withMode:(enum SHOP_DETAIL_INFO_DESCRIPTION_MODE) mode;
+(NSString *)reuseIdentifier;

@property (nonatomic, weak) id<ShopDetailInfoDescCellDelegate> delegate;

@end