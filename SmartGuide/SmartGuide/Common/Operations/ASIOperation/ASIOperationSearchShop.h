//
//  ASIOperationSearch.h
//  SmartGuide
//
//  Created by XXX on 8/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationSearchShop : ASIOperationPost

-(ASIOperationSearchShop*) initWithKeyword:(NSString*) keyword groups:(NSString*) groups idUser:(int) idUser lat:(double) lat lon:(double) lon page:(int) page promotionFilter:(enum SHOP_PROMOTION_FILTER_TYPE) promotionFilter sortType:(enum SORT_BY) sortType;

@property (nonatomic, readonly) NSMutableArray *shops;
@property (nonatomic, readonly) NSString *keyword;
@property (nonatomic, readonly) NSString *groups;
@property (nonatomic, readonly) enum SHOP_PROMOTION_FILTER_TYPE promotionFilter;
@property (nonatomic, readonly) enum SORT_BY sortType;

@end
