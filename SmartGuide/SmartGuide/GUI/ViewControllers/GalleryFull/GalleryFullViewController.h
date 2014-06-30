//
//  GalleryFullViewController.h
//  SmartGuide
//
//  Created by MacMini on 22/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class GalleryFullViewController,GalleryFullCollectionView, Shop;

@protocol GalleryFullControllerDelegate <SGViewControllerDelegate>

-(void) galleryFullTouchedBack:(GalleryFullViewController*) controller;

@end

@interface GalleryFullViewController : SGViewController
{
    __weak IBOutlet GalleryFullCollectionView *collView;
    __weak Shop *_shop;
    __weak UITapGestureRecognizer *tapCollView;
}

-(GalleryFullViewController*) initWithShop:(Shop*) shop;
-(id) galleryAtIndex:(int) index;
-(id) currentGallery;
-(Shop*) shop;

@property (nonatomic, weak) id<GalleryFullControllerDelegate> delegate;

@end

@interface GalleryFullCollectionView : UICollectionView

@end

@interface ShopGalleryFullViewController : GalleryFullViewController
{
}

@end

@interface UserGalleryFullViewController : GalleryFullViewController
{
}

@end