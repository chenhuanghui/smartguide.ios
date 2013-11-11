#import "Filter.h"

@implementation Filter

-(enum SORT_BY)sortBy
{
    if(self.distance.boolValue)
        return SORT_DISTANCE;
    else if(self.mostGetPoint.boolValue)
        return SORT_POINT;
    else if(self.mostGetReward.boolValue)
        return SORT_REWARD;
    else if(self.mostLike.boolValue)
        return SORT_LIKED;
    else if(self.mostView.boolValue)
        return SORT_VISITED;
    
    return SORT_DISTANCE;
}

-(enum SHOP_PROMOTION_FILTER_TYPE)shopPromotionFilterType
{
    if(self.isShopKM.boolValue)
        return SHOP_PROMOTION_FILTER_HAS_PROMOTION;
    
    return SHOP_PROMOTION_FILTER_ALL;
}

@end
