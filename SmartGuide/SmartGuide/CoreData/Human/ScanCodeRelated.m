#import "ScanCodeRelated.h"

@implementation ScanCodeRelated


+(ScanCodeRelated *)makeWithDictionary:(NSDictionary *)dict
{
    ScanCodeRelated *obj=[ScanCodeRelated insert];
    
    if([dict[@"relatedShops"] hasData])
    {
        NSDictionary *relatedShops=dict[@"relatedShops"];
        
        obj.type=@(SCANCODE_RELATED_TYPE_SHOPS);
        obj.idShop=[NSNumber makeNumber:relatedShops[@"idShop"]];
        obj.shopName=[NSString makeString:relatedShops[@"shopName"]];
        obj.logo=[NSString makeString:relatedShops[@"logo"]];
        obj.desc=[NSString makeString:relatedShops[@"description"]];
        obj.distance=[NSString makeString:relatedShops[@"distance"]];
    }
    else if([dict[@"relatedPromotions"] hasData])
    {
        NSDictionary *relatedPromotions=dict[@"relatedPromotions"];
        
        obj.type=@(SCANCODE_RELATED_TYPE_PROMOTIONS);
        
        NSArray *idShops=relatedPromotions[@"idShops"];
        
        if([idShops hasData])
            obj.idShops=[idShops componentsJoinedByString:@","];
        
        obj.promotionName=[NSString makeString:relatedPromotions[@"promotionName"]];
        obj.logo=[NSString makeString:relatedPromotions[@"logo"]];
        obj.time=[NSString makeString:relatedPromotions[@"time"]];
        obj.desc=[NSString makeString:relatedPromotions[@"description"]];
    }
    else if([dict[@"relatedPlacelists"] hasData])
    {
        NSDictionary *relatedPlacelists=dict[@"relatedPlacelists"];
        
        obj.type=@(SCANCODE_RELATED_TYPE_PLACELISTS);
        obj.idPlacelist=[NSNumber makeNumber:relatedPlacelists[@"placelistId"]];
        obj.placelistName=[NSString makeString:relatedPlacelists[@"placelistName"]];
        obj.authorAvatar=[NSString makeString:relatedPlacelists[@"authorAvatar"]];
        obj.desc=[NSString makeString:relatedPlacelists[@"description"]];
    }
    
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
