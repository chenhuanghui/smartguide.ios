#import "ShopInfo.h"

@implementation ShopInfo

+(ShopInfo *)shopWithIDShop:(NSNumber *)idShop
{
    return [self queryShopInfoObject:[NSPredicate predicateWithFormat:@"%K==%@",ShopInfo_IdShop, idShop]];
}

-(enum SHOPINFO_DATA_TYPE)enumDataType
{
    switch ((enum SHOPINFO_DATA_TYPE)self.dataType.integerValue) {
        case SHOPINFO_DATA_TYPE_IDSHOP:
            return SHOPINFO_DATA_TYPE_IDSHOP;
            
        case SHOPINFO_DATA_TYPE_HOME:
            return SHOPINFO_DATA_TYPE_HOME;
    }
    
    return SHOPINFO_DATA_TYPE_IDSHOP;
}

@end
