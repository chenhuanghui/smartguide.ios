#import "_StoreShopItem.h"

@interface StoreShopItem : _StoreShopItem 
{
}

+(StoreShopItem*) itemWithID:(int) idItem;
+(StoreShopItem*) makeItemWithDictionary:(NSDictionary*) dict;

-(void) buy;

@end
