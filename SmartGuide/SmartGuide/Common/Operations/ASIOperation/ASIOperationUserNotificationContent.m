//
//  ASIOperationUserPromotionDetail.m
//  Infory
//
//  Created by XXX on 3/31/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationUserNotificationContent.h"

@implementation ASIOperationUserNotificationContent

-(ASIOperationUserNotificationContent *)initWithIDNotification:(int)idNotification page:(int)page userLat:(double)userLat userLng:(double)userLng
{
    self=[super initWithURL:SERVER_API_URL_MAKE(API_USER_NOTIFICATION_CONTENT)];
    
    [self.keyValue setObject:@(idNotification) forKey:@"idNotification"];
    [self.keyValue setObject:@(page) forKey:PAGE];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    self.notifications=[NSMutableArray new];
    
    if([self isNullData:json])
        return;

    UserNotification *noti=[UserNotification userNotificationWithIDNotification:[self.keyValue[@"idNotification"] integerValue]];
    
    for(NSDictionary *dict in json)
    {
        UserNotificationContent *obj=[UserNotificationContent makeWithDictionary:dict];
        obj.notification=noti;

        [self.notifications addObject:obj];
    }
    
    [[DataManager shareInstance] save];
}

@end
