//
//  ASIOperationUserNotification.m
//  Infory
//
//  Created by XXX on 3/31/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationUserNotification.h"

@implementation ASIOperationUserNotification

-(ASIOperationUserNotification *)initWithPage:(int)page userLat:(double)userLat userLng:(double)userLng type:(enum USER_NOTIFICATION_DISPLAY_TYPE)type
{
    self=[super initWithURL:SERVER_API_URL_MAKE(API_USER_NOTIFICATION)];
    
    [self.keyValue setObject:@(page) forKey:PAGE];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    [self.keyValue setObject:@(type) forKey:@"type"];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    self.userNotifications=[NSMutableArray new];
    
    if([self isNullData:json])
        return;
    
    int count=0;
    for(NSDictionary *dict in json)
    {
        UserNotification *obj=[UserNotification makeWithDictionary:dict];
        obj.sortOrder=@(count++);

        [self.userNotifications addObject:obj];
        
        if(obj.enumStatus==USER_NOTIFICATION_STATUS_READ)
            break;
    }
    
    [[DataManager shareInstance] save];
}

@end
