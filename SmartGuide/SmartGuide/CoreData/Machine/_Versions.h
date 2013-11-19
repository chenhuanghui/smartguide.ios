// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Versions.h instead.

#import <CoreData/CoreData.h>

#define Versions_ClassName @"Versions"

#define Versions_Version @"version"
#define Versions_VersionType @"versionType"

@class Versions;

@interface _Versions : NSManagedObject

+(Versions*) insert;
+(Versions*) temporary;
+(NSArray*) queryVersions:(NSPredicate*) predicate;
+(Versions*) queryVersionsObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;

-(bool) save;


@property (nonatomic, retain) NSString* version;
@property (nonatomic, retain) NSNumber* versionType;

#pragma mark Fetched property

    
#pragma mark Relationships


@end