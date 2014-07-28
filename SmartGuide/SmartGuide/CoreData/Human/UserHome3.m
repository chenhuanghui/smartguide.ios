#import "UserHome3.h"
#import "Utility.h"
#import "Placelist.h"

@implementation UserHome3

+(UserHome3 *)makeWithDictionary:(NSDictionary *)dict
{
    UserHome3 *home=[UserHome3 insert];
    
    home.place=[Placelist makeWithDictionary:dict];
    
    home.title=[NSString makeString:dict[@"title"]];
    home.content=[NSString makeString:dict[@"content"]];
    home.cover=[NSString makeString:dict[@"cover"]];
    home.numOfShop=[NSString makeString:dict[@"numOfShop"]];
    
    return home;
}

-(enum LOVE_STATUS)enumLoveStatus
{
    return self.place.enumLoveStatus;
}


@end
