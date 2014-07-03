// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PromotionNews.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define PromotionNews_ClassName @"PromotionNews"

#define PromotionNews_Content @"content"
#define PromotionNews_Duration @"duration"
#define PromotionNews_Image @"image"
#define PromotionNews_ImageHeight @"imageHeight"
#define PromotionNews_ImageWidth @"imageWidth"
#define PromotionNews_SortOrder @"sortOrder"
#define PromotionNews_Title @"title"
#define PromotionNews_Video @"video"
#define PromotionNews_VideoHeight @"videoHeight"
#define PromotionNews_VideoThumbnail @"videoThumbnail"
#define PromotionNews_VideoWidth @"videoWidth"

@class PromotionNews;
@class Shop;

@interface _PromotionNews : NSManagedObject

+(PromotionNews*) insert;
+(PromotionNews*) temporary;
+(NSArray*) queryPromotionNews:(NSPredicate*) predicate;
+(PromotionNews*) queryPromotionNewsObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* content;
@property (nonatomic, retain) NSString* duration;
@property (nonatomic, retain) NSString* image;
@property (nonatomic, retain) NSNumber* imageHeight;
@property (nonatomic, retain) NSNumber* imageWidth;
@property (nonatomic, retain) NSNumber* sortOrder;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* video;
@property (nonatomic, retain) NSNumber* videoHeight;
@property (nonatomic, retain) NSString* videoThumbnail;
@property (nonatomic, retain) NSNumber* videoWidth;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Shop
@property (nonatomic, retain) Shop* shop;



#pragma mark Utility

-(void) revert;
-(void) save;

@end