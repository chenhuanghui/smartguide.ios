// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserHomeSection.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define UserHomeSection_ClassName @"UserHomeSection"

#define UserHomeSection_SortOrder @"sortOrder"

@class UserHomeSection;
@class UserHome;
@class UserHome;

@interface _UserHomeSection : NSManagedObject

+(UserHomeSection*) insert;
+(UserHomeSection*) temporary;
+(NSArray*) queryUserHomeSection:(NSPredicate*) predicate;
+(UserHomeSection*) queryUserHomeSectionObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSNumber* sortOrder;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Home
- (NSSet*) home;
- (NSArray*) homeObjects;
- (void) addHome:(NSSet*)value;
- (void) removeHome:(NSSet*)value;
- (void) addHomeObject:(UserHome*)value;
- (void) removeHomeObject:(UserHome*)value;
- (void) removeAllHome;

#pragma mark Home9
@property (nonatomic, retain) UserHome* home9;



#pragma mark Utility

-(void) revert;
-(void) save;

@end