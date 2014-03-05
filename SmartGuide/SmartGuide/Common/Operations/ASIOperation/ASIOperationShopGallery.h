//
//  ASIOperationShopGallery.h
//  SmartGuide
//
//  Created by MacMini on 05/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"
#import "ShopGallery.h"
#import "Shop.h"

@interface ASIOperationShopGallery : ASIOperationPost

-(ASIOperationShopGallery*) initWithWithIDShop:(int) idShop userLat:(double) userLat userLng:(double) userLng page:(int) page;

@property (nonatomic, strong) NSMutableArray *galleries;

@end
