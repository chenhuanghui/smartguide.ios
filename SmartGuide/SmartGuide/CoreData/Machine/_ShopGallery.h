// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopGallery.h instead.

#import <CoreData/CoreData.h>

#define ShopGallery_ClassName @"ShopGallery"

#define ShopGallery_Cover @"cover"
#define ShopGallery_IdGallery @"idGallery"
#define ShopGallery_Image @"image"
#define ShopGallery_SortOrder @"sortOrder"

@class ShopGallery;
@class Shop;

@interface _ShopGallery : NSManagedObject

+(ShopGallery*) insert;
+(ShopGallery*) temporary;
+(NSArray*) queryShopGallery:(NSPredicate*) predicate;
+(ShopGallery*) queryShopGalleryObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* cover;
@property (nonatomic, retain) NSNumber* idGallery;
@property (nonatomic, retain) NSString* image;
@property (nonatomic, retain) NSNumber* sortOrder;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Shop
@property (nonatomic, retain) Shop* shop;


@end