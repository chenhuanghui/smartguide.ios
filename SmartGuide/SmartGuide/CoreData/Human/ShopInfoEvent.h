#import "_ShopInfoEvent.h"

@interface ShopInfoEvent : _ShopInfoEvent 
{
}

+(ShopInfoEvent*) makeWithData:(NSDictionary*) dict;

@property (nonatomic, assign) CGRect titleRect;
@property (nonatomic, assign) CGRect contentRect;

@end
