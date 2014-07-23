//
//  ASIOperationUserPromotionDetail.m
//  Infory
//
//  Created by XXX on 3/31/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationUserNotificationFromSender.h"
#import "UserNotification.h"
#import "UserNotificationContent.h"

@implementation ASIOperationUserNotificationFromSender

-(ASIOperationUserNotificationFromSender *)initWithIDSender:(NSNumber*)idSender page:(int)page userLat:(double)userLat userLng:(double)userLng
{
    self=[super initPOSTWithURL:SERVER_API_URL_MAKE(API_USER_NOTIFICATION_LIST_BY_SENDER)];
    
    [self.keyValue setObject:idSender forKey:@"idSender"];
    [self.keyValue setObject:@(page) forKey:PAGE];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    
    return self;
}

-(void)onFinishLoading
{
    self.notifications=[NSMutableArray new];
    self.sender=@"";
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if(![json hasData])
        return;

    NSDictionary *data=[NSDictionary makeDictionary:json[0]];
    
    self.sender=[NSString makeString:data[@"sender"]];
    UserNotification *noti=[UserNotification userNotificationWithIDSender:[self.keyValue[@"idSender"] integerValue]];
    NSNumber *page=self.keyValue[PAGE];
    
    int count=0;
    for(NSDictionary *dict in data[@"messages"])
    {
        UserNotificationContent *obj=[UserNotificationContent makeWithDictionary:dict];
        obj.page=page;
        obj.sortOrder=@(count++);
        obj.notification=noti;
        obj.idSender=noti.idSender;
        obj.sender=self.sender;
        
        noti.sender=self.sender;
        [noti addNotificationContentsObject:obj];

        [self.notifications addObject:obj];
    }
    
    [[DataManager shareInstance] save];
}

@end
