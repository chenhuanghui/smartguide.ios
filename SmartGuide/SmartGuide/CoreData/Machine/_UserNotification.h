// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserNotification.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define UserNotification_ClassName @"UserNotification"

#define UserNotification_Content @"content"
#define UserNotification_HighlightUnread @"highlightUnread"
#define UserNotification_IdNotification @"idNotification"
#define UserNotification_IdSender @"idSender"
#define UserNotification_Logo @"logo"
#define UserNotification_Sender @"sender"
#define UserNotification_Status @"status"
#define UserNotification_Time @"time"
#define UserNotification_Title @"title"

@class UserNotification;
@class UserNotificationAction;
@class UserNotificationContent;

@interface _UserNotification : NSManagedObject

+(UserNotification*) insert;
+(UserNotification*) temporary;
+(NSArray*) queryUserNotification:(NSPredicate*) predicate;
+(UserNotification*) queryUserNotificationObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* content;
@property (nonatomic, retain) NSNumber* highlightUnread;
@property (nonatomic, retain) NSNumber* idNotification;
@property (nonatomic, retain) NSNumber* idSender;
@property (nonatomic, retain) NSString* logo;
@property (nonatomic, retain) NSString* sender;
@property (nonatomic, retain) NSNumber* status;
@property (nonatomic, retain) NSString* time;
@property (nonatomic, retain) NSString* title;

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