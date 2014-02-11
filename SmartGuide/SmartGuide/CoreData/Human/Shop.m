#import "Shop.h"
#import "Utility.h"
#import "Constant.h"

static NSMutableDictionary *_dictPinShop=nil;

@implementation Shop
@synthesize descHeight,shopNameHeight,addressHeight;

-(id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self=[super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    self.shopLat=[NSNumber numberWithDouble:-1];
    self.shopLng=[NSNumber numberWithDouble:-1];
    
    _dragCoord=CLLocationCoordinate2DMake(-1, -1);
    
    return self;
}

+(Shop *)shopWithIDShop:(int)idShop
{
    return [Shop queryShopObject:[NSPredicate predicateWithFormat:@"%K == %i",Shop_IdShop,idShop]];
}

-(CLLocationCoordinate2D)coordinate
{
    if(isVailCLLocationCoordinate2D(_dragCoord))
        return _dragCoord;
    
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

    [shop removeAllTimeComments];
    [shop removeAllTopComments];
    [shop removeAllUserGalleries];
    [shop removeAllShopGalleries];
    shop.km1=nil;
    shop.km2=nil;
    
    shop.dataMode=@(SHOP_DATA_FULL);
    
    shop.shopName=[NSString stringWithStringDefault:dict[@"shopName"]];
    shop.shopType=[NSNumber numberWithObject:dict[@"shopType"]];
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
            
            [shop addTopCommentsObject:obj];
        }
    }
    
    switch (shop.enumPromotionType) {
        case SHOP_PROMOTION_NONE:
            
            break;
            
        case SHOP_PROMOTION_KM1:
            shop.km1=[ShopKM1 makeWithJSON:dict[@"promotionDetail"]];
            break;
            
        case SHOP_PROMOTION_KM2:
            shop.km2=[ShopKM2 makeWithDictionary:dict[@"promotionDetail"]];
            break;
    }
    
    shop.promotionNew=nil;
    
    if(![dict[@"promotionNews"] isNullData])
        shop.promotionNew=[PromotionNews makeWithDictionary:dict[@"promotionNews"]];
    
    return shop;
}

-(enum SHOP_PROMOTION_TYPE)enumPromotionType
{
    switch (self.promotionType.integerValue) {
        case 0:
            return SHOP_PROMOTION_NONE;
            
        case 1:
            return SHOP_PROMOTION_KM1;
            
        case 2:
            return SHOP_PROMOTION_KM2;
            
        default:
            return SHOP_PROMOTION_NONE;
    }
}

-(NSArray *) topCommentsObjects
{
    return [[super topCommentsObjects] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:ShopUserComment_SortOrder ascending:true]]];
}

-(NSArray *)timeCommentsObjects
{
    return [[super timeCommentsObjects] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:ShopUserComment_SortOrder ascending:true]]];
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

-(NSString *)title
{
    return self.shopName;
}

-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    _dragCoord=newCoordinate;
}

-(enum SHOP_DATA_MODE)enumDataMode
{
    switch (self.dataMode.integerValue) {
        case 0:
            return SHOP_DATA_SHOP_LIST;
            
        case 1:
            return SHOP_DATA_HOME_8;
            
        case 2:
            return SHOP_DATA_FULL;
    }
    
    return SHOP_DATA_HOME_8;
}

-(enum SHOP_TYPE)enumShopType
{
    switch (self.shopType.integerValue) {
        case SHOP_TYPE_ALL:
            return SHOP_TYPE_ALL;
            
        case SHOP_TYPE_FOOD:
            return SHOP_TYPE_FOOD;
            
        case SHOP_TYPE_CAFE:
            return SHOP_TYPE_CAFE;
            
        case SHOP_TYPE_HEALTH:
            return SHOP_TYPE_HEALTH;
            
        case SHOP_TYPE_ENTERTAIMENT:
            return SHOP_TYPE_ENTERTAIMENT;
            
        case SHOP_TYPE_FASHION:
            return SHOP_TYPE_FASHION;
            
        case SHOP_TYPE_TRAVEL:
            return SHOP_TYPE_TRAVEL;
            
        case SHOP_TYPE_PRODUCTION:
            return SHOP_TYPE_PRODUCTION;
            
        case SHOP_TYPE_EDUCATION:
            return SHOP_TYPE_EDUCATION;
            
        default:
            return SHOP_TYPE_ALL;
    }
}

-(UIImage *)iconPin
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dictPinShop=[[NSMutableDictionary alloc] initWithCapacity:9];
        
        [_dictPinShop setObject:[UIImage imageNamed:@"iconpin_education.png"] forKey:[NSString stringWithFormat:@"%i",SHOP_TYPE_EDUCATION]];
        [_dictPinShop setObject:[UIImage imageNamed:@"iconpin_entertaiment.png"] forKey:[NSString stringWithFormat:@"%i",SHOP_TYPE_ENTERTAIMENT]];
        [_dictPinShop setObject:[UIImage imageNamed:@"iconpin_fashion.png"] forKey:[NSString stringWithFormat:@"%i",SHOP_TYPE_FASHION]];
        [_dictPinShop setObject:[UIImage imageNamed:@"iconpin_food.png"] forKey:[NSString stringWithFormat:@"%i",SHOP_TYPE_FOOD]];
        [_dictPinShop setObject:[UIImage imageNamed:@"iconpin_healness.png"] forKey:[NSString stringWithFormat:@"%i",SHOP_TYPE_HEALTH]];
        [_dictPinShop setObject:[UIImage imageNamed:@"iconpin_shopping.png"] forKey:[NSString stringWithFormat:@"%i",SHOP_TYPE_PRODUCTION]];
        [_dictPinShop setObject:[UIImage imageNamed:@"iconpin_travel.png"] forKey:[NSString stringWithFormat:@"%i",SHOP_TYPE_TRAVEL]];
        [_dictPinShop setObject:[UIImage imageNamed:@"iconpin_drink.png"] forKey:[NSString stringWithFormat:@"%i",SHOP_TYPE_CAFE]];
    });
    
    return _dictPinShop[[NSString stringWithFormat:@"%i",[self enumShopType]]];
}

-(NSString *)shopName1
{
    return @"Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh";
}

-(NSString *)address1
{
    return @"Võ Văn Kiệt\nHồ Chí Minh";
}

-(NSString *)desc1
{
    return @"Lorem ipsum dolor sit amet, consectetuer adipiscing  ";
}

@end