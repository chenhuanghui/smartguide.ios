//
//  OperationPlacelist.h
//  Infory
//
//  Created by XXX on 8/27/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface OperationPlacelist : ASIOperationPost

-(OperationPlacelist*) initWithPage:(int) page userLat:(double) userLat userLng:(double) userLng;

@property (nonatomic, strong) NSMutableArray *placelists;

@end
