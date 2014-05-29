//
//  NotificationManager.h
//  Infory
//
//  Created by XXX on 5/5/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserNotification.h"
#import "ASIOperationUserNotificationMarkRead.h"
#import "ASIOperationUserNotificationRemove.h"

@class RemoteNotification;

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

-(void) registerRemoteNotificaion;
-(void) requestNotificationCount;

-(enum NOTIFICATION_CHECK_STATE) notificationState;

-(void) receiveDeviceToken:(NSData*) deviceToken;
-(void) receiveRemoteNotification:(NSDictionary*) userInfo;
-(void) receiveLaunchNotification:(NSDictionary*) launchOptions;

-(void) removeAllNotification;

#if DEBUG
-(NSDictionary*) makeNotification:(enum NOTIFICATION_ACTION_TYPE) actionType;
#endif

@property (nonatomic, strong) NSNumber *totalNotification;
@property (nonatomic, strong) NSString *numOfNotification;
@property (nonatomic, strong) NSString *notificationToken;
@property (nonatomic, strong) NSMutableArray *remoteNotifications;
@property (nonatomic, strong) RemoteNotification *launchNotification;

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

@interface RemoteNotification : NSObject<NSCopying>

+(RemoteNotification*) makeWithRemoteNotification:(NSDictionary*) dict;

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *badge;
@property (nonatomic, strong) NSNumber *idNotification;
@property (nonatomic, strong) NSNumber *idSender;
@property (nonatomic, strong) NSNumber *timer;

@end