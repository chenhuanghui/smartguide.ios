//
//  NotificationManager.m
//  Infory
//
//  Created by XXX on 5/5/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "NotificationManager.h"
#import "ASIOperationNotificationCheck.h"
#import "ASIOperationUploadNotificationToken.h"
#import "ASIOperationUserNotificationRead.h"
#import "Utility.h"
#import "UserNotification.h"
#import "UserNotificationContent.h"
#import "GUIManager.h"
#import <objc/runtime.h>

static NotificationManager *_notificationManager=nil;

@interface NotificationManager()<ASIOperationPostDelegate>
{
    ASIOperationNotificationCheck *_operationNotificationCheck;
    ASIOperationUploadNotificationToken *_operationUploadNotiToken;
}

@end

@implementation NotificationManager

+(void)load
{
    [UserNotification markDeleteAllObjects];
    [UserNotificationContent markDeleteAllObjects];
    [[DataManager shareInstance] save];
}

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
        self.notifications=[NSMutableArray new];
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

-(void) uploadToken:(NSString*) notificationToken
{
    if(_operationUploadNotiToken)
    {
        [_operationUploadNotiToken clearDelegatesAndCancel];
        _operationUploadNotiToken=nil;
    }
    
    _operationUploadNotiToken=[[ASIOperationUploadNotificationToken alloc] initWithNotificationToken:notificationToken uuid:UUID()];
    _operationUploadNotiToken.delegatePost=self;
    
    [_operationUploadNotiToken startAsynchronous];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationNotificationCheck class]])
    {
        ASIOperationNotificationCheck *ope=(ASIOperationNotificationCheck*) operation;
        
        self.numOfNotification=[ope.numOfNotification copy];
        self.totalNotification=[ope.totalNotification copy];
        
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:self.totalNotification.integerValue];
        _notificationState=NOTIFICATION_CHECK_STATE_DONE;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_NOTIFICATION_CHECK object:nil];
        
        _operationNotificationCheck=nil;
    }
    else if([operation isKindOfClass:[ASIOperationUploadNotificationToken class]])
    {
        _operationUploadNotiToken=nil;
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
    else if([operation isKindOfClass:[ASIOperationUploadNotificationToken class]])
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
    id info=userInfo[@"aps"];
    
    if(info && [info isKindOfClass:[NSDictionary class]])
    {
        UserNotification *obj=[UserNotification makeWithRemoteNotification:info];
        obj.status=@(USER_NOTIFICATION_STATUS_UNREAD);
        [[DataManager shareInstance] save];
        
        [self.notifications addObject:obj];
        self.totalNotification=[NSNumber numberWithObject:obj.badge];
        [UIApplication sharedApplication].applicationIconBadgeNumber=self.totalNotification.integerValue;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RECEIVED_REMOTE_NOTIFICATION object:obj];
    }
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
    NSDictionary *remote=launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if(!remote)
        return;
    
    NSDictionary *apsInfo=remote[@"aps"];
    
    if(!apsInfo)
        return;
    
    UserNotification *obj=[UserNotification makeWithRemoteNotification:apsInfo];
    [[DataManager shareInstance] save];
    
    self.launchNotification=obj;
}

@end

static char UserNotificationOperationReadKey;
static char UserNotificationIsSentReadKey;
static char UserNotificationOperationRemoveKey;
static char USerNotificationIsSentRemoveKey;

@implementation UserNotification(ASIOperation)

