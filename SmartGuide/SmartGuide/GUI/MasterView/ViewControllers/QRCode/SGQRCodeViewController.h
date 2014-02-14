//
//  SGQRCodeViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "ZBarReaderViewController.h"
#import "ASIOperationScanQRCode.h"
#import "SGNavigationController.h"
#import "Reachability.h"
#import "SGQRCodeResultViewController.h"

enum QRCODE_ANIMATION_TYPE {
    QRCODE_ANIMATION_TOP_BOT = 0,
    QRCODE_ANIMATION_TOP = 1
    };

@class SGQRCodeViewController;

@protocol SGQRCodeControllerDelegate <SGViewControllerDelegate>

-(void) qrcodeControllerFinished:(SGQRCodeViewController*) controller;
//-(void) qrcodeControllerScanned:(SGQRCodeViewController*) controller;

@end

@interface SGQRCodeViewController : SGViewController<ZBarReaderDelegate,ASIOperationPostDelegate>
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
    
    __strong ZBarReaderViewController *zbarReader;
    ASIOperationScanQRCode *_operationScanCode;
    
    __strong SGNavigationController *_navi;
    __weak SGQRCodeResultViewController *_resultController;
    
    bool _viewWillAppear;
    
    Reachability *_reach;
    bool _isScanningCode;
}

@property (nonatomic, weak) id<SGQRCodeControllerDelegate> delegate;
@property (nonatomic, weak) UIView *containView;
@property (nonatomic, assign) CGRect containViewFrame;
@property (nonatomic, assign) enum QRCODE_ANIMATION_TYPE animationType;

@end

@interface SGViewController(QRCode)<SGQRCodeControllerDelegate>
@property (nonatomic, readwrite, weak) SGQRCodeViewController *qrController;

-(void) showQRCodeWithContorller:(SGViewController<SGQRCodeControllerDelegate>*) controller inView:(UIView*) view withAnimationType:(enum QRCODE_ANIMATION_TYPE) animationType;
-(void)qrcodeControllerFinished:(SGQRCodeViewController *)controller;

@end