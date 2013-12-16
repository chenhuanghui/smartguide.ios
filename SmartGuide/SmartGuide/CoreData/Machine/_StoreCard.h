// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to StoreCard.h instead.

#import <CoreData/CoreData.h>

#define StoreCard_ClassName @"StoreCard"

#define StoreCard_IdItem @"idItem"
#define StoreCard_Quantity @"quantity"

@class StoreCard;
@class StoreShopItem;

@interface _StoreCard : NSManagedObject

+(StoreCard*) insert;
+(StoreCard*) temporary;
+(NSArray*) queryStoreCard:(NSPredicate*) predicate;
+(StoreCard*) queryStoreCardObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSNumber* idItem;
@property (nonatomic, retain) NSNumber* quantity;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Item
@property (nonatomic, retain) StoreShopItem* item;


@end