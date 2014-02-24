//
//  ASIOperationStoreShopItem.m
//  SmartGuide
//
//  Created by MacMini on 13/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationStoreShopItem.h"
#import "StoreShop.h"
#import "StoreShopItem.h"

@implementation ASIOperationStoreShopItem
@synthesize items,sortType;

-(ASIOperationStoreShopItem *)initWithIDStore:(NSNumber *)idStore page:(int)page userLat:(double)userLat userLng:(double)userLng sort:(enum SORT_STORE_SHOP_LIST_TYPE)sort
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_STORE_GET_ITEMS)]];
    
    [self.keyValue setObject:idStore forKey:IDSTORE];
    [self.keyValue setObject:@(page) forKey:PAGE];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    [self.keyValue setObject:@(sort) forKey:SORT];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    items=[NSMutableArray array];
    
    if([self isNullData:json])
        return;
    
    int sort=[self.keyValue[SORT] integerValue];
    
    sortType=SORT_STORE_SHOP_LIST_LATEST;
    
    if(sort==SORT_STORE_SHOP_LIST_TOP_SELLER)
        sortType=SORT_STORE_SHOP_LIST_TOP_SELLER;
    
    StoreShop *shop=[StoreShop storeWithID:[self.keyValue[IDSTORE] integerValue]];
    int type=[self.keyValue[SORT] integerValue];
    
    for(NSDictionary *dict in json)
    {
        StoreShopItem *item=[StoreShopItem makeItemWithDictionary:dict];
        
        if(type==SORT_STORE_SHOP_LIST_LATEST)
        {
            item.shopLatest=shop;
            [shop addLatestItemsObject:item];
        }
        else
        {
            item.shopTopSeller=shop;
            [shop addTopSellerItemsObject:item];
        }
        
        [items addObject:item];
    }
    
    [[DataManager shareInstance] save];
}

@end
