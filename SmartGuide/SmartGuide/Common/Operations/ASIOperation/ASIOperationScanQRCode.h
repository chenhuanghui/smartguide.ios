//
//  ASIOperationScanQRCode.h
//  SmartGuide
//
//  Created by MacMini on 13/02/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationScanQRCode : ASIOperationPost

-(ASIOperationScanQRCode*) initWithCode:(NSString*) code userLat:(double) userLat userLng:(double) userLng;

@property (nonatomic, readonly) int status;
@property (nonatomic, readonly) id result;

@end

@interface ScanQRCodeResult0 : NSObject

+(ScanQRCodeResult0*) makeWithDictionary:(NSDictionary*) dict;

@property (nonatomic, strong) NSString *message;

@end

@interface ScanQRCodeResult1 : NSObject

+(ScanQRCodeResult1*) makeWithDictionary:(NSDictionary*) dict;

@property (nonatomic, assign) int idShop;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *message;

@end

@interface ScanQRCodeResult2 : NSObject

+(ScanQRCodeResult2*) makeWithDictionary:(NSDictionary*) dict;

@property (nonatomic, assign) int idShop;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *sgp;
@property (nonatomic, strong) NSString *totalSGP;
@property (nonatomic, strong) NSString *message;

@end

@interface ScanQRCodeResult3 : NSObject

+(ScanQRCodeResult3*) makeWithDictionary:(NSDictionary*) dict;

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *giftName;
@property (nonatomic, strong) NSString *sgp;
@property (nonatomic, strong) NSString *totalSGP;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, assign) int idShop;
@property (nonatomic, strong) NSString *shopName;

@end

@interface ScanQRCodeResult4 : NSObject

+(ScanQRCodeResult4*) makeWithDictionary:(NSDictionary*) dict;

@property (nonatomic, assign) int idShop;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *voucherName;
@property (nonatomic, strong) NSString *message;

@end