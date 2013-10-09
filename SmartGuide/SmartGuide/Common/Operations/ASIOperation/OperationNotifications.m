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
//    NSString *info=[NSString stringWithFormat:@"ios%@_%@",[UIDevice currentDevice].systemVersion,SMARTUIDE_VERSION];
    
    NSURL *url=[NSURL URLWithString:SERVER_IP_MAKE(API_NOTIFICATIONS(accessToken, version))];
    
    self=[super initWithURL:url];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    object=nil;
    if([self isNullData:json])
        return;
    
    NSDictionary *dict=[json objectAtIndex:0];
    
    object=[[NotificationObject alloc] init];
    
    object.notificationType=[[NSNumber numberWithObject:[dict objectForKey:@"notification_type"]] integerValue];
    
    if(object.notificationType==1)
    {
        object.content=[NSString stringWithStringDefault:[dict objectForKey:@"content"]];
        object.link=[NSString stringWithStringDefault:[dict objectForKey:@"link"]];
    }
    else if(object.notificationType==2)
    {
        NSArray *array=[dict objectForKey:@"notify_list"];
        
        if(![self isNullData:array])
        {
            for(NSDictionary *dictNoti in array)
            {
                NotificationItem *item=[[NotificationItem alloc] init];
                
                item.idNotification=[[NSNumber numberWithObject:[dictNoti objectForKey:@"notify_id"]] integerValue];
                item.content=[NSString stringWithStringDefault:[dictNoti objectForKey:@"content"]];
                
                [object.notificationList addObject:item];
            }
        }
    }
    else if(object.notificationType==3)
    {
        object.content=[NSString stringWithStringDefault:[dict objectForKey:@"content"]];
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