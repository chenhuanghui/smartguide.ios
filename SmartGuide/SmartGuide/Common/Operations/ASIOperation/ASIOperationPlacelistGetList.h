//
//  ASIOperationPlacelistGetList.h
//  SmartGuide
//
//  Created by MacMini on 18/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"
#import "Placelist.h"

@interface ASIOperationPlacelistGetList : ASIOperationPost

-(ASIOperationPlacelistGetList*) initWithUserLat:(double) userLat userLng:(double) userLng page:(NSUInteger) page;

@property (nonatomic, readonly) NSMutableArray *placeLists;

@end
