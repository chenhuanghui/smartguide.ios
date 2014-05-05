//
//  NotificationManager.h
//  Infory
//
//  Created by XXX on 5/5/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@property (nonatomic, strong) NSNumber *totalNotification;
@property (nonatomic, strong) NSString *numOfNotification;
@property (nonatomic, strong) NSString *notificationToken;

@end

@interface UIViewController(Notification)


@end