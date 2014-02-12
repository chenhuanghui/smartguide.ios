//
//  SGQRCodeViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class SGQRCodeViewController;

@protocol SGQRCodeControllerDelegate <SGViewControllerDelegate>

-(void) qrcodeControllerRequestClose:(SGQRCodeViewController*) controller;
//-(void) qrcodeControllerScanned:(SGQRCodeViewController*) controller;

@end

@interface SGQRCodeViewController : SGViewController
{
    bool _isShowed;
    __weak IBOutlet UIImageView *imgvScanTop;
    __weak IBOutlet UIImageView *imgvScanBot;
    __weak IBOutlet UIView *contentView;
}

@property (nonatomic, weak) id<SGQRCodeControllerDelegate> delegate;
@property (nonatomic, weak) UIView *containView;
@property (nonatomic, assign) CGRect containViewFrame;

@end

@interface SGViewController(QRCode)
@property (nonatomic, readwrite, weak) SGQRCodeViewController *qrController;

-(void) showQRCodeWithContorller:(SGViewController<SGQRCodeControllerDelegate>*) controller inView:(UIView*) view;
-(void) hideQRCode;

@end