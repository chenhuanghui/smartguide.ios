#import "UserHome8.h"
#import "Utility.h"
#import "Shop.h"

@implementation UserHome8

+(UserHome8 *)makeWithDictionary:(NSDictionary *)dict
{
    UserHome8 *home=[UserHome8 insert];
    
    home.idShop=[NSNumber makeNumber:dict[@"idShop"]];
    home.shop=[Shop shopWithIDShop:home.idShop.integerValue];
    if(!home.shop)
    {
        home.shop=[Shop insert];
        home.shop.idShop=home.idShop;
        home.shop.shopName=[NSString makeString:dict[@"shopName"]];
        home.shop.dataMode=@(SHOP_DATA_HOME_8);
    }
    
    home.content=[NSString makeString:dict[@"content"]];
    home.shopName=[NSString makeString:dict[@"shopName"]];
    
    home.shop.shopType=[NSNumber makeNumber:dict[@"shopType"]];
    home.shop.shopTypeDisplay=[NSString makeString:dict[@"shopTypeDisplay"]];
    home.shop.loveStatus=[NSNumber makeNumber:dict[@"loveStatus"]];
    home.shop.numOfLove=[NSString makeString:dict[@"numOfLove"]];
    home.shop.numOfView=[NSString makeString:dict[@"numOfView"]];
    home.shop.numOfComment=[NSString makeString:dict[@"numOfComment"]];
    home.shop.logo=[NSString makeString:dict[@"logo"]];
    home.shop.shopGalleryCover=[NSString makeString:dict[@"cover"]];
    home.shop.shopGalleryImage=[NSString makeString:dict[@"image"]];
    
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
