// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Group.h instead.

#import <CoreData/CoreData.h>

#define Group_ClassName @"Group"

#define Group_Count @"count"
#define Group_IdGroup @"idGroup"
#define Group_Name @"name"

@class Group;

@interface _Group : NSManagedObject

+(Group*) insert;
+(Group*) temporary;
+(NSArray*) queryGroup:(NSPredicate*) predicate;
+(Group*) queryGroupObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;

-(bool) save;


@property (nonatomic, retain) NSNumber* count;
@property (nonatomic, retain) NSNumber* idGroup;
@property (nonatomic, retain) NSString* name;

#pragma mark Fetched property

    
#pragma mark Relationships


@end