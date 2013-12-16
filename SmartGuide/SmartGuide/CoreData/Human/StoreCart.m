#import "StoreCart.h"
#import "StoreShopItem.h"

@implementation StoreCart

+(StoreCart *)cartWithIDItem:(int)idItem
{
    return [StoreCart queryStoreCartObject:[NSPredicate predicateWithFormat:@"%K == %i",StoreCart_IdItem,idItem]];
}

+(StoreCart *)makeWithItem:(StoreShopItem *)item
{
    StoreCart *cart=[StoreCart cartWithIDItem:item.idItem.integerValue];
    
    if(!cart)
    {
        cart=[StoreCart insert];
        cart.idItem=item.idItem;
        cart.item=item;
        cart.quantity=@(0);
    }
    
    return cart;
}

@end
