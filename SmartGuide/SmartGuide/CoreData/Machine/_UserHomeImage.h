// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserHomeImage.h instead.

#import <CoreData/CoreData.h>

#define UserHomeImage_ClassName @"UserHomeImage"

#define UserHomeImage_Image @"image"
#define UserHomeImage_SortOrder @"sortOrder"

@class UserHomeImage;
@class UserHome;

@interface _UserHomeImage : NSManagedObject

+(UserHomeImage*) insert;
+(UserHomeImage*) temporary;
+(NSArray*) queryUserHomeImage:(NSPredicate*) predicate;
+(UserHomeImage*) queryUserHomeImageObject:(NSPredicate*) predicate;
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