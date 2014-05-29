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
    ASIOperationNotificationCount *_operationNotificationCheck;
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
    }
    return self;
}

-(void)requestNotificationCount
{
    if(_notificationState==NOTIFICATION_CHECK_STATE_CHECKING)
        return;
    
    _notificationState=NOTIFICATION_CHECK_STATE_CHECKING;
    _operationNotificationCheck=[[ASIOperationNotificationCount alloc] initWithUserLat:userLat() userLng:userLng() uuid:UUID()];
    _operationNotificationCheck.delegatePost=self;
    
    [_operationNotificationCheck startAsynchronous];
}

-(void) uploadToken:(NSString*) notificationToken
{
    if(_isUploadNotificationToken || _operationUploadNotiToken)
        return;

    _operationUploadNotiToken=[[ASIOperationUpdateTokenUUID alloc] initWithNotificationToken:notificationToken uuid:UUID()];
    _operationUploadNotiToken.delegatePost=self;
    
    [_operationUploadNotiToken startAsynchronous];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationNotificationCount class]])
    {
        ASIOperationNotificationCount *ope=(ASIOperationNotificationCount*) operation;
        
        self.numOfNotification=[ope.numOfNotification copy];
        self.totalNotification=[ope.totalNotification copy];
        
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:self.totalNotification.integerValue];
        _notificationState=NOTIFICATION_CHECK_STATE_DONE;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_NOTIFICATION_CHECK object:nil];
        
        _operationNotificationCheck=nil;
    }
    else if([operation isKindOfClass:[ASIOperationUpdateTokenUUID class]])
    {
        _isUploadNotificationToken=true;
        _operationUploadNotiToken=nil;
        
        [self requestNotificationCount];
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationNotificationCount class]])
    {
        _notificationState=NOTIFICATION_CHECK_STATE_DONE;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_NOTIFICATION_CHECK object:nil];
        
        _operationNotificationCheck=nil;
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
    id info=userInfo[@"aps"];
    
    if(info && [info isKindOfClass:[NSDictionary class]])
    {
        RemoteNotification *obj=[RemoteNotification makeWithRemoteNotification:info];
        
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
    [[DataManager shareInstance] save];
    
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
    [dict setObject:@"Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat" forKey:@"content"];
    [dict setObject:rand()%2==0?@"":@"0;3;5;10" forKey:@"highlight"];
    [dict setObject:[NSString stringWithFormat:@"%@",[NSDate date]] forKey:@"time"];
    [dict setObject:@(random_int(0, 10)) forKey:@"timer"];
    
    [dict setObject:@(actionType) forKey:@"actionType"];
    
    if(actionType==NOTIFICATION_ACTION_TYPE_SHOP_USER)
        [dict setObject:@(123) forKey:@"idShop"];
    else if(actionType==NOTIFICATION_ACTION_TYPE_SHOP_LIST)
    {
        int rd=random_int(0, 2);
        
        if(rd==0)
            [dict setObject:@(0) forKey:@"idPlacelist"];
        else if(rd==1)
            [dict setObject:@"a" forKey:@"keywords"];
        else if(rd==2)
            [dict setObject:@"123,124,125" forKey:@"idShops"];
    }
    else if(NOTIFICATION_ACTION_TYPE_POPUP_URL==3)
        [dict setObject:@"http:\\infory.vn" forKey:@"url"];
    
    NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *dataJson=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"make random notification %@ json %@",dict,dataJson);
    
    dict=[NSMutableDictionary dictionaryWithObject:dataJson forKey:@"data"];
    [dict setObject:[NSString stringWithFormat:@"Alert %02i",actionType] forKey:@"alert"];
    [dict setObject:[NSString stringWithFormat:@"Badge %02i",actionType] forKey:@"badge"];
    [dict setObject:@(1) forKey:@"id"];
    
    dict=[NSMutableDictionary dictionaryWithObject:dict forKey:@"aps"];
    
    return dict;
}

-(void)registerRemoteNotificaion
{
    return;
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
}

@end

@implementation RemoteNotification

+(RemoteNotification *)makeWithRemoteNotification:(NSDictionary *)dict
{
    RemoteNotification *obj=[RemoteNotification new];
    
    obj.message=[NSString stringWithStringDefault:dict[@"message"]];
    obj.badge=[NSString stringWithStringDefault:dict[@"badge"]];
    
    if(dict[@"idNotification"])
    {
        obj.idNotification=[NSNumber numberWithObject:dict[@"idNotification"]];
        obj.idSender=[NSNumber numberWithObject:dict[@"idSender"]];
    }
    
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