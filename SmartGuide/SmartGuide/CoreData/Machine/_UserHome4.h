// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserHome4.h instead.

#import <CoreData/CoreData.h>

#define UserHome4_ClassName @"UserHome4"

#define UserHome4_Content @"content"
#define UserHome4_Cover @"cover"
#define UserHome4_ShopName @"shopName"
#define UserHome4_SortOrder @"sortOrder"

@class UserHome4;
@class UserHome;
@class Shop;

@interface _UserHome4 : NSManagedObject

+(UserHome4*) insert;
+(UserHome4*) temporary;
+(NSArray*) queryUserHome4:(NSPredicate*) predicate;
+(UserHome4*) queryUserHome4Object:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* content;
@property (nonatomic, retain) NSString* cover;
@property (nonatomic, retain) NSString* shopName;
@property (nonatomic, retain) NSNumber* sortOrder;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Home
@property (nonatomic, retain) UserHome* home;

#pragma mark Shop
@property (nonatomic, retain) Shop* shop;



#pragma mark Utility

-(void) revert;

@end