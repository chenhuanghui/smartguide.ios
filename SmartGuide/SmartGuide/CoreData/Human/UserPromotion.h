#import "_UserPromotion.h"

enum USER_PROMOTION_TYPE {
    USER_PROMOTION_UNKNOW = -1,
    USER_PROMOTION_BRAND = 0,
    USER_PROMOTION_SHOP = 1,
    USER_PROMOTION_STORE = 2,
    USER_PROMOTION_ITEM_STORE = 3
    };

@interface UserPromotion : _UserPromotion 
{
}

+(UserPromotion*) makeWithDictionary:(NSDictionary*) dict;
-(enum USER_PROMOTION_TYPE) promotionType;

@property (nonatomic, assign) float titleHeight;
@property (nonatomic, assign) float contentHeight;
@property (nonatomic, assign) CGSize imageHomeSize;

@end
