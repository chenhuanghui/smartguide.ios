//
//  ShopPicture.h
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shop.h"
#import "ASIOperationShopGallery.h"
#import "ASIOperationShopUserGallery.h"
#import "ShopDetailViewController.h"
#import "GridViewTemplate.h"
#import "GalleryView.h"
#import "ShopUserPose.h"

@class ShopUserGalleryView,ShopGalleryView;

@interface ShopPicture : UIView<ShopViewHandle,ASIOperationPostDelegate,GalleryViewDelegate,GridViewTemplate,ShopUserPoseDelegate>
{
    Shop *_shop;
    __weak IBOutlet GMGridView *gridShop;
    __weak IBOutlet GMGridView *gridUser;
    GridViewTemplate *templateShop;
    GridViewTemplate *templateUser;
    __weak IBOutlet UIButton *btnAdd;

//    ASIOperationShopGallery *_operationShopGallery;
    ASIOperationShopUserGallery *_operationUserGallery;
    
    bool _isTemporaryUserGallery;
    bool _isTemporaryShopGallery;

    __weak UIView *_rootView;

    bool _isUserViewShopGallery;
    GalleryView *galleryView;
//    ShopUserGalleryView *userGalleryView;
//    ShopGalleryView *galleryView;
}

-(ShopPicture*) initWithShop:(Shop*) shop;
-(void)setShop:(Shop *)shop;

@end