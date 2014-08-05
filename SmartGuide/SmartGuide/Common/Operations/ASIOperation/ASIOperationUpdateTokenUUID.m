//
//  ASIOperationUploadNotificationToken.m
//  Infory
//
//  Created by XXX on 5/5/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationUpdateTokenUUID.h"

@implementation ASIOperationUpdateTokenUUID

-(ASIOperationUpdateTokenUUID *)initWithNotificationToken:(NSString *)token uuid:(NSString *)uuid
{
    self=[super initPOSTWithURL:SERVER_API_URL_MAKE(API_USER_NOTIFICATION_TOKEN)];
    
    [self.keyValue setObject:token forKey:@"token"];
    [self.keyValue setObject:uuid forKey:@"uuid"];
    [self.keyValue setObject:@(0) forKey:@"type"];
    if(NSFoundationVersionNumber<=NSFoundationVersionNumber_iOS_6_1)
        [self.keyValue setObject:macAddress() forKey:@"macAddress"];
    
    return self;
}

@end
