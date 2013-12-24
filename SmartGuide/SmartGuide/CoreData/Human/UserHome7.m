#import "UserHome7.h"
#import "Utility.h"

@implementation UserHome7

+(UserHome7 *)makeWithDictionary:(NSDictionary *)dict
{
    UserHome7 *home=[UserHome7 insert];
    
    home.idStore=[NSNumber numberWithObject:dict[@"idStore"]];
    home.logo=[NSString stringWithStringDefault:dict[@"logo"]];
    home.storeName=[NSString stringWithStringDefault:dict[@"storeName"]];
    home.date=[NSString stringWithStringDefault:dict[@"date"]];
    home.cover=[NSString stringWithStringDefault:dict[@"cover"]];
    home.title=[NSString stringWithStringDefault:dict[@"title"]];
    home.content=[NSString stringWithStringDefault:dict[@"content"]];
    
    return home;
}

@end
