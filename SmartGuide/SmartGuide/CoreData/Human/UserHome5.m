#import "UserHome5.h"
#import "Utility.h"

@implementation UserHome5

+(UserHome5 *)makeWithDictionary:(NSDictionary *)dict
{
    UserHome5 *home=[UserHome5 insert];
    
    NSDictionary *dictStore=dict[@"storeInfo"];
    
    if(![dictStore isNullData])
    {
        home.store=[StoreShop makeWithDictionary:dictStore];
        home.storeName=[NSString stringWithStringDefault:dictStore[@"storeName"]];
    }
    
    home.numOfPurchase=[NSString stringWithStringDefault:dict[@"numOfPurchase"]];
    home.content=[NSString stringWithStringDefault:dict[@"content"]];
    home.cover=[NSString stringWithStringDefault:dict[@"cover"]];

    return home;
}

@end
