#import "StoreShopItem.h"
#import "Utility.h"
#import "StoreCart.h"
#import "DataManager.h"

@implementation StoreShopItem

+(StoreShopItem *)itemWithID:(int)idItem
{
    return [StoreShopItem queryStoreShopItemObject:[NSPredicate predicateWithFormat:@"%K == %i",StoreShopItem_IdItem,idItem]];
}

+(StoreShopItem *) makeItemWithDictionary:(NSDictionary *)dictItem
{
    int idItem=[[NSNumber numberWithObject:dictItem[@"idItem"]] integerValue];
    StoreShopItem *item=[StoreShopItem itemWithID:idItem];
    
    if(!item)
    {
        item=[StoreShopItem insert];
        item.idItem=@(idItem);
    }
    
    item.price=[NSString stringWithStringDefault:dictItem[@"price"]];
    item.p=[NSString stringWithStringDefault:dictItem[@"p"]];
    item.money=[NSString stringWithStringDefault:dictItem[@"money"]];
    item.desc=[NSString stringWithStringDefault:dictItem[@"description"]];
    item.image=[NSString stringWithStringDefault:dictItem[@"image"]];
    
    return item;
}

-(void)buy
{
    StoreCart *cart=[StoreCart makeWithItem:self];
    
    cart.quantity=@(cart.quantity.integerValue+1);
    
    [[DataManager shareInstance] save];
}

@end
