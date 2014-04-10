//
//  ShopGalleryManager.h
//  SmartGuide
//
//  Created by MacMini on 05/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shop.h"
#import "ASIOperationShopGallery.h"
#import "ASIOperationUserGallery.h"

#define NOTIFICATION_GALLERY_FINISED_SHOP @"galleryFinishedShop"
#define NOTIFICATION_GALLERY_FINISED_USER @"galleryFinishedUser"

@interface GalleryManager : NSObject<ASIOperationPostDelegate>
{
    Shop *_shop;
    
    ASIOperationShopGallery *_operationShopGallery;
    ASIOperationUserGallery *_operationUserGallery;
    
    bool _canLoadMoreUserGallery;
    bool _isLoadingMoreUserGallery;
    int _pageUserGallery;
    
    bool _canLoadMoreShopGallery;
    bool _isLoadingMoreShopGallery;
    int _pageShopGallery;
}

+(GalleryManager*) shareInstanceWithShop:(Shop*) shop;
+(void) clean;

-(Shop*) shop;
-(NSArray*) shopUserGalleries;
-(void) requestUserGallery;
-(void) requestShopGallery;

-(bool) canLoadMoreUserGallery;
-(bool) isLoadingMoreUserGallery;

-(bool) canLoadMoreShopGallery;
-(bool) isLoadingMoreShopGallery;

@end
