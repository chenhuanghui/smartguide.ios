//
//  ASIOperationShopSearch.h
//  SmartGuide
//
//  Created by MacMini on 17/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"
#import "ShopList.h"

@interface ASIOperationShopSearch : ASIOperationPost

-(ASIOperationShopSearch*) initWithKeywords:(NSString*) keywords userLat:(double) userLat userLng:(double) userLng page:(NSUInteger) page sort:(enum SORT_LIST) sort;

@property (nonatomic, readonly) NSMutableArray *shopsList;

@end