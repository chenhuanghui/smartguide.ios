// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserGalleryUpload.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define UserGalleryUpload_ClassName @"UserGalleryUpload"

#define UserGalleryUpload_Desc @"desc"
#define UserGalleryUpload_IdShop @"idShop"
#define UserGalleryUpload_IdUserGallery @"idUserGallery"
#define UserGalleryUpload_Image @"image"
#define UserGalleryUpload_SortOrder @"sortOrder"
#define UserGalleryUpload_Status @"status"
#define UserGalleryUpload_UserLat @"userLat"
#define UserGalleryUpload_UserLng @"userLng"

@class UserGalleryUpload;

@interface _UserGalleryUpload : NSManagedObject

+(UserGalleryUpload*) insert;
+(UserGalleryUpload*) temporary;
+(NSArray*) queryUserGalleryUpload:(NSPredicate*) predicate;
+(UserGalleryUpload*) queryUserGalleryUploadObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* desc;
@property (nonatomic, retain) NSNumber* idShop;
@property (nonatomic, retain) NSNumber* idUserGallery;
@property (nonatomic, retain) NSData* image;
@property (nonatomic, retain) NSNumber* sortOrder;
@property (nonatomic, retain) NSNumber* status;
@property (nonatomic, retain) NSNumber* userLat;
@property (nonatomic, retain) NSNumber* userLng;

#pragma mark Fetched property

    
#pragma mark Relationships



#pragma mark Utility

-(void) revert;
-(void) save;

@end