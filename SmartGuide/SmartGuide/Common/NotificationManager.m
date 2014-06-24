//
//  NotificationManager.m
//  Infory
//
//  Created by XXX on 5/5/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "NotificationManager.h"
#import "ASIOperationNotificationCount.h"
#import "ASIOperationUpdateTokenUUID.h"
#import "ASIOperationUserNotificationMarkRead.h"
#import "Utility.h"
#import "UserNotification.h"
#import "UserNotificationContent.h"
#import "GUIManager.h"
#import <objc/runtime.h>

static NotificationManager *_notificationManager=nil;

@interface NotificationManager()<ASIOperationPostDelegate>
{
    ASIOperationNotificationCount *_operationNotificationCount;
    ASIOperationUpdateTokenUUID *_operationUploadNotiToken;
    bool _isUploadNotificationToken;
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
        self.remoteNotifications=[NSMutableArray new];
        _notificationState=NOTIFICATION_CHECK_STATE_INIT;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogin:) name:NOTIFICATION_USER_LOGIN object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogout:) name:NOTIFICATION_USER_LOGOUT object:nil];
    }
    return self;
}

-(void) userLogin:(NSNotification*) notification
{
    if(_operationNotificationCount)
    {
        [_operationNotificationCount clearDelegatesAndCancel];
        _operationNotificationCount=nil;
    }
    
    self.numOfNotification=@"";
    self.totalNotification=@(0);
    
    [self requestNotificationCount];
}

-(void) userLogout:(NSNotification*) notification
{
    if(_operationNotificationCount)
    {
        [_operationNotificationCount clearDelegatesAndCancel];
        _operationNotificationCount=nil;
    }
    
    if(_operationUploadNotiToken)
    {
        [_operationUploadNotiToken clearDelegatesAndCancel];
        _operationUploadNotiToken=nil;
    }
    
    self.numOfNotification=@"";
    self.totalNotification=@(0);
}

-(void)requestNotificationCount
{
    if(_notificationState==NOTIFICATION_CHECK_STATE_CHECKING)
        return;
    
    _notificationState=NOTIFICATION_CHECK_STATE_CHECKING;
    _operationNotificationCount=[[ASIOperationNotificationCount alloc] initWithCountType:NOTIFICATION_COUNT_TYPE_UNREAD userLat:userLat() userLng:userLng() uuid:UUID()];
    _operationNotificationCount.delegate=self;
    
    [_operationNotificationCount addToQueue];
}

-(void) uploadToken:(NSString*) notificationToken
{
    if(_isUploadNotificationToken || _operationUploadNotiToken)
        return;

    _operationUploadNotiToken=[[ASIOperationUpdateTokenUUID alloc] initWithNotificationToken:notificationToken uuid:UUID()];
    _operationUploadNotiToken.delegate=self;
    
    [_operationUploadNotiToken addToQueue];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationNotificationCount class]])
    {
        ASIOperationNotificationCount *ope=(ASIOperationNotificationCount*) operation;
        
        self.totalNotification=ope.numbers[0];
        self.numOfNotification=ope.strings[0];
        
        if(self.totalNotification.integerValue==0)
            self.numOfNotification=@"";
        
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:self.totalNotification.integerValue];
        _notificationState=NOTIFICATION_CHECK_STATE_DONE;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_TOTAL_NOTIFICATION_CHANGED object:nil];
        
        _operationNotificationCount=nil;
    }
    else if([operation isKindOfClass:[ASIOperationUpdateTokenUUID class]])
    {
        _isUploadNotificationToken=true;
        _operationUploadNotiToken=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationNotificationCount class]])
    {
        _notificationState=NOTIFICATION_CHECK_STATE_DONE;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_TOTAL_NOTIFICATION_CHANGED object:nil];
        
        _operationNotificationCount=nil;
    }
    else if([operation isKindOfClass:[ASIOperationUpdateTokenUUID class]])
    {
        _operationUploadNotiToken=nil;
    }
}

-(enum NOTIFICATION_CHECK_STATE)notificationState
{
    return _notificationState;
}

