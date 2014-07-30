#import "ShopGallery.h"
#import "Utility.h"

@implementation ShopGallery

+(ShopGallery *)makeWithJSON:(NSDictionary *)data
{
    ShopGallery *obj=[ShopGallery insert];
    
    obj.cover=[NSString makeString:data[@"cover"]];
    obj.image=[NSString makeString:data[@"image"]];
    obj.imageWidth=[NSNumber makeNumber:data[@"imageWidth"]];
    obj.imageHeight=[NSNumber makeNumber:data[@"imageHeight"]];
    
    return obj;
}

@end