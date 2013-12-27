#import "UserHome7.h"
#import "Utility.h"

@implementation UserHome7

+(UserHome7 *)makeWithDictionary:(NSDictionary *)dict
{
    UserHome7 *home=[UserHome7 insert];
    
    int idStore=[[NSNumber numberWithObject:dict[@"idStore"]] integerValue];
    
    home.store=[StoreShop storeWithID:idStore];
    if(!home.store)
    {
        home.store=[StoreShop insert];
        home.store.idStore=@(idStore);
        home.storeName=[NSString stringWithStringDefault:dict[@"storeName"]];
    }
    
    home.store.logo=[NSString stringWithStringDefault:dict[@"logo"]];
    home.storeName=[NSString stringWithStringDefault:dict[@"storeName"]];
    home.date=[NSString stringWithStringDefault:dict[@"date"]];
    home.cover=[NSString stringWithStringDefault:dict[@"cover"]];
    home.title=[NSString stringWithStringDefault:dict[@"title"]];
    home.content=[NSString stringWithStringDefault:dict[@"content"]];
    home.gotostore=[NSString stringWithStringDefault:dict[@"goto"]];
    
    return home;
}

@end
