//
//  NotificationManager.h
//  Infory
//
//  Created by XXX on 5/5/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserNotification.h"
#import "ASIOperationUserNotificationRead.h"
#import "ASIOperationUserNotificationRemove.h"

enum NOTIFICATION_CHECK_STATE
{
    NOTIFICATION_CHECK_STATE_INIT=0,
    NOTIFICATION_CHECK_STATE_CHECKING=1,
    NOTIFICATION_CHECK_STATE_DONE=2,
};

@interface NotificationManager : NSObject
{
    enum NOTIFICATION_CHECK_STATE _notificationState;
}

+(NotificationManager*) shareInstance;

-(void) requestNotificationCheck;

-(enum NOTIFICATION_CHECK_STATE) notificationState;

-(void) receiveDeviceToken:(NSData*) deviceToken;
-(void) receiveRemoteNotification:(NSDictionary*) userInfo;
-(void) receiveLaunchNotification:(NSDictionary*) launchOptions;
-(void) removeUserNotification:(UserNotification*) obj;

@property (nonatomic, strong) NSNumber *totalNotification;
@property (nonatomic, strong) NSString *numOfNotification;
@property (nonatomic, strong) NSString *notificationToken;
@property (nonatomic, strong) NSMutableArray *notifications;
@property (nonatomic, strong) UserNotification *launchNotification;

@end

@interface NotificationView : UIView

@property (nonatomic, weak) IBOutlet UIButton *btnNumberOfNotification;

@end

enum NOTI_ACTION_TYPE
{
    NOTI_ACTION_TYPE_GO_CONTENT=0,
    NOTI_ACTION_TYPE_SHOP_USER=1,
    NOTI_ACTION_TYPE_SHOP_LIST=2,
    NOTI_ACTION_TYPE_POPUP_URL=3,
    NOTI_ACTION_TYPE_USER_SETTING=4,
    NOTI_ACTION_TYPE_LOGIN=5,
    NOTI_ACTION_TYPE_SCAN_CODE=6,
    NOTI_ACTION_TYPE_USER_PROMOTION=7
};;

enum NOTI_READ_ACTION
{
    NOTI_READ_ACTION_TOUCH=0,
    NOTI_READ_ACTION_GO_TO=1,
};

@interface UserNotification(RemoteNotification)

+(UserNotification*) makeWithRemoteNotification:(NSDictionary*) dict;

@end

@interface UserNotification(ASIOperation)<ASIOperationPostDelegate>

-(void) markAndSendRead;
-(void) sendDelete;

@property (nonatomic, readwrite, strong) ASIOperationUserNotificationRead *operationRead;
@property (nonatomic, readwrite, strong) ASIOperationUserNotificationRemove *operationRemove;
@property (nonatomic, readwrite, strong) NSNumber *isSentRead;
@property (nonatomic, readwrite, strong) NSNumber *isSentRemove;

@end