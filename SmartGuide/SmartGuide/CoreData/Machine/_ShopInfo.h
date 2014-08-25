// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopInfo.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define ShopInfo_ClassName @"ShopInfo"

#define ShopInfo_IdShop @"idShop"
#define ShopInfo_Logo @"logo"
#define ShopInfo_Name @"name"
#define ShopInfo_ShopLat @"shopLat"
#define ShopInfo_ShopLng @"shopLng"

@class ShopInfo;
@class HomeShop;

@interface _ShopInfo : NSManagedObject

+(ShopInfo*) insert;
+(ShopInfo*) temporary;
+(NSArray*) queryShopInfo:(NSPredicate*) predicate;
+(ShopInfo*) queryShopInfoObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSNumber* idShop;
@property (nonatomic, retain) NSString* logo;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSNumber* shopLat;
@property (nonatomic, retain) NSNumber* shopLng;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Home
@property (nonatomic, retain) HomeShop* home;



#pragma mark Utility

-(void) revert;

@end