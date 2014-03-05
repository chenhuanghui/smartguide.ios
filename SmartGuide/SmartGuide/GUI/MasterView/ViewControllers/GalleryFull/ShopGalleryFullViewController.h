//
//  ShopGalleryFullViewController.h
//  SmartGuide
//
//  Created by MacMini on 23/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "GalleryFullViewController.h"
#import "Shop.h"
#import "ASIOperationShopGallery.h"

@interface ShopGalleryFullViewController : GalleryFullViewController
{
    __weak Shop* _shop;
    ShopGallery *_selectedGallery;

    bool _canLoadMore;
    bool _isLoadingMore;
    int _page;
    ASIOperationShopGallery *_operationShopGallery;
}

-(ShopGalleryFullViewController*) initWithShop:(Shop*) shop selectedGallery:(ShopGallery*) gallery;

@end
