// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopList.h instead.

#import <CoreData/CoreData.h>

#define ShopList_ClassName @"ShopList"

#define ShopList_Desc @"desc"
#define ShopList_Distance @"distance"
#define ShopList_ShopName @"shopName"

@class ShopList;
@class Placelist;
@class Shop;

@interface _ShopList : NSManagedObject

+(ShopList*) insert;
+(ShopList*) temporary;
+(NSArray*) queryShopList:(NSPredicate*) predicate;
+(ShopList*) queryShopListObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* desc;
@property (nonatomic, retain) NSString* distance;
@property (nonatomic, retain) NSString* shopName;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark PlaceList
@property (nonatomic, retain) Placelist* placeList;

#pragma mark Shop
@property (nonatomic, retain) Shop* shop;



#pragma mark Utility

-(void) revert;

@end