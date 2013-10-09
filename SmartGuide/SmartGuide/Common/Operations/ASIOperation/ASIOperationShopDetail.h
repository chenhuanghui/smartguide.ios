//
//  ASIOperationShopDetail.h
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"
#import "Shop.h"
#import "PromotionDetail.h"
#import "PromotionRequire.h"

@interface ASIOperationShopDetail : ASIOperationPost

-(ASIOperationShopDetail*) initWithIDUser:(int) idUser idShop:(int) idShop latitude:(double) lat longtitude:(double) lon;

@property (nonatomic, readonly) Shop* shop;
@property (nonatomic, readonly) NSMutableArray *comments;
@property (nonatomic, readonly) NSMutableArray *shopGalleries;
@property (nonatomic, readonly) NSMutableArray *userGalleries;
@property (nonatomic, readonly) NSMutableArray *products;

@end
