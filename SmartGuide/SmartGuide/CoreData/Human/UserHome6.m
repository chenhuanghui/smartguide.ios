#import "UserHome6.h"
#import "Utility.h"

@implementation UserHome6
@synthesize contentAttribute;

-(id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self=[super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    return self;
}

+(UserHome6 *)makeWithDictionary:(NSDictionary *)dict
{
    UserHome6 *home=[UserHome6 insert];
    
    home.idShop=[NSNumber makeNumber:dict[@"idShop"]];
    home.shop=[Shop shopWithIDShop:home.idShop.integerValue];
    
    if(!home.shop)
    {
        home.shop=[Shop insert];
        home.shop.idShop=home.idShop;
        home.shop.dataMode=@(SHOP_DATA_HOME_6);
    }

    home.shop.logo=[NSString makeString:dict[@"logo"]];
    
    home.shopName=[NSString makeString:dict[@"shopName"]];
    home.date=[NSString makeString:dict[@"date"]];
    home.cover=[NSString makeString:dict[@"cover"]];
    home.title=[NSString makeString:dict[@"title"]];
    home.content=[NSString makeString:dict[@"content"]];
    home.gotoshop=[NSString makeString:dict[@"goto"]];
    home.coverHeight=[NSNumber makeNumber:dict[@"coverHeight"]];
    home.coverWidth=[NSNumber makeNumber:dict[@"coverWidth"]];
    
    return home;
}

-(NSString *)logo
{
    return self.shop.logo;
}

@end
