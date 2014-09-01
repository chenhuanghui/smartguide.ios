#import "ShopInfoUserGallery.h"

@implementation ShopInfoUserGallery

+(ShopInfoUserGallery *)makeWithData:(NSDictionary *)data
{
    ShopInfoUserGallery *obj=[ShopInfoUserGallery insert];
    
    obj.username=[NSString makeString:data[@"username"]];
    obj.thumbnail=[NSString makeString:data[@"thumbnail"]];
    obj.image=[NSString makeString:data[@"image"]];
    obj.desc=[NSString makeString:data[@"description"]];
    obj.time=[NSString makeString:data[@"time"]];
    obj.idUserGallery=[NSNumber makeNumber:data[@"idUserGallery"]];
    
    return obj;
}

@end
