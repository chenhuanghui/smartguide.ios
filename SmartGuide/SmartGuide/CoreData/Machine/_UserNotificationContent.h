// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserNotificationContent.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define UserNotificationContent_ClassName @"UserNotificationContent"

#define UserNotificationContent_Desc @"desc"
#define UserNotificationContent_GoTo @"goTo"
#define UserNotificationContent_IdNotification @"idNotification"
#define UserNotificationContent_IdPlacelist @"idPlacelist"
#define UserNotificationContent_IdShop @"idShop"
#define UserNotificationContent_IdShops @"idShops"
#define UserNotificationContent_Keywords @"keywords"
#define UserNotificationContent_Logo @"logo"
#define UserNotificationContent_SortOrder @"sortOrder"
#define UserNotificationContent_Time @"time"
#define UserNotificationContent_Title @"title"
#define UserNotificationContent_Type @"type"
#define UserNotificationContent_UrlTutorial @"urlTutorial"

@class UserNotificationContent;

@interface _UserNotificationContent : NSManagedObject

+(UserNotificationContent*) insert;
+(UserNotificationContent*) temporary;
+(NSArray*) queryUserNotificationContent:(NSPredicate*) predicate;
+(UserNotificationContent*) queryUserNotificationContentObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* desc;
@property (nonatomic, retain) NSString* goTo;
@property (nonatomic, retain) NSNumber* idNotification;
@property (nonatomic, retain) NSNumber* idPlacelist;
@property (nonatomic, retain) NSNumber* idShop;
@property (nonatomic, retain) NSString* idShops;
@property (nonatomic, retain) NSString* keywords;
@property (nonatomic, retain) NSString* logo;
@property (nonatomic, retain) NSNumber* sortOrder;
@property (nonatomic, retain) NSString* time;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSNumber* type;
@property (nonatomic, retain) NSString* urlTutorial;

#pragma mark Fetched property

    
#pragma mark Relationships



#pragma mark Utility

-(void) revert;

@end