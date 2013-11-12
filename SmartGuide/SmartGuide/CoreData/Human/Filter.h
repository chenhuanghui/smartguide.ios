#import "_Filter.h"
#import "Constant.h"

@interface Filter : _Filter 
{
}

-(enum SORT_BY) sortBy;
-(enum SHOP_PROMOTION_FILTER_TYPE) shopPromotionFilterType;
-(NSString*) groups;

@end
