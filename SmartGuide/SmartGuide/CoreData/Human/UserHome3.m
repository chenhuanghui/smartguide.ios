#import "UserHome3.h"
#import "Utility.h"

@implementation UserHome3

+(UserHome3 *)makeWithDictionary:(NSDictionary *)dict
{
    UserHome3 *home=[UserHome3 insert];
    
    home.title=[NSString stringWithStringDefault:dict[@"title"]];
    home.desc=[NSString stringWithStringDefault:dict[@"description"]];
    home.image=[NSString stringWithStringDefault:dict[@"image"]];
    home.numOfView=[NSString stringWithStringDefault:dict[@"numOfView"]];
    home.loveStatus=[NSNumber numberWithObject:dict[@"loveStatus"]];
    home.authorName=[NSString stringWithStringDefault:dict[@"authorName"]];
    home.authorAvatar=[NSString stringWithStringDefault:dict[@"authorAvatar"]];
    home.numOfShop=[NSString stringWithStringDefault:dict[@"numOfShop"]];
    home.content=[NSString stringWithStringDefault:dict[@"content"]];
    home.cover=[NSString stringWithStringDefault:dict[@"cover"]];
    
    
    return home;
}

-(enum LOVE_STATUS)enumLoveStatus
{
    switch (self.loveStatus.integerValue) {
        case 0:
            return LOVE_STATUS_NONE;
            
        case 1:
            return LOVE_STATUS_LOVED;
            
        default:
            return LOVE_STATUS_NONE;
    }
}


@end
