// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopInfoUserGallery.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define ShopInfoUserGallery_ClassName @"ShopInfoUserGallery"

#define ShopInfoUserGallery_Desc @"desc"
#define ShopInfoUserGallery_IdUserGallery @"idUserGallery"
#define ShopInfoUserGallery_Image @"image"
#define ShopInfoUserGallery_Thumbnail @"thumbnail"
#define ShopInfoUserGallery_Time @"time"
#define ShopInfoUserGallery_Username @"username"

@class ShopInfoUserGallery;
@class ShopInfo;

@interface _ShopInfoUserGallery : NSManagedObject

+(ShopInfoUserGallery*) insert;
+(ShopInfoUserGallery*) temporary;
+(NSArray*) queryShopInfoUserGallery:(NSPredicate*) predicate;
+(ShopInfoUserGallery*) queryShopInfoUserGalleryObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* desc;
@property (nonatomic, retain) NSNumber* idUserGallery;
@property (nonatomic, retain) NSString* image;
@property (nonatomic, retain) NSString* thumbnail;
@property (nonatomic, retain) NSString* time;
@property (nonatomic, retain) NSString* username;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Shop
@property (nonatomic, retain) ShopInfo* shop;



#pragma mark Utility

-(void) revert;

@end