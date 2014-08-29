//
//  OperationShopUser.m
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "OperationShopUser.h"

@implementation OperationShopUser

-(OperationShopUser *)initWithIDShop:(int)idShop userLat:(double)userLat userLng:(double)userLng
{
    self=[super initPOSTWithURL:SERVER_API_URL_MAKE(API_SHOP_DETAIL)];
    
    [self.keyValue setObject:@(idShop) forKey:IDSHOP];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    
    return self;
}

@end
