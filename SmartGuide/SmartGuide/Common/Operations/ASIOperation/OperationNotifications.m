//
//  ASIOperationNotifications.m
//  SmartGuide
//
//  Created by MacMini on 9/25/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationNotifications.h"

@implementation OperationNotifications
@synthesize object;

-(OperationNotifications *)initNotificationsWithAccessToken:(NSString *)accessToken version:(NSString *)version
{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:accessToken forKey:@"access_token"];
    [dict setObject:version forKey:@"version"];
    [dict setObject:[[UIDevice currentDevice] platformRawString] forKey:@"deviceInfo"];
    
    self=[super initWithRouter:SERVER_IP_MAKE(API_NOTIFICATIONS) params:dict];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    object=nil;
    if([json isNullData])
        return;
    
    NSDictionary *dict=json[0];
    
    object=[NotificationObject new];
    
    object.notificationType=[[NSNumber numberWithObject:dict[@"notification_type"]] integerValue];
    
    if(object.notificationType==1)
    {
        object.content=[NSString stringWithStringDefault:dict[@"content"]];
        object.link=[NSString stringWithStringDefault:dict[@"link"]];
    }
    else if(object.notificationType==2)
    {
        NSArray *array=dict[@"notify_list"];
        
        if(![array isNullData])
        {
            for(NSDictionary *dictNoti in array)
            {
                NotificationItem *item=[NotificationItem new];
                
                item.idNotification=[[NSNumber numberWithObject:dictNoti[@"notify_id"]] integerValue];
                item.content=[NSString stringWithStringDefault:dictNoti[@"content"]];
                
                [object.notificationList addObject:item];
            }
        }
    }
    else if(object.notificationType==3)
    {
        object.content=[NSString stringWithStringDefault:dict[@"content"]];
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
    
    obj.content=[NSString stringWithStringDefault:self.content];
    obj.notificationList=[self.notificationList copy];
    obj.notificationType=self.notificationType;
    obj.link=[NSString stringWithStringDefault:self.link];
    
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
    
    item.content=[NSString stringWithStringDefault:self.content];
    item.idNotification=self.idNotification;
    
    return item;
}

@end