//
//  UserGalleryFullViewController.h
//  SmartGuide
//
//  Created by MacMini on 23/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "GalleryFullViewController.h"
#import "Shop.h"

@interface UserGalleryFullViewController : GalleryFullViewController
{
    __weak Shop* _shop;
    ShopGallery *_selectedGallery;
    NSMutableArray *_galleries;
}

-(UserGalleryFullViewController*) initWithShop:(Shop*) shop selectedGallery:(ShopUserGallery*) gallery;

@end
