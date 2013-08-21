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
#import "TableTemplate.h"
#import "GalleryView.h"

@class ShopUserGalleryView,ShopGalleryView,TemplateShopGallery,TemplateUserGallery;

@interface ShopPicture : UIView<ShopViewHandle,ASIOperationPostDelegate,TableTemplateDelegate,UITableViewDataSource,UITableViewDelegate,GalleryViewDelegate>
{
    Shop *_shop;
    __weak IBOutlet UITableView *tableShopGallery;
    __weak IBOutlet UITableView *tableUserGallery;
    
//    ASIOperationShopGallery *_operationShopGallery;
    ASIOperationShopUserGallery *_operationUserGallery;
    TemplateShopGallery *templateShopGallery;
    TemplateUserGallery *templateUserGallery;
    
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

@interface TemplateShopGallery : TableTemplate

@end

@interface TemplateUserGallery : TableTemplate


@end