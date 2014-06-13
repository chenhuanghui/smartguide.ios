//
//  ShopGalleryViewController.h
//  SmartGuide
//
//  Created by MacMini on 16/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class GalleryViewController,Shop;

@protocol GalleryControllerDelegate <SGViewControllerDelegate>

-(void) galleryControllerTouchedGallery:(GalleryViewController*) controller gallery:(id) gallery;

@end

@interface GalleryViewController : SGViewController
{
    __weak IBOutlet UICollectionView *collection;
    __weak Shop *_shop;
}

-(GalleryViewController*) initWithShop:(Shop*) shop;
-(id) galleryAtIndex:(int) index;

@property (nonatomic, weak) id<GalleryControllerDelegate> delegate;

@end

@interface ShopGalleryViewController : GalleryViewController
{
}

@end

@interface UserGalleryViewController : GalleryViewController

@end