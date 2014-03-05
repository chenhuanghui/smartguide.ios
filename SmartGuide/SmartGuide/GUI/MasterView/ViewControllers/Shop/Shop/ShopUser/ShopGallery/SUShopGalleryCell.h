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

@class SUShopGalleryCell;

@protocol SUShopGalleryDelegate <NSObject>

-(void)suShopGalleryTouchedMoreInfo:(SUShopGalleryCell*) cell;
-(void)suShopGalleryTouchedCover:(SUShopGalleryCell*) cell object:(ShopGallery*) gallery;

@end

@interface SUShopGalleryCell : UITableViewCell<UIScrollViewDelegate,ButtonLoveDelegate,ASIOperationPostDelegate,UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UITableView *table;
    __weak IBOutlet PageControlNext *pageControl;
    __weak IBOutlet UIView *bgLineStatus;
    __weak ButtonLove *btnLove;
    __weak IBOutlet UILabel *lblShopName;
    __weak IBOutlet UILabel *lblShopType;
    __weak IBOutlet UILabel *lblNumOfView;
    __weak IBOutlet UILabel *lblNumOfComment;
    __weak IBOutlet UIImageView *imgvShopLogo;
    
    CGRect _tableFrame;
    
    __weak Shop *_shop;
    ASIOperationLoveShop *_operationLoveShop;
}

-(void) loadWithShop:(Shop*) shop;

@property (nonatomic, weak) id<SUShopGalleryDelegate> delegate;

+(NSString *)reuseIdentifier;
+(float) height;

@end

@interface BGShopGalleryView : UIView

@end