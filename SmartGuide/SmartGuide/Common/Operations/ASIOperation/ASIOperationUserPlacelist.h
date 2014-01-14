//
//  ASIOperationUserPlacelist.h
//  SmartGuide
//
//  Created by MacMini on 14/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"
#import "UserPlacelist.h"

@interface ASIOperationUserPlacelist : ASIOperationPost

-(ASIOperationUserPlacelist*) initWithUserLat:(double) userLat userLng:(double) userLng page:(int) page;

@property (nonatomic, readonly) NSMutableArray *userPlacelists;

@end