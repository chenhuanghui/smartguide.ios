// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopGallery.h instead.

#import <CoreData/CoreData.h>

#define ShopGallery_ClassName @"ShopGallery"

#define ShopGallery_IdShop @"idShop"
#define ShopGallery_Image @"image"

@class ShopGallery;
@class Shop;

@interface _ShopGallery : NSManagedObject

+(ShopGallery*) insert;
+(ShopGallery*) temporary;
+(NSArray*) queryShopGallery:(NSPredicate*) predicate;
+(ShopGallery*) queryShopGalleryObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;

-(bool) save;


@property (nonatomic, retain) NSNumber* idShop;
@property (nonatomic, retain) NSString* image;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Shop
@property (nonatomic, retain) Shop* shop;


@end