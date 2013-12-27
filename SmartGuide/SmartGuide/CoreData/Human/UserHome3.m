#import "UserHome3.h"
#import "Utility.h"
#import "Placelist.h"

@implementation UserHome3

+(UserHome3 *)makeWithDictionary:(NSDictionary *)dict
{
    UserHome3 *home=[UserHome3 insert];
    
    home.place=[Placelist makeWithDictionary:dict];
    home.content=[NSString stringWithStringDefault:dict[@"content"]];
    home.cover=[NSString stringWithStringDefault:dict[@"cover"]];
    home.numOfShop=[NSString stringWithStringDefault:dict[@"numOfShop"]];
    
    return home;
}

-(enum LOVE_STATUS)enumLoveStatus
{
    return self.place.enumLoveStatus;
}


@end
