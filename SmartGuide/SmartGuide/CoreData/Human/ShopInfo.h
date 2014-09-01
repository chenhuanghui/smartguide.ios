#import "_ShopInfo.h"

enum SHOPINFO_DATA_TYPE
{
    SHOPINFO_DATA_TYPE_IDSHOP=0,
    SHOPINFO_DATA_TYPE_HOME=1,
    SHOPINFO_DATA_TYPE_FULL=2,
};

@interface ShopInfo : _ShopInfo 
{
}

+(ShopInfo*) shopWithIDShop:(NSNumber*) idShop;
+(ShopInfo*) makeWithData:(NSDictionary*) dict;

-(enum SHOPINFO_DATA_TYPE) enumDataType;

@property (nonatomic, assign) CGRect nameRect;
@property (nonatomic, assign) CGRect shopTypeRect;

@end
