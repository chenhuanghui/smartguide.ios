// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserNotification.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define UserNotification_ClassName @"UserNotification"

#define UserNotification_ActionType @"actionType"
#define UserNotification_Content @"content"
#define UserNotification_Highlight @"highlight"
#define UserNotification_IdNotification @"idNotification"
#define UserNotification_IdPlacelist @"idPlacelist"
#define UserNotification_IdShop @"idShop"
#define UserNotification_IdShops @"idShops"
#define UserNotification_Keywords @"keywords"
#define UserNotification_ReadAction @"readAction"
#define UserNotification_Sender @"sender"
#define UserNotification_Status @"status"
#define UserNotification_Time @"time"
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
@property (nonatomic, retain) NSString* content;
@property (nonatomic, retain) NSString* highlight;
@property (nonatomic, retain) NSNumber* idNotification;
@property (nonatomic, retain) NSNumber* idPlacelist;
@property (nonatomic, retain) NSNumber* idShop;
@property (nonatomic, retain) NSString* idShops;
@property (nonatomic, retain) NSString* keywords;
@property (nonatomic, retain) NSNumber* readAction;
@property (nonatomic, retain) NSString* sender;
@property (nonatomic, retain) NSNumber* status;
@property (nonatomic, retain) NSString* time;
@property (nonatomic, retain) NSString* url;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark NotificationContents
@property (nonatomic, retain) UserNotificationContent* notificationContents;



#pragma mark Utility

-(void) revert;

@end