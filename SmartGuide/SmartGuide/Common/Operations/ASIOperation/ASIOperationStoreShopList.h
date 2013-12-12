//
//  ASIOperationStoreShopList.h
//  SmartGuide
//
//  Created by MacMini on 11/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationStoreShopList : ASIOperationPost

-(ASIOperationStoreShopList*) initWithUserLat:(double) userLat userLng:(double) userLng sort:(enum SORT_STORE_SHOP_LIST_TYPE) sort page:(NSUInteger) page;

@property (nonatomic, readonly) NSMutableArray *shops;

@end
