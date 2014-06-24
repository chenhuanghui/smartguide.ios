//
//  SGQRCodeViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "ZBarReaderViewController.h"
#import "ZBarReaderView.h"
#import "ASIOperationScanQRCode.h"
#import "SGNavigationController.h"
#import "Reachability.h"
#import "QRCodeResultViewController.h"

enum QRCODE_ANIMATION_TYPE {
    QRCODE_ANIMATION_TOP_BOT = 0,
    QRCODE_ANIMATION_TOP = 1
    };

@class QRCodeViewController;

@protocol QRCodeControllerDelegate <SGViewControllerDelegate>

-(void) qrCodeController:(QRCodeViewController*) controller scannedIDShop:(int) idShop;
-(void) qrCodeController:(QRCodeViewController*) controller scannedIDPlacelist:(int) idPlacelist;
-(void) qrCodeController:(QRCodeViewController*) controller scannedIDBranch:(int) idBranch;

@optional
-(void) qrcodeControllerFinished:(QRCodeViewController*) controller;

@end

@interface QRCodeViewController : SGViewController<ZBarReaderDelegate,ASIOperationPostDelegate>
{
    bool _isShowed;
    __weak IBOutlet UIImageView *imgvScanTop;
    __weak IBOutlet UIImageView *imgvScanBot;
    __weak IBOutlet UIView *contentView;
    __weak IBOutlet UIView *bgtView;
    __weak IBOutlet UIView *cameraView;
    __weak IBOutlet UIView *scanCodeView;
    __weak IBOutlet UIImageView *imgvScan;
    __weak IBOutlet UIView *bgResultView;
    __weak IBOutlet UIButton *btnClose;
    __weak IBOutlet UIButton *btnCloseCamera;
    __weak IBOutlet UIButton *btnScan;
    __weak IBOutlet UIButton *btnTorch;
    __weak IBOutlet UILabel *lblTorch;
    
    __strong ZBarReaderViewController *zbarReader;
    ASIOperationScanQRCode *_operationScanCode;
    __strong id _result;
    
    __strong SGNavigationController *_navi;
    __weak QRCodeResultViewController *_resultController;
    
    Reachability *_reach;
    bool _isScanningCode;
}

@property (nonatomic, weak) id<QRCodeControllerDelegate> delegate;
@property (nonatomic, weak) UIView *containView;
@property (nonatomic, assign) CGRect containViewFrame;
@property (nonatomic, assign) enum QRCODE_ANIMATION_TYPE animationType;

@end

@interface SGViewController(QRCode)<QRCodeControllerDelegate>
@property (nonatomic, readwrite, weak) QRCodeViewController *qrController;

-(void) showQRCodeWithContorller:(SGViewController<QRCodeControllerDelegate>*) controller inView:(UIView*) view withAnimationType:(enum QRCODE_ANIMATION_TYPE) animationType screenCode:(NSString*) screenCode;
-(void)qrcodeControllerFinished:(QRCodeViewController *)controller;

@end

@interface QRCodePattern : UIView

@end