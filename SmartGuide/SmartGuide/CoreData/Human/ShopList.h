#import "_ShopList.h"
#import "Constant.h"
#import <MapKit/MapKit.h>

@interface ShopList : _ShopList<MKAnnotation>
{
}

+(ShopList*) shopListWithIDShop:(int) idShop;
+(ShopList*) makeWithDictionary:(NSDictionary*) dict;

-(enum SHOP_PROMOTION_TYPE) shopPromotionType;
-(enum SHOP_TYPE) enumShopType;
-(enum LOVE_STATUS) enumLoveStatus;

@end
