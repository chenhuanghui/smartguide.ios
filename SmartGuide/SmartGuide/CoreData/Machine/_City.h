// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to City.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define City_ClassName @"City"

#define City_IdCity @"idCity"
#define City_Name @"name"

@class City;

@interface _City : NSManagedObject

+(City*) insert;
+(City*) temporary;
+(NSArray*) queryCity:(NSPredicate*) predicate;
+(City*) queryCityObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSNumber* idCity;
@property (nonatomic, retain) NSString* name;

#pragma mark Fetched property

    
#pragma mark Relationships



#pragma mark Utility

-(void) revert;

@end