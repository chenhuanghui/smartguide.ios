#import "_Shop.h"
#import <MapKit/MapKit.h>
#import "Constant.h"
#import "ShopUserComment.h"
#import "ShopUserGallery.h"
#import "ShopGallery.h"
#import "ShopKM1.h"
#import "KM1Voucher.h"
#import "ShopKM2.h"
#import "KM2Voucher.h"
#import "PromotionNews.h"

enum SHOP_DATA_MODE {
    SHOP_DATA_SHOP_LIST = 0,
    SHOP_DATA_HOME_8 = 1,
    SHOP_DATA_FULL = 2,
};


@interface Shop : _Shop<MKAnnotation>
{
    CLLocationCoordinate2D _dragCoord;
}

+(Shop*) shopWithIDShop:(int) idShop;
+(Shop*) makeShopWithDictionary:(NSDictionary*) dict;
//+(Shop*) makeShopWithIDShop:(int) idShop withJSONShopInGroup:(NSDictionary*) data;
//+(Shop*) makeShopWithIDShop:(int) idShop withJSONUserCollection:(NSDictionary*) data;

-(enum SHOP_PROMOTION_TYPE) enumPromotionType;
-(enum LOVE_STATUS) enumLoveStatus;
-(enum SHOP_TYPE) enumShopType;
-(enum SHOP_DATA_MODE) enumDataMode;
-(UIImage*) iconPin;

@property (nonatomic, assign) float descHeight;

@end
