//
//  OperationHome.h
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface OperationHome : ASIOperationPost

-(OperationHome*) initWithPage:(int) page userLat:(double) userLat userLng:(double) userLng;

@property (nonatomic, strong) NSMutableArray *homes;

@end
