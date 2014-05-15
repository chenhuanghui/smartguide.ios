//
//  NotificationManager.h
//  Infory
//
//  Created by XXX on 5/5/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NotificationInfo,UserNotification;

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

@property (nonatomic, strong) NSNumber *totalNotification;
@property (nonatomic, strong) NSString *numOfNotification;
@property (nonatomic, strong) NSString *notificationToken;
@property (nonatomic, strong) NSMutableArray *notifications;
@property (nonatomic, strong) NotificationInfo *launchNotification;

@end

@interface NotificationView : UIView

@property (nonatomic, weak) IBOutlet UIButton *btnNumberOfNotification;

@end

@interface UIViewController(Notification)


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

@interface NotificationInfo : NSObject<NSCopying>
{
    bool _isSentRead;
}

+(NotificationInfo*) notificationInfoWithRemoteNotification:(NSDictionary*) dict;

-(void) sendRead;

-(enum NOTI_ACTION_TYPE) enumActionType;
-(enum NOTI_READ_ACTION) enumReadAction;

@property (nonatomic, strong) NSNumber *idNotification;
@property (nonatomic, strong) NSString *badge;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSDictionary *dataJson;
@property (nonatomic, strong) NSNumber *timer;
@property (nonatomic, strong) NSNumber *actionType;
@property (nonatomic, strong) NSNumber *readAction;
@property (nonatomic, strong) NSNumber *idShop;
@property (nonatomic, strong) NSNumber *idPlacelist;
@property (nonatomic, strong) NSString *keywords;
@property (nonatomic, strong) NSString *idShops;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *sender;
@property (nonatomic, strong) NSString *highlight;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSArray *highlightIndex;

@end