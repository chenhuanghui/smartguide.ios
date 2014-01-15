//
//  ASIOperationCreatePlacelist.h
//  SmartGuide
//
//  Created by MacMini on 15/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"
#import "UserPlacelist.h"

@interface ASIOperationCreatePlacelist : ASIOperationPost

-(ASIOperationCreatePlacelist*) initWithName:(NSString*) name desc:(NSString*) desc idShop:(NSString*) idShops userLat:(double) userLat userLng:(double) userLng;

@property (nonatomic, readonly) int status;
@property (nonatomic, readonly) NSString *message;
@property (nonatomic, readonly) UserPlacelist *placelist;

@end
