#import "StoreShop.h"
#import "StoreShopItem.h"
#import "Utility.h"

@implementation StoreShop

+(StoreShop *)storeWithID:(int)idShop
{
    return [StoreShop queryStoreShopObject:[NSPredicate predicateWithFormat:@"%K == %i",StoreShop_IdStore,idShop]];
}

+(StoreShop *)makeWithDictionary:(NSDictionary *)dict
{
    int idShop=[[NSNumber numberWithObject:dict[@"idStore"]] integerValue];
    StoreShop *store=[StoreShop storeWithID:idShop];
    
    if(!store)
    {
        store=[StoreShop insert];
        store.idStore=@(idShop);
    }

    store.storeName=[NSString stringWithStringDefault:dict[@"storeName"]];
    store.storeType=[NSString stringWithStringDefault:dict[@"storeType"]];
    store.desc=[NSString stringWithStringDefault:dict[@"description"]];
    store.condition=[NSString stringWithStringDefault:dict[@"condition"]];
    store.conditionPair=[NSString stringWithStringDefault:dict[@"highlightKeywords"]];
    store.total=[NSString stringWithStringDefault:dict[@"total"]];
    store.logo=[NSString stringWithStringDefault:dict[@"logo"]];
    
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
    
    return store;
}

@end
