// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserHome3.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define UserHome3_ClassName @"UserHome3"

#define UserHome3_Content @"content"
#define UserHome3_Cover @"cover"
#define UserHome3_NumOfShop @"numOfShop"
#define UserHome3_SortOrder @"sortOrder"
#define UserHome3_Title @"title"

@class UserHome3;
@class UserHome;
@class Placelist;

@interface _UserHome3 : NSManagedObject

+(UserHome3*) insert;
+(UserHome3*) temporary;
+(NSArray*) queryUserHome3:(NSPredicate*) predicate;
+(UserHome3*) queryUserHome3Object:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* content;
@property (nonatomic, retain) NSString* cover;
@property (nonatomic, retain) NSString* numOfShop;
@property (nonatomic, retain) NSNumber* sortOrder;
@property (nonatomic, retain) NSString* title;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Home
@property (nonatomic, retain) UserHome* home;

#pragma mark Place
@property (nonatomic, retain) Placelist* place;



#pragma mark Utility

-(void) revert;

@end