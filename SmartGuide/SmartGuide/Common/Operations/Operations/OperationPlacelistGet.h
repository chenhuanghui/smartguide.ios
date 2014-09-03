//
//  OperationPlacelistGet.h
//  Infory
//
//  Created by XXX on 9/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"
#import "Enums.h"

@interface OperationPlacelistGet : ASIOperationPost

-(OperationPlacelistGet*) initWithIDPlace:(int) idPlace userLat:(double) userLat userLng:(double) userLng sort:(enum PLACE_SORT_TYPE) sort page:(int) page;

@property (nonatomic, strong) NSMutableArray *shops;

@end
