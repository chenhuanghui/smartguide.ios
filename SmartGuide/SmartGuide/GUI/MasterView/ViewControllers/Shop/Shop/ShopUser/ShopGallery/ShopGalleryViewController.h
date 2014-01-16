//
//  ShopGalleryViewController.h
//  SmartGuide
//
//  Created by MacMini on 16/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "GMGridView.h"
#import "Shop.h"

enum SHOP_GALLERY_VIEW_MODE {
    SHOP_GALLERY_VIEW_SHOP = 0,
    SHOP_GALLERY_VIEW_USER = 1
    };

@class ShopGalleryViewController;

@protocol ShopGalleryControllerDelegate <SGViewControllerDelegate>

-(void) shopGalleryTouchedGallery:(ShopGalleryViewController*) controller gallery:(id) gallery;

@end

@interface ShopGalleryViewController : SGViewController<GMGridViewActionDelegate,GMGridViewDataSource>
{
    __weak IBOutlet GMGridView *grid;
    __weak Shop *_shop;
    enum SHOP_GALLERY_VIEW_MODE _viewMode;
    id _selectedGallery;
    
    NSArray *_data;
}

-(ShopGalleryViewController*) initWithShop:(Shop*) shop withMode:(enum SHOP_GALLERY_VIEW_MODE) viewMode;
-(void) setSelectedGallery:(id) selectedGallery;

@property (nonatomic, weak) id<ShopGalleryControllerDelegate> delegate;

@end
