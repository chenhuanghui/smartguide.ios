#import "UserHome6.h"
#import "Utility.h"

@implementation UserHome6

+(UserHome6 *)makeWithDictionary:(NSDictionary *)dict
{
    UserHome6 *home=[UserHome6 insert];
    
    home.idShop=[NSNumber numberWithObject:dict[@"idShop"]];
    home.logo=[NSString stringWithStringDefault:dict[@"logo"]];
    home.shopName=[NSString stringWithStringDefault:dict[@"shopName"]];
    home.date=[NSString stringWithStringDefault:dict[@"date"]];
    home.cover=[NSString stringWithStringDefault:dict[@"cover"]];
    home.title=[NSString stringWithStringDefault:dict[@"title"]];
    home.content=[NSString stringWithStringDefault:dict[@"content"]];
    
    return home;
}

@end
