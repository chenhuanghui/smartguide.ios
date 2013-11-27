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


+(Shop*) makeShopWithIDShop:(int) idShop withJSONUserCollection:(NSDictionary*) data
{
    Shop *shop=[Shop makeShopWithIDShop:idShop withJSONShopInGroup:data];
    
    //shop.updated_at=[NSString stringWithStringDefault:[data objectForKey:@"updated_at"]];
    
    return shop;
}

+(Shop*) makeShopWithIDShop:(int) idShop withJSONShopInGroup:(NSDictionary*) data;
{
    Shop *shop = [Shop shopWithIDShop:idShop];
    if(!shop)
    {
        shop=[Shop insert];
        shop.idShop=[NSNumber numberWithInt:idShop];
    }
    
    [shop removeShopGallerys:shop.shopGallerys];
    [shop removeUserGallerys:shop.userGallerys];
    [shop removeUserComments:shop.userComments];
    
    shop.shopName=[NSString stringWithStringDefault:data[@"shopName"]];
    shop.shopLat=[NSNumber numberWithObject:data[@"shopLat"]];
    shop.shopLng=[NSNumber numberWithObject:data[@"shopLng"]];
    shop.groupName=[NSString stringWithStringDefault:data[@"groupName"]];
    shop.logo=[NSString stringWithStringDefault:data[@"logo"]];
    shop.loveStatus=[NSNumber numberWithObject:data[@"loveStatus"]];
    shop.numOfLove=[NSString stringWithStringDefault:data[@"numOfLove"]];
    shop.numOfView=[NSString stringWithStringDefault:data[@"numOfView"]];
    shop.numOfComment=[NSString stringWithStringDefault:data[@"numOfComment"]];
    shop.address=[NSString stringWithStringDefault:data[@"address"]];
    shop.city=[NSString stringWithStringDefault:data[@"city"]];
    shop.tel=[NSString stringWithStringDefault:data[@"tel"]];
    shop.displayTel=[NSString stringWithStringDefault:data[@"displayTel"]];
    
    NSArray *array=data[@"shopGallery"];
    
    if(![array isNullData])
    {
        int sortOrder=0;
        for(NSDictionary *dict in array)
        {
            ShopGallery *obj=[ShopGallery makeWithJSON:dict];
            obj.shop=shop;
            obj.sortOrder=@(sortOrder++);
            obj.idGallery=@(0);
        }
    }
    
    array=data[@"userGallery"];
    
    if(![array isNullData])
    {
        int sortOrder=0;
        for(NSDictionary *dict in array)
        {
            ShopUserGallery *obj=[ShopUserGallery makeWithJSON:dict];
            obj.shop=shop;
            obj.sortOrder=@(sortOrder++);
            obj.idGallery=@(0);
        }
    }
    
    array=data[@"comments"];
    
    if(![array isNullData])
    {
        int sortOrder=0;
        for(NSDictionary *dict in array)
        {
            ShopUserComment *obj=[ShopUserComment makeWithJSON:dict];
            obj.shop=shop;
            obj.sortOrder=@(sortOrder++);
            obj.idComment=@(0);
        }
    }
    
    [shop.km1s markDeleted];
    
    shop.promotionType=[NSNumber numberWithObject:data[@"promotionType"]];
    
    NSDictionary *promotionDetail=data[@"promotionDetail"];
    
    switch (shop.shopPromotionType) {
        case SHOP_PROMOTION_NONE:
            
            break;
            
        case SHOP_PROMOTION_KM1:
        {
            if(![promotionDetail isNullData])
            {
                ShopKM1 *km1=[ShopKM1 makeWithJSON:promotionDetail];
                km1.shop=shop;
                km1.idKM1=@(0);
                
                NSArray *voucherList=promotionDetail[@"voucherList"];
                
                if(![voucherList isNullData])
                {
                    int sortOrder=0;
                    for(NSDictionary *dict in voucherList)
                    {
                        KM1Voucher *voucher=[KM1Voucher makeWithJSON:dict];
                        voucher.shopKM1=km1;
                        voucher.sortOrder=@(sortOrder++);
                        voucher.idVoucher=@(0);
                    }
                }
            }
        }
            break;
            
        default:
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

@end