#import "ShopGallery.h"
#import "Utility.h"

@implementation ShopGallery

+(ShopGallery *)makeWithJSON:(NSDictionary *)data
{
    ShopGallery *obj=[ShopGallery insert];
    
    obj.thumbnail=[NSString stringWithStringDefault:data[@"thumbnail"]];
    obj.image=[NSString stringWithStringDefault:data[@"image"]];
    
    return obj;
}

@end