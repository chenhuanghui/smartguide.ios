//
//  ASIOperationStoreShopList.m
//  SmartGuide
//
//  Created by MacMini on 11/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationStoreShopList.h"
#import "StoreShop.h"
#import "StoreShopItem.h"

@implementation ASIOperationStoreShopList
@synthesize shops,sortType;

-(ASIOperationStoreShopList *)initWithUserLat:(double)userLat userLng:(double)userLng sort:(enum SORT_STORE_SHOP_LIST_TYPE)sort page:(NSUInteger)page
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_STORE_GET_LIST)]];
    
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    [self.keyValue setObject:@(sort) forKey:SORT];
    [self.keyValue setObject:@(page) forKey:PAGE];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    shops=[NSMutableArray array];
    int sort=[self.keyValue[SORT] integerValue];
    
    sortType=SORT_STORE_SHOP_LIST_LATEST;
    
    if(sort==SORT_STORE_SHOP_LIST_TOP_SELLER)
        sortType=SORT_STORE_SHOP_LIST_TOP_SELLER;
    
    if([self isNullData:json])
        return;
    
    int page=[self.keyValue[PAGE] integerValue];
    
    int countShop=10*page;
    for(NSDictionary *dict in json)
    {
        StoreShop *store=[StoreShop makeWithDictionary:dict];
        store.sortOrder=@(countShop++);
        
        [shops addObject:store];
    }
    
    [[DataManager shareInstance] save];
}

@end
