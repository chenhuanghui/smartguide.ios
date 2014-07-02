//
//  OperationQRCodeDecode.h
//  Infory
//
//  Created by XXX on 7/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@class QRCodeDecode, UserNotificationAction;

@interface OperationQRCodeDecode : ASIOperationPost

-(OperationQRCodeDecode*) initWithCode:(NSString*) code userLat:(double) userLat userLng:(double) userLng;

@property (nonatomic, strong) QRCodeDecode *qrCodeResult;

@end

enum QRCODE_DECODE_TYPE
{
    QRCODE_DECODE_TYPE_UNKNOW=-1,
    QRCODE_DECODE_TYPE_HEADER=0,
    QRCODE_DECODE_TYPE_TITLE=1,
    QRCODE_DECODE_TYPE_TEXT=2,
    QRCODE_DECODE_TYPE_IMAGE=3,
    QRCODE_DECODE_TYPE_VIDEO=4,
    QRCODE_DECODE_TYPE_BUTTON=5,
};

@interface QRCodeDecode : NSObject

-(enum QRCODE_DECODE_TYPE) enumType;

@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSNumber *imageWidth;
@property (nonatomic, strong) NSNumber *imageHeight;
@property (nonatomic, strong) NSString *video;
@property (nonatomic, strong) NSString *videoThumbnail;
@property (nonatomic, strong) NSNumber *videoWidth;
@property (nonatomic, strong) NSNumber *videoHeight;
@property (nonatomic, strong) UserNotificationAction *action;

@end