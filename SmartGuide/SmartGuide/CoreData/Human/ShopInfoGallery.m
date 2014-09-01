#import "ShopInfoGallery.h"

@implementation ShopInfoGallery

+(ShopInfoGallery *)makeWithData:(NSDictionary *)data
{
    ShopInfoGallery *obj=[ShopInfoGallery insert];
    
    obj.cover=[NSString makeString:data[@"cover"]];
    obj.coverWidth=[NSNumber makeNumber:data[@"coverWidth"]];
    obj.coverHeight=[NSNumber makeNumber:data[@"coverHeight"]];
    obj.image=[NSString makeString:data[@"image"]];
    obj.imageWidth=[NSNumber makeNumber:data[@"imageWidth"]];
    obj.imageHeight=[NSNumber makeNumber:data[@"imageHeight"]];
    
    return obj;
}

@end
