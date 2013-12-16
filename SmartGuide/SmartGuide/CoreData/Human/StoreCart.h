#import "_StoreCart.h"

@interface StoreCart : _StoreCart 
{
}

+(StoreCart*) cartWithIDItem:(int) idItem;
+(StoreCart*) makeWithItem:(StoreShopItem*) idItem;

@end
