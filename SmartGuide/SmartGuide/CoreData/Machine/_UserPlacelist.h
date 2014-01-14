// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserPlacelist.h instead.

#import <CoreData/CoreData.h>

#define UserPlacelist_ClassName @"UserPlacelist"

#define UserPlacelist_IdPlacelist @"idPlacelist"
#define UserPlacelist_IsTicked @"isTicked"
#define UserPlacelist_Name @"name"
#define UserPlacelist_NumOfShop @"numOfShop"

@class UserPlacelist;

@interface _UserPlacelist : NSManagedObject

+(UserPlacelist*) insert;
+(UserPlacelist*) temporary;
+(NSArray*) queryUserPlacelist:(NSPredicate*) predicate;
+(UserPlacelist*) queryUserPlacelistObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSNumber* idPlacelist;
@property (nonatomic, retain) NSNumber* isTicked;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* numOfShop;

#pragma mark Fetched property

    
#pragma mark Relationships


@end