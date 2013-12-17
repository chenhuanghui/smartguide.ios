#import "ShopList.h"
#import "Utility.h"

@implementation ShopList

+(ShopList *)shopListWithIDShop:(int)idShop
{
    return [ShopList queryShopListObject:[NSPredicate predicateWithFormat:@"%K == %i",ShopList_IdShop,idShop]];
}

+(ShopList *)makeWithDictionary:(NSDictionary *)dict
{
    int idShop=[[NSNumber numberWithObject:dict[@"idShop"]] integerValue];
    
    ShopList *obj=[ShopList shopListWithIDShop:idShop];
    
    if(!obj)
    {
        obj=[ShopList insert];
        obj.idShop=@(idShop);
    }
    
    obj.promotionType=[NSNumber numberWithObject:dict[@"promotionType"]];
    obj.shopType=[NSNumber numberWithObject:dict[@"shopType"]];
    obj.shopName=[NSString stringWithStringDefault:dict[@"shopName"]];
    obj.address=[NSString stringWithStringDefault:dict[@"address"]];
    obj.desc=[NSString stringWithStringDefault:dict[@"description"]];
    obj.shopLat=[NSNumber numberWithObject:dict[@"shopLat"]];
    obj.shopLng=[NSNumber numberWithObject:dict[@"shopLng"]];
    obj.loveStatus=[NSNumber numberWithObject:dict[@"loveStatus"]];
    obj.distance=[NSString stringWithStringDefault:dict[@"distance"]];
    obj.numOfLove=[NSString stringWithStringDefault:dict[@"numOfLove"]];
    obj.numOfView=[NSString stringWithStringDefault:dict[@"numOfView"]];
    obj.logo=[NSString stringWithStringDefault:dict[@"logo"]];
    obj.numOfComment=[NSString stringWithStringDefault:dict[@"numOfComment"]];
    
    NSDictionary *dictShopGallery=dict[@"shopGallery"];
    
    obj.cover=@"";
    obj.coverFullscreen=@"";
    
    if(![dictShopGallery isNullData])
    {
        obj.cover=[NSString stringWithStringDefault:dictShopGallery[@"cover"]];
        obj.coverFullscreen=[NSString stringWithStringDefault:dictShopGallery[@"image"]];
    }
    
    return obj;
}

-(enum SHOP_PROMOTION_TYPE)shopPromotionType
{
    switch (self.promotionType.integerValue) {
        case 0:
            return SHOP_PROMOTION_NONE;
            
        case 1:
            return SHOP_PROMOTION_KM1;
            
        case 2:
            return SHOP_PROMOTION_KM2;
            
        case 3:
            return SHOP_PROMOTION_KM3;
            
        default:
            return SHOP_PROMOTION_NONE;
    }
}

-(enum SHOP_TYPE) enumShopType
{
    switch (self.shopType.integerValue) {
        case 0:
            return SHOP_TYPE_TAT_CA;
            
        case 1:
            return SHOP_TYPE_AM_THUC;
            
        case 2:
            return SHOP_TYPE_CAFE;
            
        case 3:
            return SHOP_TYPE_LAM_DEP;
            
        case 4:
            return SHOP_TYPE_GIAI_TRI;
            
        case 5:
            return SHOP_TYPE_THOI_TRANG;
            
        case 6:
            return SHOP_TYPE_DU_LICH;
            
        case 7:
            return SHOP_TYPE_SAN_PHAM;
            
        case 8:
            return SHOP_TYPE_GIAO_DUC;
            
        default:
            return SHOP_TYPE_TAT_CA;
    }
}

-(enum LOVE_STATUS)enumLoveStatus
{
    switch (self.loveStatus.integerValue) {
        case 0:
            return LOVE_STATUS_NONE;
            
        case 1:
            return LOVE_STATUS_LOVED;
            
        default:
            return LOVE_STATUS_NONE;
    }
}

-(CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake(self.shopLat.doubleValue, self.shopLng.doubleValue);
}

-(NSString *)title
{
    return self.shopName;
}

@end
