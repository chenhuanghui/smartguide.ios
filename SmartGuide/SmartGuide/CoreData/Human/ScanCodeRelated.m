#import "ScanCodeRelated.h"

@implementation ScanCodeRelated
@synthesize descRect, nameRect;

+(ScanCodeRelated *)makeWithShopDictionary:(NSDictionary *)dict
{
    ScanCodeRelated *obj=[ScanCodeRelated insert];
    
    obj.type=@(SCANCODE_RELATED_TYPE_SHOPS);
    obj.idShop=[NSNumber makeNumber:dict[@"idShop"]];
    obj.shopName=[NSString makeString:dict[@"shopName"]];
    obj.logo=[NSString makeString:dict[@"logo"]];
    obj.desc=[NSString makeString:dict[@"description"]];
    obj.distance=[NSString makeString:dict[@"distance"]];
    
    return obj;
}

+(ScanCodeRelated *)makeWithPromotionDictionary:(NSDictionary *)dict
{
    ScanCodeRelated *obj=[ScanCodeRelated insert];
    
    obj.type=@(SCANCODE_RELATED_TYPE_PROMOTIONS);
    
    NSArray *idShops=dict[@"idShops"];
    
    if([idShops hasData])
        obj.idShops=[idShops componentsJoinedByString:@","];
    
    obj.promotionName=[NSString makeString:dict[@"promotionName"]];
    obj.logo=[NSString makeString:dict[@"logo"]];
    obj.time=[NSString makeString:dict[@"time"]];
    obj.desc=[NSString makeString:dict[@"description"]];
    
    return obj;
}

+(ScanCodeRelated *)makeWithPlacelistDictionary:(NSDictionary *)dict
{
    ScanCodeRelated *obj=[ScanCodeRelated insert];
    
    obj.type=@(SCANCODE_RELATED_TYPE_PLACELISTS);
    obj.idPlacelist=[NSNumber makeNumber:dict[@"placelistId"]];
    obj.placelistName=[NSString makeString:dict[@"placelistName"]];
    obj.authorAvatar=[NSString makeString:dict[@"authorAvatar"]];
    obj.desc=[NSString makeString:dict[@"description"]];
    
    return obj;
}

-(enum SCANCODE_RELATED_TYPE)enumType
{
    switch ((enum SCANCODE_RELATED_TYPE)self.type.integerValue) {
        case SCANCODE_RELATED_TYPE_PLACELISTS:
            return SCANCODE_RELATED_TYPE_PLACELISTS;
            
        case SCANCODE_RELATED_TYPE_PROMOTIONS:
            return SCANCODE_RELATED_TYPE_PROMOTIONS;
            
        case SCANCODE_RELATED_TYPE_SHOPS:
            return SCANCODE_RELATED_TYPE_SHOPS;
            
        case SCANCODE_RELATED_TYPE_UNKNOW:
            return SCANCODE_RELATED_TYPE_UNKNOW;
    }
    
    return SCANCODE_RELATED_TYPE_UNKNOW;
}

@end
