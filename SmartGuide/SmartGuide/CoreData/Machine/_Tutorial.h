// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Tutorial.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define Tutorial_ClassName @"Tutorial"

#define Tutorial_IdTutorial @"idTutorial"
#define Tutorial_Image @"image"
#define Tutorial_SortOrder @"sortOrder"

@class Tutorial;

@interface _Tutorial : NSManagedObject

+(Tutorial*) insert;
+(Tutorial*) temporary;
+(NSArray*) queryTutorial:(NSPredicate*) predicate;
+(Tutorial*) queryTutorialObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSNumber* idTutorial;
@property (nonatomic, retain) NSNumber* image;
@property (nonatomic, retain) NSNumber* sortOrder;

#pragma mark Fetched property

    
#pragma mark Relationships



#pragma mark Utility

-(void) revert;

@end