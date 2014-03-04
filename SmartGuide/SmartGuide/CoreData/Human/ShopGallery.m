#import "ShopGallery.h"
#import "Utility.h"

@implementation ShopGallery

+(ShopGallery *)makeWithJSON:(NSDictionary *)data
{
    ShopGallery *obj=[ShopGallery insert];
    
    obj.cover=[NSString stringWithStringDefault:data[@"cover"]];
    obj.image=[NSString stringWithStringDefault:data[@"image"]];
    obj.imageWidth=[NSNumber numberWithObject:data[@"imageWidth"]];
    obj.imageHeight=[NSNumber numberWithObject:data[@"imageHeight"]];
    
    return obj;
}

@end