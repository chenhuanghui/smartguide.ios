//
//  ASIOperationStoreShopItem.h
//  SmartGuide
//
//  Created by MacMini on 13/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationStoreShopItem : ASIOperationPost

-(ASIOperationStoreShopItem*) initWithIDShop:(NSNumber*) idShop page:(int) page userLat:(double) userLat userLng:(double) userLng sort:(enum SORT_STORE_SHOP_LIST_TYPE) sort;

@property (nonatomic, readonly) NSMutableArray *items;
@property (nonatomic, readonly) enum SORT_STORE_SHOP_LIST_TYPE sortType;

@end
