//
//  OperationNotificationCountBySender.m
//  Infory
//
//  Created by XXX on 6/20/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "OperationNotificationCountBySender.h"
#import "UserNotification.h"

@implementation OperationNotificationCountBySender

-(OperationNotificationCountBySender *)initWithIDSender:(int)idSender type:(enum NOTIFICATION_COUNT_TYPE)type userLat:(double)userLat userLng:(double)userLng
{
    self=[super initPOSTWithURL:SERVER_API_URL_MAKE(API_USER_NOTIFICATION_COUNT_BY_SENDER)];
    
    [self.keyValue setObject:@(idSender) forKey:@"idSender"];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    [self.keyValue setObject:@(type) forKey:@"type"];
    
    return self;
}

-(void)onFinishLoading
{
    self.numbers=@[];
    self.strings=@[];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if([json isNullData])
        return;
    
    NSDictionary *dict=json[0];
    
    id numbers=dict[@"number"];
    id strings=dict[@"string"];
    
    if([numbers hasData])
    {
        if([numbers isKindOfClass:[NSArray class]])
            self.numbers=numbers;
        else
            self.numbers=@[numbers];
    }
    
    if([strings hasData])
    {
        if([strings isKindOfClass:[NSArray class]])
            self.strings=strings;
        else
            self.strings=@[strings];
    }
    
    int idSender=[self.keyValue[@"idSender"] integerValue];
    
    UserNotification *obj=[UserNotification userNotificationWithIDSender:idSender];
    if(obj)
    {
        [obj updateNumbers:self.numbers];
        [obj updateTotals:self.strings];
        
        [[DataManager shareInstance] save];
    }
}

@end
