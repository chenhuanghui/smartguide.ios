//
//  OperationPlacelistDetail.h
//  Infory
//
//  Created by XXX on 9/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"
#import "Enums.h"

@class Place;

@interface OperationPlacelistDetail : ASIOperationPost

-(OperationPlacelistDetail*) initWithIDPlace:(int) idPlace userLat:(double) userLat userLng:(double) userLng sort:(enum PLACE_SORT_TYPE) sort;

@property (nonatomic, strong) Place *place;
@property (nonatomic, strong) NSMutableArray *shops;

@end
