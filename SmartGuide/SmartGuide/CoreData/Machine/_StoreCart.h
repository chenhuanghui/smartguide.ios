// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to StoreCart.h instead.

#import <CoreData/CoreData.h>

#define StoreCart_ClassName @"StoreCart"

#define StoreCart_IdItem @"idItem"
#define StoreCart_Quantity @"quantity"

@class StoreCart;
@class StoreShopItem;

@interface _StoreCart : NSManagedObject

+(StoreCart*) insert;
+(StoreCart*) temporary;
+(NSArray*) queryStoreCart:(NSPredicate*) predicate;
+(StoreCart*) queryStoreCartObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSNumber* idItem;
@property (nonatomic, retain) NSNumber* quantity;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Item
@property (nonatomic, retain) StoreShopItem* item;



#pragma mark Utility

-(void) revert;

@end