//
//  OperationSearchShop.h
//  Infory
//
//  Created by XXX on 9/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"
#import "Enums.h"

@interface OperationSearchShop : ASIOperationPost

-(OperationSearchShop*) initWithKeyword:(NSString*) keyword userLat:(double) userLat userLng:(double) userLng page:(int) page sort:(enum SHOP_LIST_SORT_TYPE) sort idCity:(int) idCity;

@property (nonatomic, strong) NSMutableArray *shops;

@end
