//
//  ASIOperationUserHome.h
//  SmartGuide
//
//  Created by MacMini on 24/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"
#import "UserHome.h"

@interface ASIOperationUserHome : ASIOperationPost

-(ASIOperationUserHome*) initWithPage:(NSUInteger) page userLat:(double) userLat userLng:(double) userLng;

@property (nonatomic, readonly) NSMutableArray *homes;

@end
