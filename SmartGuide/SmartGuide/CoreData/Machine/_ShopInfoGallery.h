// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopInfoGallery.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define ShopInfoGallery_ClassName @"ShopInfoGallery"

#define ShopInfoGallery_Cover @"cover"
#define ShopInfoGallery_CoverHeight @"coverHeight"
#define ShopInfoGallery_CoverWidth @"coverWidth"
#define ShopInfoGallery_Image @"image"
#define ShopInfoGallery_ImageHeight @"imageHeight"
#define ShopInfoGallery_ImageWidth @"imageWidth"
#define ShopInfoGallery_SortOrder @"sortOrder"

@class ShopInfoGallery;
@class ShopInfo;

@interface _ShopInfoGallery : NSManagedObject

+(ShopInfoGallery*) insert;
+(ShopInfoGallery*) temporary;
+(NSArray*) queryShopInfoGallery:(NSPredicate*) predicate;
+(ShopInfoGallery*) queryShopInfoGalleryObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* cover;
@property (nonatomic, retain) NSNumber* coverHeight;
@property (nonatomic, retain) NSNumber* coverWidth;
@property (nonatomic, retain) NSString* image;
@property (nonatomic, retain) NSNumber* imageHeight;
@property (nonatomic, retain) NSNumber* imageWidth;
@property (nonatomic, retain) NSNumber* sortOrder;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Shop
@property (nonatomic, retain) ShopInfo* shop;



#pragma mark Utility

-(void) revert;

@end