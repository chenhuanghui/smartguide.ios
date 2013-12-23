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

enum SHOP_DETAIL_INFO_DESCRIPTION_MODE {
    SHOP_DETAIL_INFO_DESCRIPTION_NORMAL = 0,
    SHOP_DETAIL_INFO_DESCRIPTION_FULL = 1,
    };

@class ShopDetailInfoCell;

@protocol ShopDetailInfoCellDelegate <NSObject>

-(void) detailInfoCellTouchedMore:(ShopDetailInfoCell*) cell;

@end

@interface ShopDetailInfoCell : UITableViewCell
{
    __weak IBOutlet UILabel *lblShopName;
    __weak IBOutlet UILabel *lblShopType;
    __weak IBOutlet UIImageView *imgvIcon;
    __weak IBOutlet LabelTopText *lblFullAddress;
    __weak IBOutlet LabelTopText *lblIntro;
    __weak IBOutlet UIButton *btnMore;
}

-(void) loadWithShop:(Shop*) shop height:(float) height mode:(enum SHOP_DETAIL_INFO_DESCRIPTION_MODE) mode;
-(void) loadWithShopList:(ShopList*) shop height:(float) height mode:(enum SHOP_DETAIL_INFO_DESCRIPTION_MODE) mode;

+(NSString *)reuseIdentifier;
+(float) heightWithContent:(NSString*) content mode:(enum SHOP_DETAIL_INFO_DESCRIPTION_MODE) mode;

@property (nonatomic, weak) id<ShopDetailInfoCellDelegate> delegate;

@end
