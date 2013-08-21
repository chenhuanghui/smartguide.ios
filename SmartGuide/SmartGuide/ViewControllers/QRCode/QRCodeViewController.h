//
//  QRCodeViewController.h
//  SmartGuide
//
//  Created by XXX on 7/24/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ViewController.h"
#import "ZBarReaderViewController.h"

@protocol QRCodeDelegate <NSObject>

-(void) qrCodeCaptureImage:(UIImage*) image text:(NSString*) text;

@end

@interface QRCodeViewController : ZBarReaderViewController<ZBarReaderDelegate>

@property (nonatomic, assign) id<QRCodeDelegate> delegate;

@end