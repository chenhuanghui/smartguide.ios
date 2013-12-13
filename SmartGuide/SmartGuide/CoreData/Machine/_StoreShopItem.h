// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to StoreShopItem.h instead.

#import <CoreData/CoreData.h>

#define StoreShopItem_ClassName @"StoreShopItem"

#define StoreShopItem_Desc @"desc"
#define StoreShopItem_IdItem @"idItem"
#define StoreShopItem_Image @"image"
#define StoreShopItem_Money @"money"
#define StoreShopItem_P @"p"
#define StoreShopItem_Price @"price"
#define StoreShopItem_SortOrderLatest @"sortOrderLatest"
#define StoreShopItem_SortOrderTopSeller @"sortOrderTopSeller"

@class StoreShopItem;
@class StoreShop;
@class StoreShop;

@interface _StoreShopItem : NSManagedObject

+(StoreShopItem*) insert;
+(StoreShopItem*) temporary;
+(NSArray*) queryStoreShopItem:(NSPredicate*) predicate;
+(StoreShopItem*) queryStoreShopItemObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* desc;
@property (nonatomic, retain) NSNumber* idItem;
@property (nonatomic, retain) NSString* image;
@property (nonatomic, retain) NSString* money;
@property (nonatomic, retain) NSString* p;
@property (nonatomic, retain) NSString* price;
@property (nonatomic, retain) NSNumber* sortOrderLatest;
@property (nonatomic, retain) NSNumber* sortOrderTopSeller;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark ShopLatest
@property (nonatomic, retain) StoreShop* shopLatest;

#pragma mark ShopTopSeller
@property (nonatomic, retain) StoreShop* shopTopSeller;


@end