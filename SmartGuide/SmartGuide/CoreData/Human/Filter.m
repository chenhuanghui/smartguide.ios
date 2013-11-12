#import "Filter.h"

@implementation Filter

-(enum SORT_BY)sortBy
{
    if(self.distance.boolValue)
        return SORT_DISTANCE;
    else if(self.mostLike.boolValue)
        return SORT_LIKED;
    else if(self.mostView.boolValue)
        return SORT_VIEWED;
    
    return SORT_DISTANCE;
}

-(enum SHOP_PROMOTION_FILTER_TYPE)shopPromotionFilterType
{
    if(self.isShopKM.boolValue)
        return SHOP_PROMOTION_FILTER_HAS_PROMOTION;
    
    return SHOP_PROMOTION_FILTER_ALL;
}

-(NSString *)groups
{
    NSMutableString *str=[[NSMutableString alloc] initWithString:@""];
    
    if(self.food.boolValue)
        [str appendString:@"1,"];
    if(self.drink.boolValue)
        [str appendString:@"2,"];
    if(self.health.boolValue)
        [str appendString:@"3,"];
    if(self.entertaiment.boolValue)
        [str appendString:@"4,"];
    if(self.fashion.boolValue)
        [str appendString:@"5,"];
    if(self.travel.boolValue)
        [str appendString:@"6,"];
    if(self.production.boolValue)
        [str appendString:@"7,"];
    if(self.education.boolValue)
        [str appendString:@"8,"];
    
    if(str.length>0)
        [str deleteCharactersInRange:NSMakeRange(str.length-1, 1)];
    
    return str;
}

@end
