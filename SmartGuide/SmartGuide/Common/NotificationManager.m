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
        
        self.totalNotification=[ope.totalNotification copy];
        self.numOfNotification=[ope.numOfNotification copy];
        
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
        NotificationInfo *obj=[NotificationInfo notificationInfoWithDictionary:info];
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
    
    NotificationInfo *obj=[NotificationInfo notificationInfoWithDictionary:apsInfo];
    
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

@implementation NotificationInfo

+(NotificationInfo *)notificationInfoWithDictionary:(NSDictionary *)dict
{
    NotificationInfo *obj=[NotificationInfo new];
    
    obj.message=dict[@"alert"];
    obj.badge=dict[@"badge"];
    obj.data=dict[@"data"];
    obj.type=dict[@"type"];
    
    if(obj.data && obj.data.length>0)
    {
        NSData *dataBytes=[obj.data dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error=nil;
        obj.dataJson=[NSJSONSerialization JSONObjectWithData:dataBytes options:NSJSONReadingAllowFragments|NSJSONReadingMutableContainers error:&error];
    }
    
    if(!obj.dataJson)
        obj.dataJson=[NSDictionary dictionary];
    
    return obj;
}

-(enum NOTIFICATION_INFO_TYPE)enumType
{
    switch (self.type.integerValue) {
        case NOTIFICATION_INFO_TYPE_NONE:
            return NOTIFICATION_INFO_TYPE_NONE;
            
        case NOTIFICATION_INFO_TYPE_SHOP_DETAIL:
            return NOTIFICATION_INFO_TYPE_SHOP_DETAIL;
            
        case NOTIFICATION_INFO_TYPE_SHOP_LIST:
            return NOTIFICATION_INFO_TYPE_SHOP_LIST;
            
        case NOTIFICATION_INFO_TYPE_URL:
            return NOTIFICATION_INFO_TYPE_URL;
            
        default:
            return NOTIFICATION_INFO_TYPE_NONE;
    }
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@ %@ %@",self.message,self.badge,self.data,self.dataJson];
}

@end

@implementation NotificationInfo(Type1)

-(int)idShop
{
    return [[NSNumber numberWithObject:self.dataJson[@"idShop"]] integerValue];
}

@end

@implementation NotificationInfo(Type2)

-(int)idPlacelist
{
    return [[NSNumber numberWithObject:self.dataJson[@"idPlacelist"]] integerValue];
}

-(NSString *)keywords
{
    return [NSString stringWithStringDefault:self.dataJson[@"keywords"]];
}

-(NSString *)idShops
{
    return [NSString stringWithStringDefault:self.dataJson[@"idShops"]];
}

@end

@implementation NotificationInfo(Type3)

-(NSString *)url
{
    return [NSString stringWithStringDefault:self.dataJson[@"url"]];
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