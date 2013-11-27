#import "ShopKM1.h"
#import "Utility.h"

@implementation ShopKM1

+(ShopKM1 *)makeWithJSON:(NSDictionary *)data
{
    ShopKM1 *obj=[ShopKM1 insert];
    obj.notice=[NSString stringWithStringDefault:data[@"notice"]];
    obj.duration=[NSString stringWithStringDefault:data[@"duration"]];
    obj.money=[NSString stringWithStringDefault:data[@"money"]];
    obj.sgp=[NSString stringWithStringDefault:data[@"sgp"]];
    obj.sp=[NSString stringWithStringDefault:data[@"sp"]];
    obj.p=[NSString stringWithStringDefault:data[@"p"]];
    
    return obj;
}

@end
