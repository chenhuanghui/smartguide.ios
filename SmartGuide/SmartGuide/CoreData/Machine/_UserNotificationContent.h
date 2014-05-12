// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserNotificationContent.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define UserNotificationContent_ClassName @"UserNotificationContent"

#define UserNotificationContent_ActionTitle @"actionTitle"
#define UserNotificationContent_ActionType @"actionType"
#define UserNotificationContent_Content @"content"
#define UserNotificationContent_IdNotification @"idNotification"
#define UserNotificationContent_IdPlacelist @"idPlacelist"
#define UserNotificationContent_IdShop @"idShop"
#define UserNotificationContent_IdShopLogo @"idShopLogo"
#define UserNotificationContent_IdShops @"idShops"
#define UserNotificationContent_Keywords @"keywords"
#define UserNotificationContent_Logo @"logo"
#define UserNotificationContent_ReadAction @"readAction"
#define UserNotificationContent_ShopListType @"shopListType"
#define UserNotificationContent_Status @"status"
#define UserNotificationContent_Time @"time"
#define UserNotificationContent_Title @"title"
#define UserNotificationContent_Url @"url"

@class UserNotificationContent;
@class UserNotification;

@interface _UserNotificationContent : NSManagedObject

+(UserNotificationContent*) insert;
+(UserNotificationContent*) temporary;
+(NSArray*) queryUserNotificationContent:(NSPredicate*) predicate;
+(UserNotificationContent*) queryUserNotificationContentObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* actionTitle;
@property (nonatomic, retain) NSNumber* actionType;
@property (nonatomic, retain) NSString* content;
@property (nonatomic, retain) NSNumber* idNotification;
@property (nonatomic, retain) NSNumber* idPlacelist;
@property (nonatomic, retain) NSNumber* idShop;
@property (nonatomic, retain) NSNumber* idShopLogo;
@property (nonatomic, retain) NSString* idShops;
@property (nonatomic, retain) NSString* keywords;
@property (nonatomic, retain) NSString* logo;
@property (nonatomic, retain) NSNumber* readAction;
@property (nonatomic, retain) NSNumber* shopListType;
@property (nonatomic, retain) NSNumber* status;
@property (nonatomic, retain) NSString* time;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* url;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Notification
@property (nonatomic, retain) UserNotification* notification;



#pragma mark Utility

-(void) revert;

@end