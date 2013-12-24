#import "UserHome5.h"
#import "Utility.h"

@implementation UserHome5

+(UserHome5 *)makeWithDictionary:(NSDictionary *)dict
{
    UserHome5 *home=[UserHome5 insert];
    
    home.idStore=[NSNumber numberWithObject:dict[@"idStore"]];
    home.storeName=[NSString stringWithStringDefault:dict[@"storeName"]];
    home.numOfPurchase=[NSString stringWithStringDefault:dict[@"numOfPurchase"]];
    home.content=[NSString stringWithStringDefault:dict[@"content"]];
    home.cover=[NSString stringWithStringDefault:dict[@"cover"]];
    
    return home;
}

@end
