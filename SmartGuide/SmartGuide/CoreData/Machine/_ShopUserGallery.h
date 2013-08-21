// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopUserGallery.h instead.

#import <CoreData/CoreData.h>

#define ShopUserGallery_ClassName @"ShopUserGallery"

#define ShopUserGallery_Desc @"desc"
#define ShopUserGallery_IdShop @"idShop"
#define ShopUserGallery_Image @"image"

@class ShopUserGallery;
@class Shop;

@interface _ShopUserGallery : NSManagedObject

+(ShopUserGallery*) insert;
+(ShopUserGallery*) temporary;
+(NSArray*) queryShopUserGallery:(NSPredicate*) predicate;
+(ShopUserGallery*) queryShopUserGalleryObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;

-(bool) save;


@property (nonatomic, retain) NSString* desc;
@property (nonatomic, retain) NSNumber* idShop;
@property (nonatomic, retain) NSString* image;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Shop
@property (nonatomic, retain) Shop* shop;


@end