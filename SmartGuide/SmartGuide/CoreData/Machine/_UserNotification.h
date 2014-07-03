// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserNotification.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define UserNotification_ClassName @"UserNotification"

#define UserNotification_HighlightUnread @"highlightUnread"
#define UserNotification_IdSender @"idSender"
#define UserNotification_NumberAll @"numberAll"
#define UserNotification_NumberRead @"numberRead"
#define UserNotification_NumberUnread @"numberUnread"
#define UserNotification_Sender @"sender"
#define UserNotification_Status @"status"
#define UserNotification_TotalAll @"totalAll"
#define UserNotification_TotalRead @"totalRead"
#define UserNotification_TotalUnread @"totalUnread"

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


@property (nonatomic, retain) NSNumber* highlightUnread;
@property (nonatomic, retain) NSNumber* idSender;
@property (nonatomic, retain) NSNumber* numberAll;
@property (nonatomic, retain) NSNumber* numberRead;
@property (nonatomic, retain) NSNumber* numberUnread;
@property (nonatomic, retain) NSString* sender;
@property (nonatomic, retain) NSNumber* status;
@property (nonatomic, retain) NSString* totalAll;
@property (nonatomic, retain) NSString* totalRead;
@property (nonatomic, retain) NSString* totalUnread;

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
-(void) save;

@end