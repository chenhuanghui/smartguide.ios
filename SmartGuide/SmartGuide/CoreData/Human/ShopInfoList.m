#import "ShopInfoList.h"

@implementation ShopInfoList
@synthesize descRect,nameRect,addressRect;

+(ShopInfoList *)makeWithData:(NSDictionary *)dict
{
    ShopInfoList *obj=[ShopInfoList insert];
 
    obj.idShop=[NSNumber makeNumber:dict[@"idShop"]];

    obj.distance=[NSString makeString:dict[@"distance"]];
    obj.desc=[NSString makeString:dict[@"description"]];
    obj.name=[NSString makeString:dict[@"shopName"]];
    
//    obj.promotionType=[NSNumber makeNumber:dict[@"promotionType"]];
    obj.shopType=[NSNumber makeNumber:dict[@"shopType"]];
    obj.shopTypeDisplay=[NSString makeString:dict[@"shopTypeDisplay"]];
    obj.address=[NSString makeString:dict[@"address"]];
    obj.shopLat=[NSNumber makeNumber:dict[@"shopLat"]];
    obj.shopLng=[NSNumber makeNumber:dict[@"shopLng"]];
    obj.loveStatus=[NSNumber makeNumber:dict[@"loveStatus"]];
    obj.numOfLove=[NSString makeString:dict[@"numOfLove"]];
    obj.numOfView=[NSString makeString:dict[@"numOfView"]];
    obj.logo=[NSString makeString:dict[@"logo"]];
    obj.numOfComment=[NSString makeString:dict[@"numOfComment"]];
    
    NSDictionary *dictShopGallery=dict[@"shopGallery"];
    
    if([dictShopGallery hasData])
    {
        obj.image=[NSString makeString:dictShopGallery[@"image"]];
        obj.imageWidth=[NSNumber makeNumber:dictShopGallery[@"imageWidth"]];
        obj.imageHeight=[NSNumber makeNumber:dictShopGallery[@"imageHeight"]];
        obj.cover=[NSString makeString:dictShopGallery[@"cover"]];
        obj.coverWidth=[NSNumber makeNumber:dictShopGallery[@"coverWidth"]];
        obj.coverHeight=[NSNumber makeNumber:dictShopGallery[@"coverHeight"]];
    }
    
    return obj;
}

@end
