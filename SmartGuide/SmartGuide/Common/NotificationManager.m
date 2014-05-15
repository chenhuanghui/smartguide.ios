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
#import "GUIManager.h"

static NotificationManager *_notificationManager=nil;

@interface NotificationManager()<ASIOperationPostDelegate>
{
    ASIOperationNotificationCheck *_operationNotificationCheck;
    ASIOperationUploadNotificationToken *_operationUploadNotiToken;
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
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RECEIVED_REMOTE_NOTIFICATION object:nil];
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
    
    NotificationInfo *obj=[NotificationInfo notificationInfoWithRemoteNotification:apsInfo];
    
    self.launchNotification=obj;
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
    NSString *data=[NSString stringWithStringDefault:dict[@"data"]];
    
    if(data.length>0)
    {
        NSData *dataBytes=[data dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error=nil;
        obj.dataJson=[NSJSONSerialization JSONObjectWithData:dataBytes options:NSJSONReadingAllowFragments|NSJSONReadingMutableContainers error:&error];
        
        obj.idNotification=[NSNumber numberWithObject:obj.dataJson[@"idNotification"]];
        obj.timer=[NSNumber numberWithObject:obj.dataJson[@"timer"]];
        obj.actionType=[NSNumber numberWithObject:obj.dataJson[@"actionType"]];
        obj.readAction=[NSNumber numberWithObject:obj.dataJson[@"readAction"]];
        obj.sender=[NSString stringWithStringDefault:obj.dataJson[@"sender"]];
        obj.content=[NSString stringWithStringDefault:obj.dataJson[@"content"]];
        obj.highlight=[NSString stringWithStringDefault:obj.dataJson[@"highlight"]];
        obj.time=[NSString stringWithStringDefault:obj.dataJson[@"time"]];
        
        if(obj.highlight.length>0)
        {
            obj.highlightIndex=[obj.highlight componentsSeparatedByString:@","];
        }
        
        switch (obj.enumActionType) {
            case NOTI_ACTION_TYPE_SHOP_USER:
                obj.idShop=[NSNumber numberWithObject:obj.dataJson[@"idShops"]];
                break;
                
            case NOTI_ACTION_TYPE_SHOP_LIST:
                if(obj.dataJson[@"idPlacelist"])
                    obj.idPlacelist=[NSNumber numberWithObject:obj.dataJson[@"idPlacelist"]];
                else if([obj.dataJson[@"keywords"] isHasString])
                    obj.keywords=[NSString stringWithStringDefault:obj.dataJson[@"keywords"]];
                else if([obj.dataJson[@"idShops"] isHasString])
                    obj.idShops=[NSString stringWithStringDefault:obj.dataJson[@"idShops"]];
                    
                break;
                
            case NOTI_ACTION_TYPE_POPUP_URL:
                obj.url=[NSString stringWithStringDefault:obj.dataJson[@"url"]];
                
            default:
                break;
        }
    }
    
    if(!obj.dataJson)
        obj.dataJson=[NSDictionary dictionary];
    
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
    return [NSString stringWithFormat:@"%@ %@ %@",self.message,self.badge,self.dataJson];
}

-(id)copyWithZone:(NSZone *)zone
{
    NotificationInfo *obj=[NotificationInfo new];
    
    obj.idNotification=[self.idNotification copy];
    obj.badge=[self.badge copy];
    obj.message=[self.message copy];
    obj.dataJson=[self.dataJson copy];
    obj.timer=[self.timer copy];
    obj.actionType=[self.actionType copy];
    obj.readAction=[self.actionType copy];
    obj.idShop=[self.idShop copy];
    obj.idPlacelist=[self.idPlacelist copy];
    obj.keywords=[self.keywords copy];
    obj.idShops=[self.idShops copy];
    obj.url=[self.url copy];
    
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