-(void)setOperationRead:(ASIOperationUserNotificationRead *)operationRead
{
    objc_setAssociatedObject(self, &UserNotificationOperationReadKey, operationRead, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(ASIOperationUserNotificationRead *)operationRead
{
    return objc_getAssociatedObject(self, &UserNotificationOperationReadKey);
}

-(void)setOperationRemove:(ASIOperationUserNotificationRemove *)operationRemove
{
    objc_setAssociatedObject(self, &UserNotificationOperationRemoveKey, operationRemove, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(ASIOperationUserNotificationRemove *)operationRemove
{
    return objc_getAssociatedObject(self, &UserNotificationOperationRemoveKey);
}

-(void)setIsSentRead:(NSNumber *)isSentRead
{
    objc_setAssociatedObject(self, &UserNotificationIsSentReadKey, isSentRead, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSNumber *)isSentRead
{
    return objc_getAssociatedObject(self, &UserNotificationIsSentReadKey);
}

-(void)setIsSentRemove:(NSNumber *)isSentRemove
{
    objc_setAssociatedObject(self, &USerNotificationIsSentRemoveKey, isSentRemove, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSNumber *)isSentRemove
{
    return objc_getAssociatedObject(self, &USerNotificationIsSentRemoveKey);
}

-(void)markAndSendRead
{
    if(self.isSentRead.boolValue || self.operationRead)
        return;
    
    self.highlightUnread=@(false);
    [[DataManager shareInstance] save];
    
    self.operationRead=[[ASIOperationUserNotificationRead alloc] initWithIDNotification:self.idNotification.integerValue userLat:userLat() userLng:userLng() uuid:UUID()];
    self.operationRead.delegatePost=self;
    
    [self.operationRead startAsynchronous];
}

-(void)sendDelete
{
    if(self.isSentRemove.boolValue || self.operationRemove)
        return;
    
    self.isSentRemove=@(true);
    
    self.operationRemove=[[ASIOperationUserNotificationRemove alloc] initWithIDNotification:self.idNotification.integerValue userLat:userLat() userLng:userLng() uuid:UUID()];
    self.operationRemove.delegatePost=self;
    
    [self.operationRemove startAsynchronous];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserNotificationRead class]])
    {
        self.operationRead=nil;
        self.isSentRead=@(true);
        
        [self finishedRead];
    }
    else if([operation isKindOfClass:[ASIOperationUserNotificationRemove class]])
    {
        self.operationRemove=nil;
        self.isSentRemove=@(true);
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserNotificationRead class]])
    {
        self.operationRead=nil;
        self.isSentRead=@(true);
        
        [self finishedRead];
    }
    else if([operation isKindOfClass:[ASIOperationUserNotificationRemove class]])
    {
        self.operationRemove=nil;
        self.isSentRemove=@(true);
    }
}

-(void) finishedRead
{
    if([NotificationManager shareInstance].launchNotification==self)
    {
        [NotificationManager shareInstance].launchNotification=nil;
    }
    else
    {
        [[NotificationManager shareInstance].notifications removeObject:self];
    }
}


@end

@implementation UserNotification(RemoteNotification)

+(UserNotification *)makeWithRemoteNotification:(NSDictionary *)dict
{
    UserNotification *obj=[UserNotification insert];
    
    obj.content=[NSString stringWithStringDefault:dict[@"alert"]];
    obj.badge=[NSString stringWithStringDefault:dict[@"badge"]];
    NSString *data=[NSString stringWithStringDefault:dict[@"data"]];
    
    if(data.length>0)
    {
        NSData *dataBytes=[data dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error=nil;
        NSDictionary *dataJson=[NSJSONSerialization JSONObjectWithData:dataBytes options:NSJSONReadingAllowFragments|NSJSONReadingMutableContainers error:&error];
        
        obj.idNotification=[NSNumber numberWithObject:dataJson[@"idNotification"]];
        obj.timer=[NSNumber numberWithObject:dataJson[@"timer"]];
        obj.actionType=[NSNumber numberWithObject:dataJson[@"actionType"]];
        obj.readAction=[NSNumber numberWithObject:dataJson[@"readAction"]];
        obj.sender=[NSString stringWithStringDefault:dataJson[@"sender"]];
        obj.content=[NSString stringWithStringDefault:dataJson[@"content"]];
        obj.highlight=[NSString stringWithStringDefault:dataJson[@"highlight"]];
        obj.time=[NSString stringWithStringDefault:dataJson[@"time"]];\
        
        if(obj.enumStatus==USER_NOTIFICATION_STATUS_UNREAD)
            obj.highlightUnread=@(true);
        
        switch (obj.enumActionType) {
            case USER_NOTIFICATION_ACTION_TYPE_SHOP_USER:
                obj.idShop=[NSNumber numberWithObject:dataJson[@"idShops"]];
                break;
                
            case USER_NOTIFICATION_ACTION_TYPE_SHOP_LIST:
                if(dataJson[@"idPlacelist"])
                    obj.idPlacelist=[NSNumber numberWithObject:dataJson[@"idPlacelist"]];
                else if([dataJson[@"keywords"] isHasString])
                    obj.keywords=[NSString stringWithStringDefault:dataJson[@"keywords"]];
                else if([dataJson[@"idShops"] isHasString])
                    obj.idShops=[NSString stringWithStringDefault:dataJson[@"idShops"]];
                
                break;
                
            case USER_NOTIFICATION_ACTION_TYPE_POPUP_URL:
                obj.url=[NSString stringWithStringDefault:dataJson[@"url"]];
                
            case NOTI_ACTION_TYPE_GO_CONTENT:
            case NOTI_ACTION_TYPE_LOGIN:
            case NOTI_ACTION_TYPE_SCAN_CODE:
            case NOTI_ACTION_TYPE_USER_PROMOTION:
            case NOTI_ACTION_TYPE_USER_SETTING:
                break;
        }
    }
    
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