// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserHome8.h instead.

#import <CoreData/CoreData.h>

#define UserHome8_ClassName @"UserHome8"

#define UserHome8_Content @"content"
#define UserHome8_ShopName @"shopName"

@class UserHome8;
@class UserHome;
@class Shop;

@interface _UserHome8 : NSManagedObject

+(UserHome8*) insert;
+(UserHome8*) temporary;
+(NSArray*) queryUserHome8:(NSPredicate*) predicate;
+(UserHome8*) queryUserHome8Object:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* content;
@property (nonatomic, retain) NSString* shopName;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Home
@property (nonatomic, retain) UserHome* home;

#pragma mark Shop
@property (nonatomic, retain) Shop* shop;


@end