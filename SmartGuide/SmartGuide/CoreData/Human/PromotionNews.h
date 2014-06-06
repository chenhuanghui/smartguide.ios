#import "_PromotionNews.h"

@interface PromotionNews : _PromotionNews 
{
}

+(PromotionNews*) makeWithDictionary:(NSDictionary*) dict;

@property (nonatomic, strong) NSNumber *titleHeight;
@property (nonatomic, strong) NSNumber *contentHeight;
@property (nonatomic, strong) NSNumber *videoHeightForShop;
@property (nonatomic, strong) NSNumber *imageHeightForShop;
@property (nonatomic, strong) NSNumber *kmHeight;

@end
