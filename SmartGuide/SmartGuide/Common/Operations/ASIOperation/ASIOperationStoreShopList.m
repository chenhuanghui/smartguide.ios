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
    
    sortType=SORT_STORE_SHOP_LIST_TOP_SELLER;
    
    if(sort==SORT_STORE_SHOP_LIST_LATEST)
        sortType=SORT_STORE_SHOP_LIST_LATEST;
    
    if([self isNullData:json])
        return;
    
    int page=[values[3] integerValue];
    
    int countShop=10*page;
    for(NSDictionary *dict in json)
    {
        int idShop=[[NSNumber numberWithObject:dict[@"idShop"]] integerValue];
        StoreShop *store=[StoreShop shopWithID:idShop];
        
        if(!store)
        {
            store=[StoreShop insert];
            store.idShop=@(idShop);
        }
        
        [store removeAllLatestItems];
        [store removeAllTopSellerItems];
        
        store.sortOrder=@(countShop++);
        store.shopName=[NSString stringWithStringDefault:dict[@"shopName"]];
        store.shopType=[NSString stringWithStringDefault:dict[@"shopType"]];
        store.desc=[NSString stringWithStringDefault:dict[@"description"]];
        store.condition=[NSString stringWithStringDefault:dict[@"condition"]];
        store.conditionPair=[NSString stringWithStringDefault:dict[@"highlightKeywords"]];
        store.total=[NSString stringWithStringDefault:dict[@"total"]];
        
        for(NSDictionary *dictItem in dict[@"latestItems"])
        {
            StoreShopItem *item=[StoreShopItem makeItemWithDictionary:dictItem];
         
            item.shopLatest=store;
            [store addLatestItemsObject:item];
        }
        
        for(NSDictionary *dictItem in dict[@"topSellerItems"])
        {
            StoreShopItem *item=[StoreShopItem makeItemWithDictionary:dictItem];
            
            item.shopTopSeller=store;
            [store addTopSellerItemsObject:item];
        }
        
        [shops addObject:store];
    }
    
    [[DataManager shareInstance] save];
}

@end