-(void)receiveRemoteNotification:(NSDictionary *)userInfo
{
#if !DEBUG
    if(currentUser().enumDataMode!=USER_DATA_FULL)
        return;
#endif
    
    id info=userInfo[@"aps"];
    
    if(info && [info isKindOfClass:[NSDictionary class]])
    {
        RemoteNotification *obj=[RemoteNotification makeWithRemoteNotification:info];
        obj.isFromBG=@([UIApplication sharedApplication].applicationState==UIApplicationStateInactive);
        
        if(!obj.isFromBG.boolValue)
            [self.remoteNotifications addObject:obj];
        
        self.totalNotification=[NSNumber numberWithObject:obj.badge];
        [UIApplication sharedApplication].applicationIconBadgeNumber=self.totalNotification.integerValue;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RECEIVED_REMOTE_NOTIFICATION object:obj];
        
        [self postTotalNotificationChanged];
    }
}

-(void) postTotalNotificationChanged
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_TOTAL_NOTIFICATION_CHANGED object:nil];
}

-(void)receiveDeviceToken:(NSData *)deviceToken
{
    const unsigned *tokenBytes = [deviceToken bytes];
    NSString *hexToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                          ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                          ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                          ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    
    [self uploadToken:hexToken];
}

-(void)receiveLaunchNotification:(NSDictionary *)launchOptions
{
    [[NotificationManager shareInstance] removeAllNotification];
    
    if(!launchOptions)
        return;
    
    NSDictionary *remote=launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if(!remote)
        return;
    
    NSDictionary *apsInfo=remote[@"aps"];
    
    if(!apsInfo)
        return;

    RemoteNotification *obj=[RemoteNotification makeWithRemoteNotification:apsInfo];
    self.launchNotification=obj;
}

-(void)removeAllNotification
{
    [UserNotification markDeleteAllObjects];
    [UserNotificationContent markDeleteAllObjects];
    [[DataManager shareInstance] save];
}

-(NSDictionary*) makeNotification:(enum NOTIFICATION_ACTION_TYPE) actionType
{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    
    [dict setObject:@(rand()) forKey:@"idNotification"];
    [dict setObject:@(rand()) forKey:@"idSender"];
    [dict setObject:@(random_int(0, 10)) forKey:@"timer"];
    [dict setObject:[NSString stringWithFormat:@"Alert %02i",actionType] forKey:@"message"];
    [dict setObject:[NSString stringWithFormat:@"Badge %02i",actionType] forKey:@"badge"];

    dict=[NSMutableDictionary dictionaryWithObject:dict forKey:@"aps"];
    
    return dict;
}

-(void)registerRemoteNotificaion
{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
}

@end

@implementation RemoteNotification

+(RemoteNotification *)makeWithRemoteNotification:(NSDictionary *)dict
{
    RemoteNotification *obj=[RemoteNotification new];
    
    obj.message=[NSString stringWithStringDefault:dict[@"message"]];
    
    if(obj.message.length==0)
        obj.message=[NSString stringWithStringDefault:dict[@"alert"]];
    
    obj.badge=[NSString stringWithStringDefault:dict[@"badge"]];
    
    if(dict[@"idNotification"])
        obj.idNotification=[NSNumber numberWithObject:dict[@"idNotification"]];
    
    if(dict[@"idSender"])
        obj.idSender=[NSNumber numberWithObject:dict[@"idSender"]];
    
    obj.timer=@(0);
    if(dict[@"timer"])
        obj.timer=[NSNumber numberWithObject:dict[@"timer"]];
    
    return obj;
}

-(id)copyWithZone:(NSZone *)zone
{
    RemoteNotification *obj=[RemoteNotification new];
    
    obj.message=self.message;
    obj.badge=self.badge;
    
    if(self.idNotification)
        obj.idNotification=self.idNotification;
    
    if(self.idSender)
        obj.idSender=self.idSender;
    
    obj.isFromBG=self.isFromBG;
    obj.timer=self.timer;
    
    return obj;
}

@end

@implementation NotificationView

-(void) totalNotificationChanged:(NSNotification*) notification
{
    [self.btnNumberOfNotification setTitle:[NotificationManager shareInstance].numOfNotification forState:UIControlStateNormal];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(totalNotificationChanged:) name:NOTIFICATION_TOTAL_NOTIFICATION_CHANGED object:nil];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_TOTAL_NOTIFICATION_CHANGED object:nil];
}

@end