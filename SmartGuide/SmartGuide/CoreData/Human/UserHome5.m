#import "UserHome5.h"
#import "Utility.h"

@implementation UserHome5

+(UserHome5 *)makeWithDictionary:(NSDictionary *)dict
{
    UserHome5 *home=[UserHome5 insert];
    
    home.store=[StoreShop makeWithDictionary:dict[@"storeInfo"]];
    
    home.numOfPurchase=[NSString stringWithStringDefault:dict[@"numOfPurchase"]];
    home.content=[NSString stringWithStringDefault:dict[@"content"]];
    home.cover=[NSString stringWithStringDefault:dict[@"cover"]];
    
    return home;
}

-(NSString *)storeName
{
    return self.store.storeName;
}

@end
