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
@synthesize values,shops,sortType;

-(ASIOperationStoreShopList *)initWithUserLat:(double)userLat userLng:(double)userLng sort:(enum SORT_STORE_SHOP_LIST_TYPE)sort page:(NSUInteger)page
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_STORE_GET_LIST)]];
    
    values=@[@(userLat),@(userLng),@(sort),@(page)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"userLat",@"userLng",@"sort",@"page"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    shops=[NSMutableArray array];
    int sort=[values[2] integerValue];
    
    sortType=SORT_STORE_SHOP_LIST_LATEST;
    
    if(sort==SORT_STORE_SHOP_LIST_TOP_SELLER)
        sortType=SORT_STORE_SHOP_LIST_TOP_SELLER;
    
    if([self isNullData:json])
        return;
    
    int page=[values[3] integerValue];
    
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
