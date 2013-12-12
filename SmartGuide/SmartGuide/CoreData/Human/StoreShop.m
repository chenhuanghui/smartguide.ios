#import "StoreShop.h"

@implementation StoreShop

+(StoreShop *)shopWithID:(int)idShop
{
    return [StoreShop queryStoreShopObject:[NSPredicate predicateWithFormat:@"%K == %i",StoreShop_IdShop,idShop]];
}

@end
