// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to HomeImages.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define HomeImages_ClassName @"HomeImages"

#define HomeImages_IdPlacelist @"idPlacelist"
#define HomeImages_IdShops @"idShops"
#define HomeImages_ImageHeight @"imageHeight"
#define HomeImages_ImageWidth @"imageWidth"

@class HomeImages;
@class Home;
@class HomeImage;

@interface _HomeImages : NSManagedObject

+(HomeImages*) insert;
+(HomeImages*) temporary;
+(NSArray*) queryHomeImages:(NSPredicate*) predicate;
+(HomeImages*) queryHomeImagesObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSNumber* idPlacelist;
@property (nonatomic, retain) NSString* idShops;
@property (nonatomic, retain) NSNumber* imageHeight;
@property (nonatomic, retain) NSNumber* imageWidth;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Home
@property (nonatomic, retain) Home* home;

#pragma mark Images
- (NSSet*) images;
- (NSArray*) imagesObjects;
- (void) addImages:(NSSet*)value;
- (void) removeImages:(NSSet*)value;
- (void) addImagesObject:(HomeImage*)value;
- (void) removeImagesObject:(HomeImage*)value;
- (void) removeAllImages;



#pragma mark Utility

-(void) revert;

@end