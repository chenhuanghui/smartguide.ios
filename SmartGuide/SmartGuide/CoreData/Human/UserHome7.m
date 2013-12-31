#import "UserHome7.h"
#import "Utility.h"

@implementation UserHome7

+(UserHome7 *)makeWithDictionary:(NSDictionary *)dict
{
    UserHome7 *home=[UserHome7 insert];
    
    home.store=[StoreShop makeWithDictionary:dict[@"storeInfo"]];
    
    home.date=[NSString stringWithStringDefault:dict[@"date"]];
    home.cover=[NSString stringWithStringDefault:dict[@"cover"]];
    home.title=[NSString stringWithStringDefault:dict[@"title"]];
    home.content=[NSString stringWithStringDefault:dict[@"content"]];
    home.gotostore=[NSString stringWithStringDefault:dict[@"goto"]];
    
    return home;
}

-(NSString *)storeName
{
    return self.store.storeName;
}

@end
