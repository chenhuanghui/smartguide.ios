//
//  OperationShopUser.h
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@class ShopInfo;

@interface OperationShopUser : ASIOperationPost

-(OperationShopUser*) initWithIDShop:(int) idShop userLat:(double) userLat userLng:(double) userLng;

@property (nonatomic, strong) ShopInfo *shop;
@property (nonatomic, strong) NSMutableArray *shopGalleries;
@property (nonatomic, strong) NSMutableArray *shopUserGalleries;
@property (nonatomic, strong) NSMutableArray *shopComments;
@property (nonatomic, strong) NSMutableArray *shopEvents;

@end
