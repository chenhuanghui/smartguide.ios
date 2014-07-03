//
//  OperationQRCodeDecode.m
//  Infory
//
//  Created by XXX on 7/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "OperationQRCodeDecode.h"
#import "UserNotificationAction.h"

@implementation OperationQRCodeDecode

-(OperationQRCodeDecode *)initWithCode:(NSString *)code userLat:(double)userLat userLng:(double)userLng
{
    self=[super initPOSTWithURL:SERVER_API_URL_MAKE(API_QRCODE_DECODE)];
    
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    [self.keyValue setObject:code forKey:@"code"];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if(![json hasData])
        return;
    
}

@end