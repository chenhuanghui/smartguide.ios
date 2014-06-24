//
//  ASIOperationNotificationCheck.m
//  Infory
//
//  Created by XXX on 4/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationNotificationCount.h"

@implementation ASIOperationNotificationCount

-(ASIOperationNotificationCount *)initWithCountType:(enum NOTIFICATION_COUNT_TYPE)countType userLat:(double)userLat userLng:(double)userLng uuid:(NSString *)uuid
{
    self=[super initPOSTWithURL:SERVER_API_URL_MAKE(API_USER_NOTIFICATION_COUNT)];
    
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    [self.keyValue setObject:@(countType) forKey:@"type"];
    
    return self;
}

-(void)onFinishLoading
{
    self.numbers=@[@(0)];
    self.strings=@[@""];
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
}

@end
