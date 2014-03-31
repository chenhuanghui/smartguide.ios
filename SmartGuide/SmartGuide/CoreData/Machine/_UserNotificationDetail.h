// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserNotificationDetail.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define UserNotificationDetail_ClassName @"UserNotificationDetail"

#define UserNotificationDetail_ActionDataIDPlace @"actionDataIDPlace"
#define UserNotificationDetail_ActionDataIDShop @"actionDataIDShop"
#define UserNotificationDetail_ActionDataKeyword @"actionDataKeyword"
#define UserNotificationDetail_ActionScreen @"actionScreen"
#define UserNotificationDetail_ActionTitle @"actionTitle"
#define UserNotificationDetail_Desc @"desc"
#define UserNotificationDetail_Icon @"icon"
#define UserNotificationDetail_IdNotification @"idNotification"
#define UserNotificationDetail_SortOrder @"sortOrder"
#define UserNotificationDetail_Time @"time"
#define UserNotificationDetail_Title @"title"

@class UserNotificationDetail;
@class UserNotification;

@interface _UserNotificationDetail : NSManagedObject

+(UserNotificationDetail*) insert;
+(UserNotificationDetail*) temporary;
+(NSArray*) queryUserNotificationDetail:(NSPredicate*) predicate;
+(UserNotificationDetail*) queryUserNotificationDetailObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSNumber* actionDataIDPlace;
@property (nonatomic, retain) NSNumber* actionDataIDShop;
@property (nonatomic, retain) NSString* actionDataKeyword;
@property (nonatomic, retain) NSString* actionScreen;
@property (nonatomic, retain) NSString* actionTitle;
@property (nonatomic, retain) NSString* desc;
@property (nonatomic, retain) NSString* icon;
@property (nonatomic, retain) NSNumber* idNotification;
@property (nonatomic, retain) NSNumber* sortOrder;
@property (nonatomic, retain) NSString* time;
@property (nonatomic, retain) NSString* title;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark UserNotification
@property (nonatomic, retain) UserNotification* userNotification;



#pragma mark Utility

-(void) revert;

@end