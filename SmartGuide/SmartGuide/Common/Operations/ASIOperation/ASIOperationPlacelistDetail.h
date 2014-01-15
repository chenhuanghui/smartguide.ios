//
//  ASIOperationPlacelistDetail.h
//  SmartGuide
//
//  Created by MacMini on 18/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"
#import "Placelist.h"
#import "ShopList.h"

@interface ASIOperationPlacelistDetail : ASIOperationPost

-(ASIOperationPlacelistDetail*) initWithIDPlacelist:(int) idPlaceList userLat:(double) userLat userLng:(double) userLng sort:(enum SORT_LIST) sort page:(NSUInteger) page;

@property (nonatomic, weak) Placelist *place;
@property (nonatomic, weak) NSMutableArray *shopsList;

@end
