//
//  ASIOperationUserNotification.m
//  Infory
//
//  Created by XXX on 3/31/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationUserNotificationNewest.h"
#import "UserNotification.h"
#import "UserNotificationContent.h"

@implementation ASIOperationUserNotificationNewest

-(ASIOperationUserNotificationNewest *)initWithPage:(int)page userLat:(double)userLat userLng:(double)userLng type:(enum USER_NOTIFICATION_DISPLAY_TYPE)type
{
    self=[super initPOSTWithURL:SERVER_API_URL_MAKE(API_USER_NOTIFICATION_NEWEST)];
    
    [self.keyValue setObject:@(page) forKey:PAGE];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    [self.keyValue setObject:@(type) forKey:@"type"];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    self.userNotifications=[NSMutableArray new];
    
    if([json isNullData])
        return;
    
    for(NSDictionary *dict in json)
    {
        if(!([dict hasData] && [dict isKindOfClass:[NSDictionary class]]))
            continue;
        
        UserNotification *obj=[UserNotification makeWithDictionary:dict];

        NSDictionary *dictContent=dict[@"newestMessage"];
        UserNotificationContent *objContent=[UserNotificationContent makeWithDictionary:dictContent];
        objContent.page=@(0);
        objContent.sortOrder=@(0);
        
        [obj addNotificationContentsObject:objContent];
        
        [self.userNotifications addObject:obj];
    }
    
    [[DataManager shareInstance] save];
}

@end
