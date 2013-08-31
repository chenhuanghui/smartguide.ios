#import "_Shop.h"
#import <MapKit/MapKit.h>

enum SHOP_SHOW_TYPE {
    SHOP_SHOW_DETAIL = 1,
    SHOP_SHOW_NAME = 2,
    };

@interface Shop : _Shop<MKAnnotation>
{
}

+(Shop*) shopWithIDShop:(int) idShop;
+(Shop*) makeShopWithDictionaryShopInGroup:(NSDictionary*) data;
+(Shop*) makeShopWithDictionaryUserCollection:(NSDictionary*) data;

-(int) score;
-(int) minRank;
-(NSArray*) ranks;
-(NSString*) time;
-(NSString*) day;
-(double) SGP;
-(double) SP;

@property (nonatomic, assign) bool selected;
@property (nonatomic, assign) enum SHOP_SHOW_TYPE showPinType;
@property (nonatomic, assign) bool isUserCollection;
@property (nonatomic, assign) bool isShopDetail;

@end
