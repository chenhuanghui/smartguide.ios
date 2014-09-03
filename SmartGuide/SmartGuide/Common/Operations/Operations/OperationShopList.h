//
//  OperationShopList.h
//  Infory
//
//  Created by XXX on 9/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"
#import "Enums.h"

@interface OperationShopList : ASIOperationPost

-(OperationShopList*) initWithIDShops:(NSString*) idShops idBrand:(int) idBrand userLat:(double) userLat userLng:(double) userLng page:(int) page sort:(enum SHOP_LIST_SORT_TYPE) sortType;

@property (nonatomic, strong) NSMutableArray *shops;

@end
