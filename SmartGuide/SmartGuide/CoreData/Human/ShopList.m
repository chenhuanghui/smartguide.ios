#import "ShopList.h"
#import "Utility.h"
#import "ImageManager.h"

@implementation ShopList

+(ShopList *)shopListWithIDShop:(int)idShop
{
    return [ShopList queryShopListObject:[NSPredicate predicateWithFormat:@"%K== %i",ShopList_IdShop, idShop]];
}

+(ShopList *)makeWithDictionary:(NSDictionary *)dict
{
    int idShop=[[NSNumber makeNumber:dict[@"idShop"]] integerValue];

    ShopList *obj=[ShopList shopListWithIDShop:idShop];
    
    if(!obj)
    {
        obj=[ShopList insert];
        obj.idShop=@(idShop);
    }
    
    obj.shop=[Shop shopWithIDShop:idShop];
    
    if(!obj.shop)
    {
        obj.shop=[Shop insert];
        obj.shop.idShop=@(idShop);
        obj.shop.shopName=[NSString makeString:dict[@"shopName"]];
        obj.shop.dataMode=@(SHOP_DATA_SHOP_LIST);
    }
    
    obj.distance=[NSString makeString:dict[@"distance"]];
    obj.desc=[NSString makeString:dict[@"description"]];
    obj.shopName=[NSString makeString:dict[@"shopName"]];
    
    obj.shop.promotionType=[NSNumber makeNumber:dict[@"promotionType"]];
    obj.shop.shopType=[NSNumber makeNumber:dict[@"shopType"]];
    obj.shop.shopTypeDisplay=[NSString makeString:dict[@"shopTypeDisplay"]];
    obj.shop.shopName=[NSString makeString:dict[@"shopName"]];
    obj.shop.address=[NSString makeString:dict[@"address"]];
    obj.shop.shopLat=[NSNumber makeNumber:dict[@"shopLat"]];
    obj.shop.shopLng=[NSNumber makeNumber:dict[@"shopLng"]];
    obj.shop.loveStatus=[NSNumber makeNumber:dict[@"loveStatus"]];
    obj.shop.numOfLove=[NSString makeString:dict[@"numOfLove"]];
    obj.shop.numOfView=[NSString makeString:dict[@"numOfView"]];
    obj.shop.logo=[NSString makeString:dict[@"logo"]];
    obj.shop.numOfComment=[NSString makeString:dict[@"numOfComment"]];
    
    NSDictionary *dictShopGallery=dict[@"shopGallery"];
    
    if(![dictShopGallery isNullData])
    {
        obj.shop.shopGalleryCover=[NSString makeString:dictShopGallery[@"cover"]];
        obj.shop.shopGalleryImage=[NSString makeString:dictShopGallery[@"image"]];
    }
    
    return obj;
}

-(CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake(self.shop.shopLat.doubleValue, self.shop.shopLng.doubleValue);
}

-(NSString *)title
{
    return self.shopName;
}

-(NSString *)shopTypeDisplay
{
    return self.shop.shopTypeDisplay;
}

-(NSString *)numOfComment
{
    return self.shop.numOfComment;
}

-(NSString *)numOfView
{
    return self.shop.numOfView;
}

-(enum LOVE_STATUS)enumLoveStatus
{
    return self.shop.enumLoveStatus;
}

-(NSString *)logo
{
    return self.shop.logo;
}

-(NSString *)address
{
    return self.shop.address;
}

-(NSNumber *)loveStatus
{
    return self.shop.loveStatus;
}

-(NSString *)numOfLove
{
    return self.shop.numOfLove;
}

-(NSString *)cover
{
    return self.shop.shopGalleryCover;
}

-(UIImage *)iconPin
{
    return [[ImageManager sharedInstance] shopPinWithType:self.shop.enumShopType];
}

@end
