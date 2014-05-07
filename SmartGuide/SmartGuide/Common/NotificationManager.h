//
//  NotificationManager.h
//  Infory
//
//  Created by XXX on 5/5/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NotificationInfo;

enum NOTIFICATION_CHECK_STATE
{
    NOTIFICATION_CHECK_STATE_INIT=0,
    NOTIFICATION_CHECK_STATE_CHECKING=1,
    NOTIFICATION_CHECK_STATE_DONE=2,
};

enum NOTIFICATION_INFO_TYPE
{
    NOTIFICATION_INFO_TYPE_NONE=0,
    NOTIFICATION_INFO_TYPE_SHOP_DETAIL=1,
    NOTIFICATION_INFO_TYPE_SHOP_LIST=2,
    NOTIFICATION_INFO_TYPE_URL=3
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

@interface NotificationInfo : NSObject

+(NotificationInfo*) notificationInfoWithDictionary:(NSDictionary*) dict;

-(enum NOTIFICATION_INFO_TYPE) enumType;

@property (nonatomic, strong) NSString *badge;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *data;
@property (nonatomic, strong) NSDictionary *dataJson;
@property (nonatomic, strong) NSNumber *type;

@end

@interface NotificationInfo(Type1)

-(int) idShop;

@end

@interface NotificationInfo(Type2)

-(int) idPlacelist;
-(NSString*) keywords;
-(NSString*) idShops;

@end

@interface NotificationInfo(Type3)

-(NSString*) url;

@end