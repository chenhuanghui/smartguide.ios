// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopUserGallery.h instead.

#import <CoreData/CoreData.h>

#define ShopUserGallery_ClassName @"ShopUserGallery"

#define ShopUserGallery_Desc @"desc"
#define ShopUserGallery_IdGallery @"idGallery"
#define ShopUserGallery_Image @"image"
#define ShopUserGallery_SortOrder @"sortOrder"
#define ShopUserGallery_Thumbnail @"thumbnail"
#define ShopUserGallery_Time @"time"
#define ShopUserGallery_Username @"username"

@class ShopUserGallery;
@class Shop;

@interface _ShopUserGallery : NSManagedObject

+(ShopUserGallery*) insert;
+(ShopUserGallery*) temporary;
+(NSArray*) queryShopUserGallery:(NSPredicate*) predicate;
+(ShopUserGallery*) queryShopUserGalleryObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* desc;
@property (nonatomic, retain) NSNumber* idGallery;
@property (nonatomic, retain) NSString* image;
@property (nonatomic, retain) NSNumber* sortOrder;
@property (nonatomic, retain) NSString* thumbnail;
@property (nonatomic, retain) NSString* time;
@property (nonatomic, retain) NSString* username;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Shop
@property (nonatomic, retain) Shop* shop;



#pragma mark Utility

-(void) revert;

@end