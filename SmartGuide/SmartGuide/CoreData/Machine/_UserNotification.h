// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserNotification.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define UserNotification_ClassName @"UserNotification"

#define UserNotification_ActionType @"actionType"
#define UserNotification_Badge @"badge"
#define UserNotification_Content @"content"
#define UserNotification_Highlight @"highlight"
#define UserNotification_HighlightUnread @"highlightUnread"
#define UserNotification_IdNotification @"idNotification"
#define UserNotification_IdPlacelist @"idPlacelist"
#define UserNotification_IdShop @"idShop"
#define UserNotification_IdShops @"idShops"
#define UserNotification_Keywords @"keywords"
#define UserNotification_ReadAction @"readAction"
#define UserNotification_ShopListType @"shopListType"
#define UserNotification_Status @"status"
#define UserNotification_Time @"time"
#define UserNotification_Timer @"timer"
#define UserNotification_Url @"url"

@class UserNotification;
@class UserNotificationContent;

@interface _UserNotification : NSManagedObject

+(UserNotification*) insert;
+(UserNotification*) temporary;
+(NSArray*) queryUserNotification:(NSPredicate*) predicate;
+(UserNotification*) queryUserNotificationObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSNumber* actionType;
@property (nonatomic, retain) NSString* badge;
@property (nonatomic, retain) NSString* content;
@property (nonatomic, retain) NSString* highlight;
@property (nonatomic, retain) NSNumber* highlightUnread;
@property (nonatomic, retain) NSNumber* idNotification;
@property (nonatomic, retain) NSNumber* idPlacelist;
@property (nonatomic, retain) NSNumber* idShop;
@property (nonatomic, retain) NSString* idShops;
@property (nonatomic, retain) NSString* keywords;
@property (nonatomic, retain) NSNumber* readAction;
@property (nonatomic, retain) NSNumber* shopListType;
@property (nonatomic, retain) NSNumber* status;
@property (nonatomic, retain) NSString* time;
@property (nonatomic, retain) NSNumber* timer;
@property (nonatomic, retain) NSString* url;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark NotificationContents
- (NSSet*) notificationContents;
- (NSArray*) notificationContentsObjects;
- (void) addNotificationContents:(NSSet*)value;
- (void) removeNotificationContents:(NSSet*)value;
- (void) addNotificationContentsObject:(UserNotificationContent*)value;
- (void) removeNotificationContentsObject:(UserNotificationContent*)value;
- (void) removeAllNotificationContents;



#pragma mark Utility

-(void) revert;

@end