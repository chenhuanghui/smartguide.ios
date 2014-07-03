// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ScanCodeDecode.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define ScanCodeDecode_ClassName @"ScanCodeDecode"

#define ScanCodeDecode_Image @"image"
#define ScanCodeDecode_ImageHeight @"imageHeight"
#define ScanCodeDecode_ImageWidth @"imageWidth"
#define ScanCodeDecode_Order @"order"
#define ScanCodeDecode_Text @"text"
#define ScanCodeDecode_TextHeight @"textHeight"
#define ScanCodeDecode_Type @"type"
#define ScanCodeDecode_Video @"video"
#define ScanCodeDecode_VideoHeight @"videoHeight"
#define ScanCodeDecode_VideoThumbnail @"videoThumbnail"
#define ScanCodeDecode_VideoWidth @"videoWidth"

@class ScanCodeDecode;
@class UserNotificationAction;
@class ScanCodeResult;

@interface _ScanCodeDecode : NSManagedObject

+(ScanCodeDecode*) insert;
+(ScanCodeDecode*) temporary;
+(NSArray*) queryScanCodeDecode:(NSPredicate*) predicate;
+(ScanCodeDecode*) queryScanCodeDecodeObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* image;
@property (nonatomic, retain) NSNumber* imageHeight;
@property (nonatomic, retain) NSNumber* imageWidth;
@property (nonatomic, retain) NSNumber* order;
@property (nonatomic, retain) NSString* text;
@property (nonatomic, retain) NSNumber* textHeight;
@property (nonatomic, retain) NSNumber* type;
@property (nonatomic, retain) NSString* video;
@property (nonatomic, retain) NSNumber* videoHeight;
@property (nonatomic, retain) NSString* videoThumbnail;
@property (nonatomic, retain) NSNumber* videoWidth;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Action
- (NSSet*) action;
- (NSArray*) actionObjects;
- (void) addAction:(NSSet*)value;
- (void) removeAction:(NSSet*)value;
- (void) addActionObject:(UserNotificationAction*)value;
- (void) removeActionObject:(UserNotificationAction*)value;
- (void) removeAllAction;

#pragma mark Result
@property (nonatomic, retain) ScanCodeResult* result;



#pragma mark Utility

-(void) revert;

@end