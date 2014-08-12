//
//  ScanCodeViewController.h
//  Infory
//
//  Created by XXX on 7/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"

enum SCANCODE_CODE_TYPE
{
    SCANCODE_CODE_TYPE_QRCODE=0,
    SCANCODE_CODE_TYPE_BARCODE=1,
};

@class ScanCodeViewController, TPKeyboardAvoidingScrollView, TextFieldNormal;

@protocol ScanCodeViewControllerDelegate <SGViewControllerDelegate>

-(void) scanCodeViewController:(ScanCodeViewController*) controller scannedText:(NSString*) text codeType:(enum SCANCODE_CODE_TYPE) codeType;

@end

@interface ScanCodeViewController : SGViewController
{
    __weak IBOutlet UIScrollView *scroll;
    __weak IBOutlet TextFieldNormal *txtCode;
    __weak IBOutlet UIButton *btnTorch;
    __weak IBOutlet UILabel *lblTorch;
    __weak IBOutlet UIView *cameraView;
    __weak IBOutlet UIView *coverCamera;
}

@property (nonatomic, weak) id<ScanCodeViewControllerDelegate> delegate;

@end

@interface ScanCodeBackgroundView : UIView

@end