//
//  NotificationManager.m
//  Infory
//
//  Created by XXX on 5/5/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "NotificationManager.h"
#import "ASIOperationNotificationCheck.h"

static NotificationManager *_notificationManager=nil;

@interface NotificationManager()<ASIOperationPostDelegate>
{
    ASIOperationNotificationCheck *_operationNotificationCheck;
}

@end

@implementation NotificationManager

+(NotificationManager *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _notificationManager=[NotificationManager new];
    });
    
    return _notificationManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.numOfNotification=@"";
        self.totalNotification=@(0);
        _notificationState=NOTIFICATION_CHECK_STATE_INIT;
    }
    return self;
}

-(void)requestNotificationCheck
{
    if(_notificationState==NOTIFICATION_CHECK_STATE_CHECKING)
        return;
    
    _notificationState=NOTIFICATION_CHECK_STATE_CHECKING;
    _operationNotificationCheck=[[ASIOperationNotificationCheck alloc] initWithUserLat:userLat() userLng:userLng() uuid:UUID()];
    _operationNotificationCheck.delegatePost=self;
    
    [_operationNotificationCheck startAsynchronous];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationNotificationCheck class]])
    {
        ASIOperationNotificationCheck *ope=(ASIOperationNotificationCheck*) operation;
        
        self.totalNotification=[ope.totalNotification copy];
        self.numOfNotification=[ope.numOfNotification copy];
        
        _notificationState=NOTIFICATION_CHECK_STATE_DONE;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_NOTIFICATION_CHECK object:nil];
        
        _operationNotificationCheck=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationNotificationCheck class]])
    {
        _notificationState=NOTIFICATION_CHECK_STATE_DONE;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_NOTIFICATION_CHECK object:nil];
        
        _operationNotificationCheck=nil;
    }
}

-(enum NOTIFICATION_CHECK_STATE)notificationState
{
    return _notificationState;
}

-(void)receiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"receiveRemoteNotification %@",userInfo);
}

-(void)receiveDeviceToken:(NSData *)deviceToken
{
    const unsigned *tokenBytes = [deviceToken bytes];
    NSString *hexToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                          ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                          ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                          ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    NSLog(@"receiveDeviceToken %@",hexToken);
}

@end

@implementation UIViewController(Notification)



@end