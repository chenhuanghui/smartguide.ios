#import "UserHome8.h"
#import "Utility.h"

@implementation UserHome8

+(UserHome8 *)makeWithDictionary:(NSDictionary *)dict
{
    UserHome8 *home=[UserHome8 insert];
    
    int idShop=[[NSNumber numberWithObject:dict[@"idShop"]] integerValue];
    
    home.shop=[Shop shopWithIDShop:idShop];
    if(!home.shop)
    {
        home.shop=[Shop insert];
        home.shop.idShop=@(idShop);
        home.shop.shopName=[NSString stringWithStringDefault:dict[@"shopName"]];
    }
    
    home.shopName=[NSString stringWithStringDefault:dict[@"shopName"]];
    home.shop.shopType=[NSNumber numberWithObject:dict[@"shopType"]];
    home.shop.shopTypeDisplay=[NSString stringWithStringDefault:dict[@"shopTypeDisplay"]];
    home.shop.loveStatus=[NSNumber numberWithObject:dict[@"loveStatus"]];
    home.shop.numOfLove=[NSString stringWithStringDefault:dict[@"numOfLove"]];
    home.shop.numOfView=[NSString stringWithStringDefault:dict[@"numOfView"]];
    home.shop.numOfComment=[NSString stringWithStringDefault:dict[@"numOfComment"]];
    home.shop.logo=[NSString stringWithStringDefault:dict[@"logo"]];
    home.shop.shopGalleryCover=[NSString stringWithStringDefault:dict[@"cover"]];
    home.shop.shopGalleryImage=[NSString stringWithStringDefault:dict[@"image"]];
    
    return home;
}

@end
