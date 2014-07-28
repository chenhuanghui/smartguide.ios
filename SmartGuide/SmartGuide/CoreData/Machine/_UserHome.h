// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserHome.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define UserHome_ClassName @"UserHome"

#define UserHome_IdPlacelist @"idPlacelist"
#define UserHome_IdPost @"idPost"
#define UserHome_IdShops @"idShops"
#define UserHome_Image @"image"
#define UserHome_ImageHeight @"imageHeight"
#define UserHome_ImageWidth @"imageWidth"
#define UserHome_Page @"page"
#define UserHome_SortOrder @"sortOrder"
#define UserHome_Title @"title"
#define UserHome_Type @"type"

@class UserHome;
@class UserHome1;
@class UserHome3;
@class UserHome4;
@class UserHome6;
@class UserHome8;
@class UserHomeSection;
@class UserHomeSection;
@class UserHomeImage;

@interface _UserHome : NSManagedObject

+(UserHome*) insert;
+(UserHome*) temporary;
+(NSArray*) queryUserHome:(NSPredicate*) predicate;
+(UserHome*) queryUserHomeObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSNumber* idPlacelist;
@property (nonatomic, retain) NSNumber* idPost;
@property (nonatomic, retain) NSString* idShops;
@property (nonatomic, retain) NSString* image;
@property (nonatomic, retain) NSNumber* imageHeight;
@property (nonatomic, retain) NSNumber* imageWidth;
@property (nonatomic, retain) NSNumber* page;
@property (nonatomic, retain) NSNumber* sortOrder;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSNumber* type;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Home1
@property (nonatomic, retain) UserHome1* home1;

#pragma mark Home3
- (NSSet*) home3;
- (NSArray*) home3Objects;
- (void) addHome3:(NSSet*)value;
- (void) removeHome3:(NSSet*)value;
- (void) addHome3Object:(UserHome3*)value;
- (void) removeHome3Object:(UserHome3*)value;
- (void) removeAllHome3;

#pragma mark Home4
- (NSSet*) home4;
- (NSArray*) home4Objects;
- (void) addHome4:(NSSet*)value;
- (void) removeHome4:(NSSet*)value;
- (void) addHome4Object:(UserHome4*)value;
- (void) removeHome4Object:(UserHome4*)value;
- (void) removeAllHome4;

#pragma mark Home6
@property (nonatomic, retain) UserHome6* home6;

#pragma mark Home8
@property (nonatomic, retain) UserHome8* home8;

#pragma mark HomeHeader
@property (nonatomic, retain) UserHomeSection* homeHeader;

#pragma mark HomeSection
@property (nonatomic, retain) UserHomeSection* homeSection;

#pragma mark Images
- (NSSet*) images;
- (NSArray*) imagesObjects;
- (void) addImages:(NSSet*)value;
- (void) removeImages:(NSSet*)value;
- (void) addImagesObject:(UserHomeImage*)value;
- (void) removeImagesObject:(UserHomeImage*)value;
- (void) removeAllImages;



#pragma mark Utility

-(void) revert;
-(void) save;

@end