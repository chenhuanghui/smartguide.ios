#import "_StoreShop.h"

@interface StoreShop : _StoreShop 
{
}

+(StoreShop*) shopWithID:(int) idShop;
+(StoreShop*) makeWithDictionary:(NSDictionary*) dict;

@end
