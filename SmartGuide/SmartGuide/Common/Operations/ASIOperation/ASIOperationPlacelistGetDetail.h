//
//  ASIOperationPlacelistGetDetail.h
//  SmartGuide
//
//  Created by MacMini on 21/02/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"
#import "Placelist.h"
#import "ShopList.h"

@interface ASIOperationPlacelistGetDetail : ASIOperationPost

-(ASIOperationPlacelistGetDetail*) initWithIDPlacelist:(int) idPlacelist userLat:(double) userLat userLng:(double) userLng sort:(enum SORT_LIST) sort;

@property (nonatomic, strong) Placelist *place;
@property (nonatomic, strong) NSMutableArray *shops;

@end
