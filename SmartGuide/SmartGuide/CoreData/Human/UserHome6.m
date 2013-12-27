#import "UserHome6.h"
#import "Utility.h"

@implementation UserHome6

+(UserHome6 *)makeWithDictionary:(NSDictionary *)dict
{
    UserHome6 *home=[UserHome6 insert];
    
    int idShop=[[NSNumber numberWithObject:dict[@"idShop"]] integerValue];
    
    home.shop=[Shop shopWithIDShop:idShop];
    
    if(!home.shop)
    {
        home.shop=[Shop insert];
        home.shop.idShop=@(idShop);
    }

    home.shop.logo=[NSString stringWithStringDefault:dict[@"logo"]];
    
    home.shopName=[NSString stringWithStringDefault:dict[@"shopName"]];
    home.date=[NSString stringWithStringDefault:dict[@"date"]];
    home.cover=[NSString stringWithStringDefault:dict[@"cover"]];
    home.title=[NSString stringWithStringDefault:dict[@"title"]];
    home.content=[NSString stringWithStringDefault:dict[@"content"]];
    home.gotoshop=[NSString stringWithStringDefault:dict[@"goto"]];
    
    return home;
}

-(NSNumber *)idShop
{
    return self.shop.idShop;
}

-(NSString *)logo
{
    return self.shop.logo;
}

@end
