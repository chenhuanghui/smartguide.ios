//
//  SUInfoCell.h
//  SmartGuide
//
//  Created by MacMini on 04/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shop.h"
#import "LabelTopText.h"

@class ShopInfoControllerCell;

@protocol ShopInfoControllerCellDelegate <NSObject>

-(void) shopInfoControllerCellTouchedMap:(ShopInfoControllerCell*) cell;

@end

@interface ShopInfoControllerCell : UICollectionViewCell
{
    __weak IBOutlet LabelTopText *lblAddress;
    __weak IBOutlet UIButton *btnTel;
    __weak IBOutlet UIImageView *line;
    
    __weak Shop *_shop;
}

-(void) loadWithShop:(Shop*) shop;

+(float) heightWithShop:(Shop*) shop;
+(NSString *)reuseIdentifier;

@property (nonatomic, weak) id<ShopInfoControllerCellDelegate> delegate;

@end

@interface ShopInfoControllerCellBackground : UIView

@end

@interface UICollectionView(ShopInfoControllerCell)

-(void) registerShopInfoControllerCell;
-(ShopInfoControllerCell*) shopInfoControllerCellWithIndexPath:(NSIndexPath*) indexPath;

@end