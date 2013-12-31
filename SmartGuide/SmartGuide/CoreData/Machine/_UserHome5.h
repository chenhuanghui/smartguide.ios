// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserHome5.h instead.

#import <CoreData/CoreData.h>

#define UserHome5_ClassName @"UserHome5"

#define UserHome5_Content @"content"
#define UserHome5_Cover @"cover"
#define UserHome5_NumOfPurchase @"numOfPurchase"
#define UserHome5_SortOrder @"sortOrder"

@class UserHome5;
@class UserHome;
@class StoreShop;

@interface _UserHome5 : NSManagedObject

+(UserHome5*) insert;
+(UserHome5*) temporary;
+(NSArray*) queryUserHome5:(NSPredicate*) predicate;
+(UserHome5*) queryUserHome5Object:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* content;
@property (nonatomic, retain) NSString* cover;
@property (nonatomic, retain) NSString* numOfPurchase;
@property (nonatomic, retain) NSNumber* sortOrder;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Home
@property (nonatomic, retain) UserHome* home;

#pragma mark Store
@property (nonatomic, retain) StoreShop* store;


@end