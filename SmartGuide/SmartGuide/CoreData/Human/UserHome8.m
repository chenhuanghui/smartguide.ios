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
        home.shop.dataMode=@(SHOP_DATA_HOME_8);
    }
    
    home.content=[NSString stringWithStringDefault:dict[@"content"]];
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

-(NSNumber *)shopType
{
    return self.shop.shopType;
}

-(NSString *)shopTypeDisplay
{
    return self.shop.shopTypeDisplay;
}

-(NSNumber *)idShop
{
    return self.shop.idShop;
}

-(NSNumber *)loveStatus
{
    return self.shop.loveStatus;
}

-(NSString *)numOfLove
{
    return self.shop.numOfLove;
}

-(NSString *)numOfView
{
    return self.shop.numOfView;
}

-(NSString *)numOfComment
{
    return self.shop.numOfComment;
}

-(NSString *)logo
{
    return self.shop.logo;
}

-(NSString *)cover
{
    return self.shop.shopGalleryCover;
}

-(NSString *)coverFull
{
    return self.shop.shopGalleryImage;
}

@end
