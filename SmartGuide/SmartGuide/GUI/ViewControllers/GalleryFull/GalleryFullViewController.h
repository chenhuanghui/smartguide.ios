//
//  GalleryFullViewController.h
//  SmartGuide
//
//  Created by MacMini on 22/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "GalleryFullCell.h"

@class GalleryFullViewController,GalleryFullGridCell,CollectionViewGalleryFull;

@protocol GalleryFullProtocol <NSObject>

-(id) galleryItemAtIndex:(int) index;

@end

@protocol GalleryFullControllerDelegate <SGViewControllerDelegate>

-(void) galleryFullTouchedBack:(GalleryFullViewController*) controller;

@end

@interface GalleryFullViewController : SGViewController<UICollectionViewDataSource,UICollectionViewDelegate,GalleryFullProtocol,UIScrollViewDelegate>
{
    __weak IBOutlet CollectionViewGalleryFull *collView;
    __weak SGViewController *_parentController;
    id _selectedGallery;
    __weak Shop *_shop;
}

-(GalleryFullViewController*) initWithShop:(Shop*) shop;

-(void) setParentController:(SGViewController*) parentController;
-(void) show;
-(id) selectedObject;
-(void) setSelectedObject:(id) selectedObject;

@property (nonatomic, weak) id<GalleryFullControllerDelegate> delegate;

@end

@interface ShopGalleryFullViewController : GalleryFullViewController
{
}

@end

@interface UserGalleryFullViewController : GalleryFullViewController
{
}

@end

@interface CollectionViewGalleryFull : UICollectionView
{
}

@end