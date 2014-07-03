// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserNotificationAction.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define UserNotificationAction_ClassName @"UserNotificationAction"

#define UserNotificationAction_ActionTitle @"actionTitle"
#define UserNotificationAction_ActionType @"actionType"
#define UserNotificationAction_Color @"color"
#define UserNotificationAction_IdPlacelist @"idPlacelist"
#define UserNotificationAction_IdShop @"idShop"
#define UserNotificationAction_IdShops @"idShops"
#define UserNotificationAction_Keywords @"keywords"
#define UserNotificationAction_Method @"method"
#define UserNotificationAction_Params @"params"
#define UserNotificationAction_SortOrder @"sortOrder"
#define UserNotificationAction_Url @"url"

@class UserNotificationAction;
@class ScanCodeDecode;
@class UserNotificationContent;

@interface _UserNotificationAction : NSManagedObject

+(UserNotificationAction*) insert;
+(UserNotificationAction*) temporary;
+(NSArray*) queryUserNotificationAction:(NSPredicate*) predicate;
+(UserNotificationAction*) queryUserNotificationActionObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* actionTitle;
@property (nonatomic, retain) NSNumber* actionType;
@property (nonatomic, retain) NSNumber* color;
@property (nonatomic, retain) NSNumber* idPlacelist;
@property (nonatomic, retain) NSNumber* idShop;
@property (nonatomic, retain) NSString* idShops;
@property (nonatomic, retain) NSString* keywords;
@property (nonatomic, retain) NSNumber* method;
@property (nonatomic, retain) NSString* params;
@property (nonatomic, retain) NSNumber* sortOrder;
@property (nonatomic, retain) NSString* url;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Decode
@property (nonatomic, retain) ScanCodeDecode* decode;

#pragma mark UserNotificationContent
@property (nonatomic, retain) UserNotificationContent* userNotificationContent;



#pragma mark Utility

-(void) revert;

@end