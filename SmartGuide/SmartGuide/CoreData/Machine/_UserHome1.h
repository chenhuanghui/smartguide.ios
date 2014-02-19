// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserHome1.h instead.

#import <CoreData/CoreData.h>

#define UserHome1_ClassName @"UserHome1"

#define UserHome1_Content @"content"
#define UserHome1_Logo @"logo"
#define UserHome1_ShopList @"shopList"

@class UserHome1;
@class UserHome;

@interface _UserHome1 : NSManagedObject

+(UserHome1*) insert;
+(UserHome1*) temporary;
+(NSArray*) queryUserHome1:(NSPredicate*) predicate;
+(UserHome1*) queryUserHome1Object:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* content;
@property (nonatomic, retain) NSString* logo;
@property (nonatomic, retain) NSString* shopList;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Home
@property (nonatomic, retain) UserHome* home;



#pragma mark Utility

-(void) revert;

@end