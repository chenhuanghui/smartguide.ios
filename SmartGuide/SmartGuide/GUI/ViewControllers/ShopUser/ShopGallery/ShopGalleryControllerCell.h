//
//  SUShopGalleryCell.h
//  SmartGuide
//
//  Created by MacMini on 04/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageControl.h"
#import "ButtonLove.h"
#import "ShopList.h"
#import "Shop.h"
#import "ASIOperationLoveShop.h"

@class ShopGalleryControllerCell;

@protocol ShopGalleryControllerCellDelegate <NSObject>

-(void)shopGalleryControllerCellTouchedMoreInfo:(ShopGalleryControllerCell*) cell;
-(void)shopGalleryControllerCellTouchedCover:(ShopGalleryControllerCell*) cell object:(ShopGallery*) gallery;

@end

@interface ShopGalleryControllerCell : UITableViewCell
{
    __weak IBOutlet UICollectionView *collection;
    __weak IBOutlet PageControlNext *pageControl;
    __weak IBOutlet UIView *bgLineStatus;
    __weak ButtonLove *btnLove;
    __weak IBOutlet UILabel *lblShopName;
    __weak IBOutlet UILabel *lblShopType;
    __weak IBOutlet UILabel *lblNumOfView;
    __weak IBOutlet UILabel *lblNumOfComment;
    __weak IBOutlet UIImageView *imgvShopLogo;
    
    __weak Shop *_shop;
    ASIOperationLoveShop *_operationLoveShop;
}

-(void) loadWithShop:(Shop*) shop;
-(void) scrollViewDidScroll:(UIScrollView*) scrollView;

@property (nonatomic, weak) id<ShopGalleryControllerCellDelegate> delegate;

+(NSString *)reuseIdentifier;
+(float) height;

@end

@interface UITableView(ShopGalleryController)

-(void) registerShopGalleryControllerCell;
-(ShopGalleryControllerCell*) shopGalleryControllerCell;

@end

@interface BGShopGalleryView : UIView

@end