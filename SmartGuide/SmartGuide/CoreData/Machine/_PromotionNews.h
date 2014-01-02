// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PromotionNews.h instead.

#import <CoreData/CoreData.h>

#define PromotionNews_ClassName @"PromotionNews"

#define PromotionNews_Content @"content"
#define PromotionNews_Duration @"duration"
#define PromotionNews_Image @"image"
#define PromotionNews_Title @"title"

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
@property (nonatomic, retain) NSString* title;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Shop
@property (nonatomic, retain) Shop* shop;


@end