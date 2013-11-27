//
//  ASIOperationShopDetail.h
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"
#import "Shop.h"

@interface ASIOperationShopDetail : ASIOperationPost

-(ASIOperationShopDetail *)initWithIDShop:(int)idShop latitude:(double)lat longtitude:(double)lon;

@property (nonatomic, readonly) Shop* shop;

@end
