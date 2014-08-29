// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ShopInfoEvent.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define ShopInfoEvent_ClassName @"ShopInfoEvent"

#define ShopInfoEvent_Content @"content"
#define ShopInfoEvent_Duration @"duration"
#define ShopInfoEvent_Image @"image"
#define ShopInfoEvent_ImageHeight @"imageHeight"
#define ShopInfoEvent_ImageWidth @"imageWidth"
#define ShopInfoEvent_Title @"title"
#define ShopInfoEvent_Video @"video"
#define ShopInfoEvent_VideoHeight @"videoHeight"
#define ShopInfoEvent_VideoThumbnail @"videoThumbnail"
#define ShopInfoEvent_VideoWidth @"videoWidth"

@class ShopInfoEvent;
@class ShopInfo;

@interface _ShopInfoEvent : NSManagedObject

+(ShopInfoEvent*) insert;
+(ShopInfoEvent*) temporary;
+(NSArray*) queryShopInfoEvent:(NSPredicate*) predicate;
+(ShopInfoEvent*) queryShopInfoEventObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* content;
@property (nonatomic, retain) NSString* duration;
@property (nonatomic, retain) NSString* image;
@property (nonatomic, retain) NSNumber* imageHeight;
@property (nonatomic, retain) NSNumber* imageWidth;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* video;
@property (nonatomic, retain) NSNumber* videoHeight;
@property (nonatomic, retain) NSString* videoThumbnail;
@property (nonatomic, retain) NSNumber* videoWidth;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Shop
@property (nonatomic, retain) ShopInfo* shop;



#pragma mark Utility

-(void) revert;

@end