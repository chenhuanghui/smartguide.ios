//
//  ASIOperationStoreAllStore.h
//  SmartGuide
//
//  Created by MacMini on 15/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"
#import "StoreShop.h"
#import "StoreShopItem.h"

@interface ASIOperationStoreAllStore : ASIOperationPost

-(ASIOperationStoreAllStore*) initWithUserLat:(double) userLat withUserLng:(double) userLng;

@property (nonatomic, readonly) NSMutableArray *shopsLatest;
@property (nonatomic, readonly) NSMutableArray *shopsTopSellers;

@end
