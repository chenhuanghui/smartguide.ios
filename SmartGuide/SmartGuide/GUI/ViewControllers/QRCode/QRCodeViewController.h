//
//  SGQRCodeViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "Constant.h"

@interface QRCodeViewController : SGViewController
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
    __weak IBOutlet UIButton *btnMakeQRCode;
    
    __strong SGNavigationController *_navi;
}

-(void) close;
-(void) closeOnCompleted:(void(^)()) completed;

@property (nonatomic, weak) id<QRCodeControllerDelegate> delegate;
@property (nonatomic, weak) UIView *containView;
@property (nonatomic, assign) CGRect containViewFrame;
@property (nonatomic, assign) enum QRCODE_ANIMATION_TYPE animationType;

@end

//@interface SGViewController(QRCode)<QRCodeControllerDelegate>
//@property (nonatomic, readwrite, weak) QRCodeViewController *qrController;
//@property (nonatomic, readwrite, weak) SGViewController<QRCodeControllerDelegate> *qrCodeControllerHandle;
//
//-(void) showQRCodeWithController:(SGViewController<QRCodeControllerDelegate>*) controller inView:(UIView*) view withAnimationType:(enum QRCODE_ANIMATION_TYPE) animationType screenCode:(NSString*) screenCode;
//-(void)qrcodeControllerFinished:(QRCodeViewController *)controller;
//-(void)qrCodeController:(QRCodeViewController *)controller scannedIDBranch:(int)idBranch;
//-(void)qrCodeController:(QRCodeViewController *)controller scannedIDPlacelist:(int)idPlacelist;
//-(void)qrCodeController:(QRCodeViewController *)controller scannedIDShop:(int)idShop;
//-(void)qrCodeController:(QRCodeViewController *)controller scannedIDShops:(NSString *)idShops;
//-(void)qrCodeController:(QRCodeViewController *)controller scannedURL:(NSURL *)url;
//
//@end

@interface QRCodePattern : UIView

@end