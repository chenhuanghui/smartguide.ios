#import "ShopInfo.h"
#import "ShopInfoGallery.h"

@implementation ShopInfo
@synthesize nameRect, shopTypeRect;

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
            
        case SHOPINFO_DATA_TYPE_FULL:
            return SHOPINFO_DATA_TYPE_FULL;
    }
    
    return SHOPINFO_DATA_TYPE_IDSHOP;
}

+(ShopInfo *)makeWithData:(NSDictionary *)dict
{
    NSNumber *idShop=[NSNumber makeNumber:dict[@"idShop"]];
    
    ShopInfo *shop=[ShopInfo shopWithIDShop:idShop];
    
    if(!shop)
    {
        shop=[ShopInfo insert];
        shop.idShop=idShop;
    }
    
    shop.dataType=@(SHOPINFO_DATA_TYPE_FULL);
    
    shop.name=[NSString makeString:dict[@"shopName"]];
    shop.shopType=[NSNumber makeNumber:dict[@"shopType"]];
    shop.shopTypeText=[NSString makeString:dict[@"shopTypeDisplay"]];
    shop.shopLat=[NSNumber makeNumber:dict[@"shopLat"]];
    shop.shopLng=[NSNumber makeNumber:dict[@"shopLng"]];
    shop.logo=[NSString makeString:dict[@"logo"]];
    shop.loveStatus=[NSNumber makeNumber:dict[@"loveStatus"]];
    shop.numOfLove=[NSString makeString:dict[@"numOfLove"]];
    shop.totalLove=[NSNumber makeNumber:dict[@"totalLove"]];
    shop.numOfView=[NSString makeString:dict[@"numOfView"]];
    shop.numOfComment=[NSString makeString:dict[@"numOfComment"]];
    shop.totalComment=[NSNumber makeNumber:dict[@"totalComment"]];
    shop.address=[NSString makeString:dict[@"address"]];
    shop.city=[NSString makeString:dict[@"city"]];
    shop.telCall=[NSString makeString:dict[@"tel"]];
    shop.telDisplay=[NSString makeString:dict[@"displayTel"]];
    shop.desc=[NSString makeString:dict[@"description"]];

    return shop;
}

@end
