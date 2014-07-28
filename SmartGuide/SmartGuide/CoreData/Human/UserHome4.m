#import "UserHome4.h"
#import "Utility.h"

@implementation UserHome4

+(UserHome4 *)makeWithDictionary:(NSDictionary *)dict
{
    UserHome4 *home=[UserHome4 insert];
    
    home.idShop=[NSNumber makeNumber:dict[@"idShop"]];
    home.shop=[Shop shopWithIDShop:home.idShop.integerValue];
    
    if(!home.shop)
    {
        home.shop=[Shop insert];
        home.shop.idShop=home.idShop;
        home.shop.dataMode=@(SHOP_DATA_HOME_4);
    }
    
    home.shop.numOfView=[NSString makeString:dict[@"numOfView"]];
    home.shopName=[NSString makeString:dict[@"shopName"]];
    home.content=[NSString makeString:dict[@"content"]];
    home.cover=[NSString makeString:dict[@"cover"]];
    
    return home;
}

-(NSString *)numOfView
{
    return self.shop.numOfView;
}

@end
