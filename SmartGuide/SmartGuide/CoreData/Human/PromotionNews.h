#import "_PromotionNews.h"

@interface PromotionNews : _PromotionNews 
{
}

+(PromotionNews*) makeWithDictionary:(NSDictionary*) dict;

@property (nonatomic, assign) float titleHeight;
@property (nonatomic, assign) float contentHeight;

@end
