//
//  SUUserGalleryCell.h
//  SmartGuide
//
//  Created by MacMini on 04/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shop.h"
#import "ShopUserGallery.h"
#import "GMGridView.h"

@class ShopUserGalleryControllerCell,UserGalleryGridView,UserGalleryUpload;

@protocol ShopUserGalleryControllerCellDelegate <NSObject>

-(void) shopUserGalleryControllerCellTouchedMakePicture:(ShopUserGalleryControllerCell*) cell;
-(void) shopUserGalleryControllerCellTouchedGallery:(ShopUserGalleryControllerCell*) cell gallery:(ShopUserGallery*) gallery;
-(void) shopUserGalleryControllerCellTouchedUpload:(ShopUserGalleryControllerCell*) cell gallery:(UserGalleryUpload*) upload;

@end

@interface ShopUserGalleryControllerCell : UITableViewCell<GMGridViewActionDelegate,GMGridViewDataSource,UIScrollViewDelegate>
{
    __weak Shop* _shop;
    __weak IBOutlet UserGalleryGridView *grid;
    __weak IBOutlet UIImageView *imgvFirsttime;
    __weak IBOutlet UIButton *btnLeft;
    __weak IBOutlet UIButton *btnRight;

    NSMutableArray *_galleries;
    int _galleriesCount;
}

-(void) loadWithShop:(Shop*) shop;

+(float) height;
+(NSString *)reuseIdentifier;

@property (nonatomic, weak) id<ShopUserGalleryControllerCellDelegate> delegate;

@end

@interface UserGalleryGridView : GMGridView<UIGestureRecognizerDelegate>

@end

@interface UITableView(ShopUserGalleryControllerCell)

-(void) registerShopUserGalleryControllerCell;
-(ShopUserGalleryControllerCell*) shopUserGalleryControllerCell;

@end