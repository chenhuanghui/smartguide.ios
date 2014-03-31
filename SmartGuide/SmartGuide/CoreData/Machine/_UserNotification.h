// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserNotification.h instead.

#import <CoreData/CoreData.h>
#import "Utility.h"

#define UserNotification_ClassName @"UserNotification"

#define UserNotification_Content @"content"
#define UserNotification_Highlight @"highlight"
#define UserNotification_IdSender @"idSender"
#define UserNotification_SortOrder @"sortOrder"
#define UserNotification_Status @"status"
#define UserNotification_Time @"time"

@class UserNotification;
@class UserNotificationDetail;

@interface _UserNotification : NSManagedObject

+(UserNotification*) insert;
+(UserNotification*) temporary;
+(NSArray*) queryUserNotification:(NSPredicate*) predicate;
+(UserNotification*) queryUserNotificationObject:(NSPredicate*) predicate;
+(NSArray*) allObjects;
+(void) markDeleteAllObjects;
-(void) markDeleted;


@property (nonatomic, retain) NSString* content;
@property (nonatomic, retain) NSString* highlight;
@property (nonatomic, retain) NSNumber* idSender;
@property (nonatomic, retain) NSNumber* sortOrder;
@property (nonatomic, retain) NSNumber* status;
@property (nonatomic, retain) NSString* time;

#pragma mark Fetched property

    
#pragma mark Relationships

#pragma mark Detail
- (NSSet*) detail;
- (NSArray*) detailObjects;
- (void) addDetail:(NSSet*)value;
- (void) removeDetail:(NSSet*)value;
- (void) addDetailObject:(UserNotificationDetail*)value;
- (void) removeDetailObject:(UserNotificationDetail*)value;
- (void) removeAllDetail;



#pragma mark Utility

-(void) revert;

@end