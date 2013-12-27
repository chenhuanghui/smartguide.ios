#import "_StoreShop.h"

@interface StoreShop : _StoreShop 
{
}

+(StoreShop*) storeWithID:(int) idShop;
+(StoreShop*) makeWithDictionary:(NSDictionary*) dict;

@end
