// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to StoreShop.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define StoreShop_ClassName @"StoreShop"

#define StoreShop_Condition @"condition"
#define StoreShop_ConditionPair @"conditionPair"
#define StoreShop_Desc @"desc"
#define StoreShop_IdStore @"idStore"
#define StoreShop_Logo @"logo"
#define StoreShop_SortOrder @"sortOrder"
#define StoreShop_StoreName @"storeName"
#define StoreShop_StoreType @"storeType"
#define StoreShop_Total @"total"

@class StoreShop;
@class UserHome5;
@class UserHome7;
@class StoreShopItem;
@class StoreShopItem;

@interface _StoreShop : NSManagedObject

+(StoreShop*) insert;
+(StoreShop*) temporary;
+(NSArray*) queryStoreShop:(NSPredicate*) predicate;
+(StoreShop*) queryStoreShopObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* condition;
@property (nonatomic, retain) NSString* conditionPair;
@property (nonatomic, retain) NSString* desc;
@property (nonatomic, retain) NSNumber* idStore;
@property (nonatomic, retain) NSString* logo;
@property (nonatomic, retain) NSNumber* sortOrder;
@property (nonatomic, retain) NSString* storeName;
@property (nonatomic, retain) NSString* storeType;
@property (nonatomic, retain) NSString* total;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Home5
- (NSSet*) home5;
- (NSArray*) home5Objects;
- (void) addHome5:(NSSet*)value;
- (void) removeHome5:(NSSet*)value;
- (void) addHome5Object:(UserHome5*)value;
- (void) removeHome5Object:(UserHome5*)value;
- (void) removeAllHome5;

#pragma mark Home7
- (NSSet*) home7;
- (NSArray*) home7Objects;
- (void) addHome7:(NSSet*)value;
- (void) removeHome7:(NSSet*)value;
- (void) addHome7Object:(UserHome7*)value;
- (void) removeHome7Object:(UserHome7*)value;
- (void) removeAllHome7;

#pragma mark LatestItems
- (NSSet*) latestItems;
- (NSArray*) latestItemsObjects;
- (void) addLatestItems:(NSSet*)value;
- (void) removeLatestItems:(NSSet*)value;
- (void) addLatestItemsObject:(StoreShopItem*)value;
- (void) removeLatestItemsObject:(StoreShopItem*)value;
- (void) removeAllLatestItems;

#pragma mark TopSellerItems
- (NSSet*) topSellerItems;
- (NSArray*) topSellerItemsObjects;
- (void) addTopSellerItems:(NSSet*)value;
- (void) removeTopSellerItems:(NSSet*)value;
- (void) addTopSellerItemsObject:(StoreShopItem*)value;
- (void) removeTopSellerItemsObject:(StoreShopItem*)value;
- (void) removeAllTopSellerItems;



#pragma mark Utility

-(void) revert;

@end