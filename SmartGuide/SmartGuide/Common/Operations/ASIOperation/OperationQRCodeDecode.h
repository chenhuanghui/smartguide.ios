//
//  OperationQRCodeDecode.h
//  Infory
//
//  Created by XXX on 7/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@class QRCodeDecode;

@interface OperationQRCodeDecode : ASIOperationPost

-(OperationQRCodeDecode*) initWithCode:(NSString*) code userLat:(double) userLat userLng:(double) userLng;

@property (nonatomic, strong) QRCodeDecode *qrCodeResult;

@end

@interface QRCodeDecode : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSNumber *imageWidth;
@property (nonatomic, strong) NSNumber *imageHeight;
@property (nonatomic, strong) NSString *video;
@property (nonatomic, strong) NSString *videoThumbnail;
@property (nonatomic, strong) NSNumber *videoWidth;
@property (nonatomic, strong) NSNumber *videoHeight;
@property (nonatomic, strong) NSMutableArray *buttons;

@end