//
//  ASIOperationShopDetail.h
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"
#import "Shop.h"

@interface ASIOperationShopUser : ASIOperationPost

-(ASIOperationShopUser *)initWithIDShop:(int)idShop userLat:(double)userLat userLng:(double)userLng;

@property (nonatomic, readonly) Shop* shop;

@end
