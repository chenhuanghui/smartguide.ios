#import "HomeShop.h"
#import "ShopInfo.h"

@implementation HomeShop
@synthesize titleRect,contentRect,nameRect,descRect;

-(id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self=[super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    self.titleRect=CGRectZero;
    self.contentRect=CGRectZero;
    self.nameRect=CGRectZero;
    self.descRect=CGRectZero;
    
    return self;
}

+(HomeShop *)makeWithData:(NSDictionary *)dict
{
    HomeShop *obj=[HomeShop insert];
    
    obj.goTo=[NSString makeString:dict[@"goto"]];
    obj.date=[NSString makeString:dict[@"date"]];
    obj.cover=[NSString makeString:dict[@"cover"]];
    obj.coverWidth=[NSNumber makeNumber:dict[@"coverWidth"]];
    obj.coverHeight=[NSNumber makeNumber:dict[@"coverHeight"]];
    obj.title=[NSString makeString:dict[@"title"]];
    obj.content=[NSString makeString:dict[@"content"]];
    
    obj.shop=[ShopInfo shopWithIDShop:dict[@"idShop"]];
    if(!obj.shop)
    {
        obj.shop=[ShopInfo insert];
        obj.shop.idShop=[NSNumber makeNumber:dict[@"idShop"]];
        obj.shop.dataType=@(SHOPINFO_DATA_TYPE_HOME);
    }
    
    obj.shop.logo=[NSString makeString:dict[@"logo"]];
    obj.shop.name=[NSString makeString:dict[@"shopName"]];
    obj.shop.shopLat=[NSNumber makeNumber:dict[@"shopLat"]];
    obj.shop.shopLng=[NSNumber makeNumber:dict[@"shopLng"]];
    
    return obj;
}

@end
