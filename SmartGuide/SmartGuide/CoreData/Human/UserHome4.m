#import "UserHome4.h"
#import "Utility.h"

@implementation UserHome4

+(UserHome4 *)makeWithDictionary:(NSDictionary *)dict
{
    UserHome4 *home=[UserHome4 insert];
    
    int idShop=[[NSNumber numberWithObject:dict[@"idShop"]] integerValue];
    
    home.shop=[Shop shopWithIDShop:idShop];
    
    if(!home.shop)
    {
        home.shop=[Shop insert];
        home.shop.idShop=@(idShop);
    }
    
    home.shop.numOfView=[NSString stringWithStringDefault:dict[@"numOfView"]];
    home.shopName=[NSString stringWithStringDefault:dict[@"shopName"]];
    home.content=[NSString stringWithStringDefault:dict[@"content"]];
    home.cover=[NSString stringWithStringDefault:dict[@"cover"]];
    
    return home;
}

-(NSString *)numOfView
{
    return self.shop.numOfView;
}

-(NSNumber *)idShop
{
    return self.shop.idShop;
}

@end
