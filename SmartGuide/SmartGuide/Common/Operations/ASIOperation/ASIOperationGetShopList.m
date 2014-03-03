//
//  ASIOperationGetShopList.m
//  SmartGuide
//
//  Created by MacMini on 24/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationGetShopList.h"
#import "ShopList.h"

@implementation ASIOperationGetShopList

-(ASIOperationGetShopList *)initWithIDShops:(NSString *)idShops userLat:(double)userLat userLng:(double)userLng page:(int)page sort:(enum SORT_LIST)sort
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_GET_SHOP_LIST)]];
    
    [self.keyValue setObject:idShops forKey:@"idShop"];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    [self.keyValue setObject:@(sort) forKey:SORT];
    [self.keyValue setObject:@(page) forKey:PAGE];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    self.shopLists=[NSMutableArray array];
    if([self isNullData:json])
        return;
    
    for(NSDictionary *dict in json)
    {
        ShopList *shop=[ShopList makeWithDictionary:dict];
        
        [self.shopLists addObject:shop];
    }
    
    [[DataManager shareInstance] save];
}

@end
