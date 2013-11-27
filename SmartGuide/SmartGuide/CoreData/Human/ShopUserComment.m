#import "ShopUserComment.h"
#import "Utility.h"

@implementation ShopUserComment

+(ShopUserComment *)makeWithJSON:(NSDictionary *)data
{
    ShopUserComment *obj=[ShopUserComment insert];
    obj.username=[NSString stringWithStringDefault:data[@"username"]];
    obj.time=[NSString stringWithStringDefault:data[@"time"]];
    obj.shopName=[NSString stringWithStringDefault:data[@"shopName"]];
    obj.avatar=[NSString stringWithStringDefault:data[@"avatar"]];
    obj.comment=[NSString stringWithStringDefault:data[@"comment"]];
    
    return obj;
}

@end
