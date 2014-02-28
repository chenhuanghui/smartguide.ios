#import "ShopList.h"
#import "Utility.h"
#import "ImageManager.h"

@implementation ShopList
@synthesize shopNameHeight,addressHeight,shopNameSize,shopTypeSize;

+(ShopList *)shopListWithIDShop:(int)idShop
{
    Shop *shop=[Shop shopWithIDShop:idShop];
    
    if(shop)
        return shop.shopList;
    
    return nil;
}

+(ShopList *)makeWithDictionary:(NSDictionary *)dict
{
    int idShop=[[NSNumber numberWithObject:dict[@"idShop"]] integerValue];
    
    ShopList *obj=[ShopList shopListWithIDShop:idShop];
    
    if(!obj)
    {
        obj=[ShopList insert];
    }
    
    obj.shop=[Shop shopWithIDShop:idShop];
    
    if(!obj.shop)
    {
        obj.shop=[Shop insert];
        obj.shop.idShop=@(idShop);
        obj.shop.shopName=[NSString stringWithStringDefault:dict[@"shopName"]];
        obj.shop.dataMode=@(SHOP_DATA_SHOP_LIST);
    }
    
    obj.distance=[NSString stringWithStringDefault:dict[@"distance"]];
    obj.desc=[NSString stringWithStringDefault:dict[@"description"]];
    obj.shopName=[NSString stringWithStringDefault:dict[@"shopName"]];
    
    obj.shop.promotionType=[NSNumber numberWithObject:dict[@"promotionType"]];
    obj.shop.shopType=[NSNumber numberWithObject:dict[@"shopType"]];
    obj.shop.shopTypeDisplay=[NSString stringWithStringDefault:dict[@"shopTypeDisplay"]];
    obj.shop.shopName=[NSString stringWithStringDefault:dict[@"shopName"]];
    obj.shop.address=[NSString stringWithStringDefault:dict[@"address"]];
    obj.shop.shopLat=[NSNumber numberWithObject:dict[@"shopLat"]];
    obj.shop.shopLng=[NSNumber numberWithObject:dict[@"shopLng"]];
    obj.shop.loveStatus=[NSNumber numberWithObject:dict[@"loveStatus"]];
    obj.shop.numOfLove=[NSString stringWithStringDefault:dict[@"numOfLove"]];
    obj.shop.numOfView=[NSString stringWithStringDefault:dict[@"numOfView"]];
    obj.shop.logo=[NSString stringWithStringDefault:dict[@"logo"]];
    obj.shop.numOfComment=[NSString stringWithStringDefault:dict[@"numOfComment"]];
    
    NSDictionary *dictShopGallery=dict[@"shopGallery"];
    
    if(![dictShopGallery isNullData])
    {
        obj.shop.shopGalleryCover=[NSString stringWithStringDefault:dictShopGallery[@"cover"]];
        obj.shop.shopGalleryImage=[NSString stringWithStringDefault:dictShopGallery[@"image"]];
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

-(NSNumber *)idShop
{
    return self.shop.idShop;
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
