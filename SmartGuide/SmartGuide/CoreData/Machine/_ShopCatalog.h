// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopCatalog.h instead.

#import <CoreData/CoreData.h>

#define ShopCatalog_ClassName @"ShopCatalog"

#define ShopCatalog_Count @"count"
#define ShopCatalog_IdCatalog @"idCatalog"
#define ShopCatalog_Name @"name"

@class ShopCatalog;
@class Shop;

@interface _ShopCatalog : NSManagedObject

+(ShopCatalog*) insert;
+(ShopCatalog*) temporary;
+(NSArray*) queryShopCatalog:(NSPredicate*) predicate;
+(ShopCatalog*) queryShopCatalogObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;

-(bool) save;


@property (nonatomic, retain) NSNumber* count;
@property (nonatomic, retain) NSNumber* idCatalog;
@property (nonatomic, retain) NSString* name;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Shops
- (NSSet*) shops;
- (NSArray*) shopsObjects;
- (void) addShops:(NSSet*)value;
- (void) removeShops:(NSSet*)value;
- (void) addShopsObject:(Shop*)value;
- (void) removeShopsObject:(Shop*)value;


@end