// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to HomeImage.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define HomeImage_ClassName @"HomeImage"

#define HomeImage_Image @"image"
#define HomeImage_SortOrder @"sortOrder"

@class HomeImage;
@class HomeImages;

@interface _HomeImage : NSManagedObject

+(HomeImage*) insert;
+(HomeImage*) temporary;
+(NSArray*) queryHomeImage:(NSPredicate*) predicate;
+(HomeImage*) queryHomeImageObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* image;
@property (nonatomic, retain) NSNumber* sortOrder;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Images
@property (nonatomic, retain) HomeImages* images;



#pragma mark Utility

-(void) revert;

@end