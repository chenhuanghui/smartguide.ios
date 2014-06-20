//
//  ASIOperationUserNotificationRemove.m
//  Infory
//
//  Created by XXX on 5/20/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationUserNotificationRemove.h"

@implementation ASIOperationUserNotificationRemove

-(ASIOperationUserNotificationRemove *)initWithIDMessage:(NSNumber *)idMessage idSender:(NSNumber *)idSender userLat:(double)userLat userLng:(double)userLng
{
    self=[super initPOSTWithURL:SERVER_API_URL_MAKE(API_USER_NOTIFICATION_REMOVE)];
    
    if(idSender)
        [self.keyValue setObject:idSender forKey:@"idSender"];
    
    if(idMessage)
        [self.keyValue setObject:idMessage forKey:@"idMessage"];
    
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    
}

@end
