#import "Shop.h"
#import "Utility.h"
#import "Constant.h"

@implementation Shop

-(id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self=[super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    self.shopLat=[NSNumber numberWithDouble:-1];
    self.shopLng=[NSNumber numberWithDouble:-1];
    
    return self;
}

+(Shop *)shopWithIDShop:(int)idShop
{
    return [Shop queryShopObject:[NSPredicate predicateWithFormat:@"%K == %i",Shop_IdShop,idShop]];
}

-(CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake(self.shopLat.doubleValue, self.shopLng.doubleValue);
}

+(Shop *)makeShopWithDictionary:(NSDictionary *)dict
{
    int idShop=[[NSNumber numberWithObject:dict[@"idShop"]] integerValue];
    
    Shop *shop=[Shop shopWithIDShop:idShop];
    
    if(!shop)
    {
        shop=[Shop insert];
        shop.idShop=@(idShop);
    }
    
    [shop removeAllUserComments];
    [shop removeAllUserGalleries];
    [shop removeAllShopGalleries];
    [shop removeAllDetailInfo];
    shop.km1=nil;
    
    shop.shopName=[NSString stringWithStringDefault:dict[@"shopName"]];
    shop.shopType=[NSString stringWithStringDefault:dict[@"shopType"]];
    shop.shopLat=[NSNumber numberWithObject:dict[@"shopLat"]];
    shop.shopLng=[NSNumber numberWithObject:dict[@"shopLng"]];
    shop.logo=[NSString stringWithStringDefault:dict[@"logo"]];
    shop.loveStatus=[NSNumber numberWithObject:dict[@"loveStatus"]];
    shop.numOfLove=[NSString stringWithStringDefault:dict[@"numOfLove"]];
    shop.numOfView=[NSString stringWithStringDefault:dict[@"numOfView"]];
    shop.numOfComment=[NSString stringWithStringDefault:dict[@"numOfComment"]];
    shop.address=[NSString stringWithStringDefault:dict[@"address"]];
    shop.city=[NSString stringWithStringDefault:dict[@"city"]];
    shop.tel=[NSString stringWithStringDefault:dict[@"tel"]];
    shop.displayTel=[NSString stringWithStringDefault:dict[@"displayTel"]];
    shop.desc=[NSString stringWithStringDefault:dict[@"description"]];
    shop.promotionType=[NSNumber numberWithObject:dict[@"promotionType"]];
    
    NSArray *array=dict[@"shopGallery"];
    
    if(![array isNullData])
    {
        int i=0;
        for(NSDictionary *gallery in array)
        {
            ShopGallery *sg=[ShopGallery makeWithJSON:gallery];
            sg.sortOrder=@(i++);
            
            [shop addShopGalleriesObject:sg];
        }
    }
    
    array=dict[@"userGallery"];
    
    if(![array isNullData])
    {
        int i=0;
        
        for(NSDictionary *userGallery in array)
        {
            ShopUserGallery *su = [ShopUserGallery makeWithJSON:userGallery];
            su.sortOrder=@(i++);
            
            [shop addUserGalleriesObject:su];
        }
    }
    
    array=dict[@"comments"];
    
    if(![array isNullData])
    {
        int i=0;
        
        for(NSDictionary *comment in array)
        {
            ShopUserComment *obj = [ShopUserComment makeWithJSON:comment];
            
            obj.sortOrder=@(i++);
            
            [shop addUserCommentsObject:obj];
        }
    }
    
    switch (shop.shopPromotionType) {
        case SHOP_PROMOTION_NONE:
            
            break;
            
        case SHOP_PROMOTION_KM1:
        {
            shop.km1=[ShopKM1 makeWithJSON:dict[@"promotionDetail"]];
        }
            break;
            
        case SHOP_PROMOTION_KM2:
            break;
            
        case SHOP_PROMOTION_KM3:
            break;
    }
    
    return shop;
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

-(NSArray *)userCommentsObjects
{
    return [[super userCommentsObjects] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:ShopUserComment_SortOrder ascending:true]]];
}

-(NSArray *)userGalleriesObjects
{
    return [[super userGalleriesObjects] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:ShopUserGallery_SortOrder ascending:true]]];
}

-(NSArray *)shopGalleriesObjects
{
    return [[super shopGalleriesObjects] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:ShopGallery_SortOrder ascending:true]]];
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

@end