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
    
    NSDictionary *dict=json[0];
    
//    self.qrCodeResult=[QRCodeDecode new];
//    self.qrCodeResult.title=[NSString makeString:dict[@"title"]];
//    self.qrCodeResult.content=[NSString makeString:dict[@"content"]];
//    
//    if([dict[@"image"] hasData])
//    {
//        self.qrCodeResult.image=[NSString makeString:dict[@"image"]];
//        self.qrCodeResult.imageWidth=[NSNumber numberWithObject:dict[@"imageWidth"]];
//        self.qrCodeResult.imageHeight=[NSNumber numberWithObject:dict[@"imageHeight"]];
//    }
//    
//    if([dict[@"video"] hasData])
//    {
//        self.qrCodeResult.video=[NSString makeString:dict[@"video"]];
//        self.qrCodeResult.videoThumbnail=[NSString makeString:dict[@"videoThumbnail"]];
//        self.qrCodeResult.videoWidth=[NSNumber numberWithObject:dict[@"videoWidth"]];
//        self.qrCodeResult.videoHeight=[NSNumber numberWithObject:dict[@"videoHeight"]];
//    }
//    
//    self.qrCodeResult.buttons=[NSMutableArray new];
//    if([dict[@"buttons"] hasData])
//    {
//        for(NSDictionary *btn in dict[@"buttons"])
//        {
//            UserNotificationAction *action=[UserNotificationAction makeWithAction:btn];
//            
//            [self.qrCodeResult.buttons addObject:action];
//        }
//        
//        [[DataManager shareInstance] save];
//    }
}

@end

@implementation QRCodeDecode

-(enum QRCODE_DECODE_TYPE)enumType
{
    switch ((enum QRCODE_DECODE_TYPE)self.type.integerValue) {
        case QRCODE_DECODE_TYPE_BUTTON:
            return QRCODE_DECODE_TYPE_BUTTON;
            
        case QRCODE_DECODE_TYPE_HEADER:
            return QRCODE_DECODE_TYPE_HEADER;
            
        case QRCODE_DECODE_TYPE_IMAGE:
            return QRCODE_DECODE_TYPE_IMAGE;
            
        case QRCODE_DECODE_TYPE_TEXT:
            return QRCODE_DECODE_TYPE_TEXT;
            
        case QRCODE_DECODE_TYPE_TITLE:
            return QRCODE_DECODE_TYPE_TITLE;
            
        case QRCODE_DECODE_TYPE_VIDEO:
            return QRCODE_DECODE_TYPE_VIDEO;
            
        case QRCODE_DECODE_TYPE_UNKNOW:
            return QRCODE_DECODE_TYPE_UNKNOW;
    }
    
    return QRCODE_DECODE_TYPE_UNKNOW;
}

@end