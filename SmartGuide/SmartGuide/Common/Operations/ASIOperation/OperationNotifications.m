//
//  ASIOperationNotifications.m
//  SmartGuide
//
//  Created by MacMini on 9/25/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationNotifications.h"
#import "TokenManager.h"

@implementation OperationNotifications

-(OperationNotifications *)initVersion:(NSString *)version
{
//    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
//    [dict setObject:accessToken forKey:@"access_token"];
//    [dict setObject:version forKey:@"version"];
//    [dict setObject:[[UIDevice currentDevice] platformRawString] forKey:@"deviceInfo"];
    
    self=[super initRouterWithMethod:OPERATION_METHOD_TYPE_GET url:SERVER_IP_MAKE(API_NOTIFICATIONS)];
    
    [self.keyValue setObject:version forKey:@"version"];
    [self.keyValue setObject:[TokenManager shareInstance].accessToken forKey:@"accessToken"];
    [self.keyValue setObject:[[UIDevice currentDevice] platformRawString] forKey:@"deviceInfo"];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if([json isNullData])
        return;
    
    NSDictionary *dict=json[0];
    
    self.object=[NotificationObject new];
    
    self.object.notificationType=[[NSNumber makeNumber:dict[@"notification_type"]] integerValue];
    
    if(self.object.notificationType==1)
    {
        self.object.content=[NSString makeString:dict[@"content"]];
        self.object.link=[NSString makeString:dict[@"link"]];
    }
    else if(self.object.notificationType==2)
    {
        NSArray *array=dict[@"notify_list"];
        
        if(![array isNullData])
        {
            for(NSDictionary *dictNoti in array)
            {
                NotificationItem *item=[NotificationItem new];
                
                item.idNotification=[[NSNumber makeNumber:dictNoti[@"notify_id"]] integerValue];
                item.content=[NSString makeString:dictNoti[@"content"]];
                
                [self.object.notificationList addObject:item];
            }
        }
    }
    else if(self.object.notificationType==3)
    {
        self.object.content=[NSString makeString:dict[@"content"]];
    }
}

@end

@implementation NotificationObject
@synthesize content,notificationList,notificationType,link;

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ content %@ notificationList %@ notificationType %i link %@",CLASS_NAME,content,notificationList,notificationType,link];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.content=@"";
        self.notificationType=0;
        self.notificationList=[NSMutableArray array];
        self.link=@"";
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone
{
    NotificationObject *obj=[[NotificationObject alloc] init];
    
    obj.content=[NSString makeString:self.content];
    obj.notificationList=[self.notificationList copy];
    obj.notificationType=self.notificationType;
    obj.link=[NSString makeString:self.link];
    
    return obj;
}

@end

@implementation NotificationItem
@synthesize content,idNotification;

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ content %@ idNotification %i",CLASS_NAME,content,idNotification];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.content=@"";
        self.idNotification=0;
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone
{
    NotificationItem *item=[[NotificationItem alloc] init];
    
    item.content=[NSString makeString:self.content];
    item.idNotification=self.idNotification;
    
    return item;
}

@end