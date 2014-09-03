#import "_ShopInfoList.h"

@interface ShopInfoList : _ShopInfoList 
{
}

+(ShopInfoList*) makeWithData:(NSDictionary*) dict;

@property (nonatomic, assign) CGRect descRect;
@property (nonatomic, assign) CGRect nameRect;
@property (nonatomic, assign) CGRect addressRect;

@end
