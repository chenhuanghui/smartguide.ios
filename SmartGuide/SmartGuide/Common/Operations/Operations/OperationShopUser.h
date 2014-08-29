//
//  OperationShopUser.h
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface OperationShopUser : ASIOperationPost

-(OperationShopUser*) initWithIDShop:(int) idShop userLat:(double) userLat userLng:(double) userLng;

@end
