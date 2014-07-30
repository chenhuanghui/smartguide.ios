#import "ShopUserGallery.h"
#import "Utility.h"

@implementation ShopUserGallery

+(ShopUserGallery *)makeWithJSON:(NSDictionary *)data
{
    ShopUserGallery *obj=[ShopUserGallery insert];
    
    obj.username=[NSString makeString:data[@"username"]];
    obj.thumbnail=[NSString makeString:data[@"thumbnail"]];
    obj.image=[NSString makeString:data[@"image"]];
    obj.desc=[NSString makeString:data[@"description"]];
    obj.time=[NSString makeString:data[@"time"]];
    obj.idGallery=[NSNumber makeNumber:data[@"idUserGallery"]];
    
    return obj;
}

@end