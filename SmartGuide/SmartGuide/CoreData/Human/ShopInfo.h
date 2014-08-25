#import "_ShopInfo.h"

enum SHOPINFO_DATA_TYPE
{
    SHOPINFO_DATA_TYPE_IDSHOP=0,
    SHOPINFO_DATA_TYPE_HOME=1,
};

@interface ShopInfo : _ShopInfo 
{
}

+(ShopInfo*) shopWithIDShop:(NSNumber*) idShop;

-(enum SHOPINFO_DATA_TYPE) enumDataType;

@end
