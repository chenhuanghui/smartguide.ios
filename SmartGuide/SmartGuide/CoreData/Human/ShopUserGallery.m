#import "ShopUserGallery.h"
#import "Utility.h"

@implementation ShopUserGallery
@synthesize imagePosed;

+(ShopUserGallery *)makeWithJSON:(NSDictionary *)data
{
    ShopUserGallery *obj=[ShopUserGallery insert];
    
    obj.username=[NSString stringWithStringDefault:data[@"username"]];
    obj.thumbnail=[NSString stringWithStringDefault:data[@"thumbnail"]];
    obj.image=[NSString stringWithStringDefault:data[@"image"]];
    obj.desc=[NSString stringWithStringDefault:data[@"description"]];
    obj.time=[NSString stringWithStringDefault:data[@"time"]];
    
    return obj;
}

@end