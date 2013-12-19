#import "_Shop.h"
#import <MapKit/MapKit.h>
#import "Constant.h"
#import "ShopUserComment.h"
#import "ShopUserGallery.h"
#import "ShopGallery.h"
#import "ShopKM1.h"
#import "KM1Voucher.h"

@interface Shop : _Shop<MKAnnotation>
{
}

+(Shop*) shopWithIDShop:(int) idShop;
+(Shop*) makeShopWithDictionary:(NSDictionary*) dict;
//+(Shop*) makeShopWithIDShop:(int) idShop withJSONShopInGroup:(NSDictionary*) data;
//+(Shop*) makeShopWithIDShop:(int) idShop withJSONUserCollection:(NSDictionary*) data;

-(enum SHOP_PROMOTION_TYPE) shopPromotionType;
-(enum LOVE_STATUS) enumLoveStatus;

@end
