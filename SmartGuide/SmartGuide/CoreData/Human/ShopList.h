#import "_ShopList.h"
#import "Constant.h"
#import <MapKit/MapKit.h>
#import "Shop.h"

@interface ShopList : _ShopList<MKAnnotation>
{
}

+(ShopList*) shopListWithIDShop:(int) idShop;
+(ShopList*) makeWithDictionary:(NSDictionary*) dict;

-(NSNumber*) idShop;
-(NSString*) shopTypeDisplay;
-(NSString*) numOfComment;
-(NSString*) numOfView;
-(enum LOVE_STATUS) enumLoveStatus;
-(NSString*) logo;
-(NSString*) address;
-(NSNumber*) loveStatus;
-(NSString*) numOfLove;
-(NSString*) cover;
-(void) setNumOfLove:(NSString*) numOfLove;
-(void) setLoveStatus:(NSNumber*) loveStatus;

@end
