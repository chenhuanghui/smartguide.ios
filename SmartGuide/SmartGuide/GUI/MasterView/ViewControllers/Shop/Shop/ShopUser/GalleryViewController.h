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

@class GalleryViewController;

@protocol ShopGalleryControllerDelegate <SGViewControllerDelegate>

-(void) shopGalleryTouchedGallery:(GalleryViewController*) controller gallery:(id) gallery;

@end

@interface GalleryViewController : SGViewController<GMGridViewActionDelegate,GMGridViewDataSource,UIScrollViewDelegate>
{
    __weak IBOutlet GMGridView *grid;
    __weak Shop *_shop;
    id _selectedGallery;
    
    bool _canLoadMore;
    bool _isLoadingMore;
    int _page;
}

-(GalleryViewController*) initWithShop:(Shop*) shop;
-(void) setSelectedGallery:(id) selectedGallery;
-(void) reloadImage;
-(id) galleryAtIndex:(int) index;

@property (nonatomic, weak) id<ShopGalleryControllerDelegate> delegate;

@end

@interface ShopGalleryViewController : GalleryViewController
{
}

@end

@interface UserGalleryViewController : GalleryViewController

@end