#import "StoreShop.h"
#import "StoreShopItem.h"
#import "Utility.h"

@implementation StoreShop

+(StoreShop *)shopWithID:(int)idShop
{
    return [StoreShop queryStoreShopObject:[NSPredicate predicateWithFormat:@"%K == %i",StoreShop_IdShop,idShop]];
}

+(StoreShop *)makeWithDictionary:(NSDictionary *)dict
{
    int idShop=[[NSNumber numberWithObject:dict[@"idShop"]] integerValue];
    StoreShop *store=[StoreShop shopWithID:idShop];
    
    if(!store)
    {
        store=[StoreShop insert];
        store.idShop=@(idShop);
    }

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
    
    return store;
}

@end
