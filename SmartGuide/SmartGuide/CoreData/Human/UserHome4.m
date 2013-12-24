#import "UserHome4.h"
#import "Utility.h"

@implementation UserHome4

+(UserHome4 *)makeWithDictionary:(NSDictionary *)dict
{
    UserHome4 *home=[UserHome4 insert];
    
    home.idShop=[NSNumber numberWithObject:dict[@"idShop"]];
    home.shopName=[NSString stringWithStringDefault:dict[@"shopName"]];
    home.numOfView=[NSString stringWithStringDefault:dict[@"numOfView"]];
    home.content=[NSString stringWithStringDefault:dict[@"content"]];
    home.cover=[NSString stringWithStringDefault:dict[@"cover"]];
    
    return home;
}

@end
