#import "Home.h"
#import "HomeImages.h"
#import "HomeShop.h"

@implementation Home

+(Home *)makeHomeWithData:(NSDictionary *)dict
{
    Home *obj=[Home insert];
    
    obj.type=[NSNumber makeNumber:dict[@"type"]];
    
    switch ([obj enumType]) {
        case HOME_TYPE_UNKNOW:
            break;
            
        case HOME_TYPE_IMAGES:
            obj.homeImage=[HomeImages makeWithData:dict];
            break;
            
        case HOME_TYPE_SHOP:
            obj.homeShop=[HomeShop makeWithData:dict];
            break;
    }
    
    return obj;
}

-(enum HOME_TYPE)enumType
{
    switch ((enum HOME_TYPE)self.type.integerValue) {
        case HOME_TYPE_SHOP:
            return HOME_TYPE_SHOP;
            
        case HOME_TYPE_IMAGES:
            return HOME_TYPE_IMAGES;
            
        case HOME_TYPE_UNKNOW:
            return HOME_TYPE_UNKNOW;
    }
    
    return HOME_TYPE_UNKNOW;
}

@end
