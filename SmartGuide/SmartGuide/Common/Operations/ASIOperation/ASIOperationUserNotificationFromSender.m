//
//  ASIOperationUserPromotionDetail.m
//  Infory
//
//  Created by XXX on 3/31/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationUserNotificationFromSender.h"

@implementation ASIOperationUserNotificationFromSender

-(ASIOperationUserNotificationFromSender *)initWithIDSender:(int)idSender page:(int)page userLat:(double)userLat userLng:(double)userLng
{
    self=[super initPOSTWithURL:SERVER_API_URL_MAKE(API_USER_NOTIFICATION_LIST_BY_SENDER)];
    
    [self.keyValue setObject:@(idSender) forKey:@"idSender"];
    [self.keyValue setObject:@(page) forKey:PAGE];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    self.notifications=[NSMutableArray new];
    self.sender=@"";
    
    if([json isNullData])
        return;

    NSDictionary *data=json[0];
    
    self.sender=[NSString stringWithStringDefault:data[@"sender"]];
    UserNotification *noti=[UserNotification userNotificationWithIDNotification:[self.keyValue[@"idNotification"] integerValue]];
    
    for(NSDictionary *dict in data[@"notifications"])
    {
        UserNotificationContent *obj=[UserNotificationContent makeWithDictionary:dict];
        obj.notification=noti;
        obj.idSender=noti.idSender;
//        obj.status=(NOTIFICATION_STATUS_UNREAD);
//        obj.highlightUnread=@(true);

        [self.notifications addObject:obj];
    }
    
    [[DataManager shareInstance] save];
}

@end
