#import "UserHome3.h"
#import "Utility.h"

@implementation UserHome3

+(UserHome3 *)makeWithDictionary:(NSDictionary *)dict
{
    UserHome3 *home=[UserHome3 insert];
    
    home.idPlacelist=[NSNumber numberWithObject:dict[@"idPlacelist"]];
    home.title=[NSString stringWithStringDefault:dict[@"title"]];
    home.numOfShop=[NSString stringWithStringDefault:dict[@"numOfShop"]];
    home.content=[NSString stringWithStringDefault:dict[@"content"]];
    home.cover=[NSString stringWithStringDefault:dict[@"cover"]];
    
    return home;
}

@end
