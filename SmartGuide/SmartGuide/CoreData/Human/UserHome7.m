#import "UserHome7.h"
#import "Utility.h"

@implementation UserHome7
@synthesize contentHeight,titleHeight;

+(UserHome7 *)makeWithDictionary:(NSDictionary *)dict
{
    UserHome7 *home=[UserHome7 insert];
    
    home.store=[StoreShop makeWithDictionary:dict[@"storeInfo"]];

    home.date=[NSString stringWithStringDefault:dict[@"date"]];
    home.cover=[NSString stringWithStringDefault:dict[@"cover"]];
    home.title=[NSString stringWithStringDefault:dict[@"title"]];
    home.content=[NSString stringWithStringDefault:dict[@"content"]];
    home.gotostore=[NSString stringWithStringDefault:dict[@"goto"]];
    home.coverHeight=[NSNumber numberWithObject:dict[@"coverHeight"]];
    home.coverWidth=[NSNumber numberWithObject:dict[@"coverWidth"]];
    
    return home;
}

-(NSString *)storeName
{
    return self.store.storeName;
}

@end
