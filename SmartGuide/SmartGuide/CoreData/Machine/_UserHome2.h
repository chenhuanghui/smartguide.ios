// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserHome2.h instead.

#import <CoreData/CoreData.h>

#define UserHome2_ClassName @"UserHome2"

#define UserHome2_Image @"image"
#define UserHome2_SortOrder @"sortOrder"

@class UserHome2;
@class UserHome;

@interface _UserHome2 : NSManagedObject

+(UserHome2*) insert;
+(UserHome2*) temporary;
+(NSArray*) queryUserHome2:(NSPredicate*) predicate;
+(UserHome2*) queryUserHome2Object:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* image;
@property (nonatomic, retain) NSNumber* sortOrder;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Home
@property (nonatomic, retain) UserHome* home;



#pragma mark Utility

-(void) revert;

@end