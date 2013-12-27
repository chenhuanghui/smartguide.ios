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
@synthesize values,items,sortType;

-(ASIOperationStoreShopItem *)initWithIDShop:(NSNumber *)idShop page:(int)page userLat:(double)userLat userLng:(double)userLng sort:(enum SORT_STORE_SHOP_LIST_TYPE)sort
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_STORE_GET_ITEMS)]];
    
    values=@[idShop,@(page),@(userLat),@(userLng),@(sort)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"idShop",@"page",@"userLat",@"userLng",@"sort"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    items=[NSMutableArray array];
    
    if([self isNullData:json])
        return;
    
    int sort=[values[4] integerValue];
    
    sortType=SORT_STORE_SHOP_LIST_LATEST;
    
    if(sort==SORT_STORE_SHOP_LIST_TOP_SELLER)
        sortType=SORT_STORE_SHOP_LIST_TOP_SELLER;
    
    StoreShop *shop=[StoreShop storeWithID:[values[0] integerValue]];
    int type=[values[4] integerValue];
    
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
