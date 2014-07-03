// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserNotificationContent.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define UserNotificationContent_ClassName @"UserNotificationContent"

#define UserNotificationContent_Content @"content"
#define UserNotificationContent_DisplayType @"displayType"
#define UserNotificationContent_HighlightUnread @"highlightUnread"
#define UserNotificationContent_IdMessage @"idMessage"
#define UserNotificationContent_IdSender @"idSender"
#define UserNotificationContent_IdShopLogo @"idShopLogo"
#define UserNotificationContent_Image @"image"
#define UserNotificationContent_ImageHeight @"imageHeight"
#define UserNotificationContent_ImageWidth @"imageWidth"
#define UserNotificationContent_Logo @"logo"
#define UserNotificationContent_Page @"page"
#define UserNotificationContent_Sender @"sender"
#define UserNotificationContent_SortOrder @"sortOrder"
#define UserNotificationContent_Status @"status"
#define UserNotificationContent_Time @"time"
#define UserNotificationContent_Title @"title"
#define UserNotificationContent_Video @"video"
#define UserNotificationContent_VideoHeight @"videoHeight"
#define UserNotificationContent_VideoThumbnail @"videoThumbnail"
#define UserNotificationContent_VideoWidth @"videoWidth"

@class UserNotificationContent;
@class UserNotificationAction;
@class UserNotification;

@interface _UserNotificationContent : NSManagedObject

+(UserNotificationContent*) insert;
+(UserNotificationContent*) temporary;
+(NSArray*) queryUserNotificationContent:(NSPredicate*) predicate;
+(UserNotificationContent*) queryUserNotificationContentObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* content;
@property (nonatomic, retain) NSNumber* displayType;
@property (nonatomic, retain) NSNumber* highlightUnread;
@property (nonatomic, retain) NSNumber* idMessage;
@property (nonatomic, retain) NSNumber* idSender;
@property (nonatomic, retain) NSNumber* idShopLogo;
@property (nonatomic, retain) NSString* image;
@property (nonatomic, retain) NSNumber* imageHeight;
@property (nonatomic, retain) NSNumber* imageWidth;
@property (nonatomic, retain) NSString* logo;
@property (nonatomic, retain) NSNumber* page;
@property (nonatomic, retain) NSString* sender;
@property (nonatomic, retain) NSNumber* sortOrder;
@property (nonatomic, retain) NSNumber* status;
@property (nonatomic, retain) NSString* time;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* video;
@property (nonatomic, retain) NSNumber* videoHeight;
@property (nonatomic, retain) NSString* videoThumbnail;
@property (nonatomic, retain) NSNumber* videoWidth;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Actions
- (NSSet*) actions;
- (NSArray*) actionsObjects;
- (void) addActions:(NSSet*)value;
- (void) removeActions:(NSSet*)value;
- (void) addActionsObject:(UserNotificationAction*)value;
- (void) removeActionsObject:(UserNotificationAction*)value;
- (void) removeAllActions;

#pragma mark Notification
@property (nonatomic, retain) UserNotification* notification;



#pragma mark Utility

-(void) revert;
-(void) save;

@end