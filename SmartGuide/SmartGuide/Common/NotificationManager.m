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

static NotificationManager *_notificationManager=nil;

@interface NotificationManager()<ASIOperationPostDelegate>
{
    ASIOperationNotificationCheck *_operationNotificationCheck;
    ASIOperationUploadNotificationToken *_operationUploadNotiToken;
}

@end

@implementation NotificationManager
@synthesize totalNotification;

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
        NotificationInfo *obj=[NotificationInfo notificationInfoWithRemoteNotification:info];
        [self.notifications addObject:obj];
        self.totalNotification=@(self.totalNotification.integerValue+1);
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
    NSDictionary *apsInfo=remote[@"aps"];
    
    NotificationInfo *obj=[NotificationInfo notificationInfoWithRemoteNotification:apsInfo];
    
    self.launchNotification=obj;
}

-(void)setTotalNotification:(NSNumber *)totalNotification_
{
    bool hasChange=totalNotification.integerValue!=totalNotification_.integerValue;
    
    totalNotification=totalNotification_;
    
    if(hasChange)
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_TOTAL_NOTIFICATION_CHANGED object:nil];
}

@end

@implementation UIViewController(Notification)



@end

@interface NotificationInfo()<ASIOperationPostDelegate>
{
    ASIOperationUserNotificationRead *_operationRead;
}

@end

@implementation NotificationInfo

+(NotificationInfo *)notificationInfoWithRemoteNotification:(NSDictionary *)dict
{
    NotificationInfo *obj=[NotificationInfo new];
    
    obj.message=[NSString stringWithStringDefault:dict[@"alert"]];
    obj.badge=[NSString stringWithStringDefault:dict[@"badge"]];
    obj.data=[NSString stringWithStringDefault:dict[@"data"]];
    obj.type=[NSNumber numberWithObject:dict[@"type"]];
    
    if(obj.data && obj.data.length>0)
    {
        NSData *dataBytes=[obj.data dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error=nil;
        obj.dataJson=[NSJSONSerialization JSONObjectWithData:dataBytes options:NSJSONReadingAllowFragments|NSJSONReadingMutableContainers error:&error];
        
        obj.idNotification=[NSNumber numberWithObject:obj.dataJson[@"idNotification"]];
    }
    
    if(!obj.dataJson)
        obj.dataJson=[NSDictionary dictionary];
    
    return obj;
}

+(NotificationInfo *)notificationInfoWithNotificationContent:(NSDictionary *)dict
{
    NotificationInfo *obj=[NotificationInfo new];
    
    obj.idNotification=[NSNumber numberWithObject:dict[@"idNotification"]];
    
    
    return obj;
}

-(void)sendRead
{
    if(_isSentRead || _operationRead)
        return;
    
    _operationRead=[[ASIOperationUserNotificationRead alloc] initWithIDNotification:self.idNotification.integerValue userLat:userLat() userLng:userLng() uuid:UUID()];
    _operationRead.delegatePost=self;
    
    [_operationRead startAsynchronous];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    _operationRead=nil;
    _isSentRead=true;
    
    [self finished];
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    _operationRead=nil;
    _isSentRead=true;
    
    [self finished];
}

-(void) finished
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

-(enum NOTI_ACTION_TYPE)enumActionType
{
    switch (self.actionType.integerValue) {
        case NOTI_ACTION_TYPE_GO_CONTENT:
            return NOTI_ACTION_TYPE_GO_CONTENT;
            
        case NOTI_ACTION_TYPE_LOGIN:
            return NOTI_ACTION_TYPE_LOGIN;
            
        case NOTI_ACTION_TYPE_POPUP_URL:
            return NOTI_ACTION_TYPE_POPUP_URL;
            
        case NOTI_ACTION_TYPE_SCAN_CODE:
            return NOTI_ACTION_TYPE_SCAN_CODE;
            
        case NOTI_ACTION_TYPE_SHOP_LIST:
            return NOTI_ACTION_TYPE_SHOP_LIST;
            
        case NOTI_ACTION_TYPE_SHOP_USER:
            return NOTI_ACTION_TYPE_SHOP_USER;
            
        case NOTI_ACTION_TYPE_USER_PROMOTION:
            return NOTI_ACTION_TYPE_USER_PROMOTION;
            
        case NOTI_ACTION_TYPE_USER_SETTING:
            return NOTI_ACTION_TYPE_USER_SETTING;
            
        default:
            return NOTI_ACTION_TYPE_GO_CONTENT;
    }
}

-(enum NOTI_READ_ACTION)enumReadAction
{
    switch (self.readAction.integerValue) {
        case NOTI_READ_ACTION_GO_TO:
            return NOTI_READ_ACTION_GO_TO;
            
        case NOTI_READ_ACTION_TOUCH:
            return NOTI_READ_ACTION_TOUCH;
            
        default:
            return NOTI_READ_ACTION_TOUCH;
    }
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@ %@ %@",self.message,self.badge,self.data,self.dataJson];
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