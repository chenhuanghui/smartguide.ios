#import "UserHome5.h"
#import "Utility.h"

@implementation UserHome5

+(UserHome5 *)makeWithDictionary:(NSDictionary *)dict
{
    UserHome5 *home=[UserHome5 insert];
    
    int idStore=[[NSNumber numberWithObject:dict[@"idStore"]] integerValue];
    
    home.store=[StoreShop storeWithID:idStore];
    if(!home.store)
    {
        home.store=[StoreShop insert];
        home.store.idStore=@(idStore);
        home.storeName=[NSString stringWithStringDefault:dict[@"storeName"]];
    }
    
    home.store.storeType=[NSString stringWithStringDefault:dict[@"storeType"]];
    home.store.desc=[NSString stringWithStringDefault:dict[@"description"]];
    home.store.logo=[NSString stringWithStringDefault:dict[@"logo"]];
    home.store.condition=[NSString stringWithStringDefault:dict[@"condition"]];
    home.store.conditionPair=[NSString stringWithStringDefault:dict[@"hightlightKeywords"]];
    
    home.storeName=[NSString stringWithStringDefault:dict[@"storeName"]];
    home.numOfPurchase=[NSString stringWithStringDefault:dict[@"numOfPurchase"]];
    home.content=[NSString stringWithStringDefault:dict[@"content"]];
    home.cover=[NSString stringWithStringDefault:dict[@"cover"]];
    
    return home;
}

@end
