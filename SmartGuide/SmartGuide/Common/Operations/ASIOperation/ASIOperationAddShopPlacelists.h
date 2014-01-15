//
//  ASIOperationAddShopPlacelists.h
//  SmartGuide
//
//  Created by MacMini on 15/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"
#import "UserPlacelist.h"

@interface ASIOperationAddShopPlacelists : ASIOperationPost

-(ASIOperationAddShopPlacelists*) initWithIDShop:(int) idShop idPlacelists:(NSString*) idPlacelists userLat:(double) userLat userLng:(double) userLng;

@property (nonatomic, readonly) int status;
@property (nonatomic, readonly) NSString *message;
@property (nonatomic, readonly) NSMutableArray *placelits;

@end
