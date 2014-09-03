//
//  TabScanViewController.m
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TabScanViewController.h"
#import "ZBarReaderViewController.h"
#import "ZBarReaderView.h"
#import <AVFoundation/AVFoundation.h>
#import "Utility.h"

@interface TabScanViewController ()<ZBarReaderDelegate, UITextFieldDelegate>

@property (nonatomic, strong) ZBarReaderViewController *zbarReaderController;

@end

@implementation TabScanViewController

-(TabScanViewController *)initWithDelegate:(id<TabScanControllerDelegate>)delegate
{
    self=[super init];
    
    self.delegate=delegate;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.zbarReaderController=[[ZBarReaderViewController alloc] init];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInputView:)];
    
    [inputView addGestureRecognizer:tap];
    
    centerView.layer.borderColor=[UIColor whiteColor].CGColor;
    centerView.layer.borderWidth=2;
}

-(void) tapInputView:(UITapGestureRecognizer*) tap
{
    [btnScan sendActionsForControlEvents:UIControlEventTouchUpInside];
}

-(void)viewWillAppearOnce
{
    centerView.OY=(scanView.SH-centerView.SH)/2;
    
    btnTorch.OY=centerView.OY-btnTorch.SH-5;
    lblTorch.OY=btnTorch.OY;
    
    lineVer.O=CGPointMake(centerView.xw+2, centerView.yh-lineVer.SH+centerView.layer.borderWidth);
    lineHor.O=CGPointMake(lineVer.OX-lineHor.SW+2, lineVer.yh);
    
    scroll.contentSize=scroll.frame.size;
    txt.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    
    AVCaptureDevice *device=_zbarReaderController.readerView.device;
    
    btnTorch.enabled=device.torchAvailable;
    
    _zbarReaderController.showsZBarControls=false;
    _zbarReaderController.showsCameraControls=false;
    _zbarReaderController.cameraFlashMode=UIImagePickerControllerCameraFlashModeAuto;
    _zbarReaderController.wantsFullScreenLayout=false;
    _zbarReaderController.readerDelegate=self;
    _zbarReaderController.supportedOrientationsMask=ZBarOrientationMaskAll;
    _zbarReaderController.videoQuality=UIImagePickerControllerQualityTypeHigh;
    
    _zbarReaderController.view.S=cameraView.S;
    
    [self makeReaderSize:_zbarReaderController.view size:cameraView.l_v_s];
    
    [_zbarReaderController.readerView.device lockForConfiguration:nil];
    
    if([_zbarReaderController.readerView.device supportsAVCaptureSessionPreset:AVCaptureFocusModeLocked])
        _zbarReaderController.readerView.device.focusMode=AVCaptureFocusModeLocked;
    
    [_zbarReaderController.readerView.device unlockForConfiguration];
    
    [_zbarReaderController.scanner setSymbology:ZBAR_I25|ZBAR_QRCODE config: ZBAR_CFG_ENABLE to:0];
    
    [self showCamera];
    
    [self makeTorchStatus];
    
    [device addObserver:self forKeyPath:@"torchAvailable" options:NSKeyValueObservingOptionNew context:nil];
    [device addObserver:self forKeyPath:@"torchMode" options:NSKeyValueObservingOptionNew context:nil];
}

-(void) makeTorchStatus
{
    switch (_zbarReaderController.readerView.device.torchMode) {
        case AVCaptureTorchModeOn:
            lblTorch.text=@"On";
            break;
            
        case AVCaptureTorchModeAuto:
            lblTorch.text=@"Auto";
            break;
            
        case AVCaptureTorchModeOff:
            lblTorch.text=@"Off";
            break;
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    id <NSFastEnumeration> syms = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *sym;
    for(sym in syms) {
        break;
    }
    
    NSString *data=[NSString makeString:sym.data];
    
    if(data.length==0)
        return;
    
    _zbarReaderController.readerDelegate=nil;
    [_zbarReaderController.readerView flushCache];
    [_zbarReaderController.readerView stop];
    
    enum SCAN_CODE_TYPE codeType=SCAN_CODE_TYPE_QRCODE;
    
    if(sym.type==ZBAR_EAN13)
    {
        codeType=SCAN_CODE_TYPE_BARCODE;
    }
    
    [self.delegate tabScanController:self scannedText:data type:codeType];
}

- (IBAction)btnTorchTouchUpInside:(id)sender {
    
    NSError *error=nil;
    [_zbarReaderController.readerView.device lockForConfiguration:&error];
    
    if(!error)
    {
        switch (_zbarReaderController.readerView.device.torchMode) {
            case AVCaptureTorchModeOn:
                _zbarReaderController.readerView.device.torchMode=AVCaptureTorchModeOff;
                break;
                
            case AVCaptureTorchModeOff:
                _zbarReaderController.readerView.device.torchMode=AVCaptureTorchModeAuto;
                break;
                
            case AVCaptureTorchModeAuto:
                _zbarReaderController.readerView.device.torchMode=AVCaptureTorchModeOn;
                break;
        }
        
        [_zbarReaderController.readerView.device unlockForConfiguration];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"torchAvailable"])
    {
        btnTorch.enabled=_zbarReaderController.readerView.device.torchAvailable;
    }
    else if([keyPath isEqualToString:@"torchMode"])
    {
        [self makeTorchStatus];
    }
}

-(void) showCamera
{
    [cameraView addSubview:_zbarReaderController.view];
    [_zbarReaderController.readerView start];
}

-(void) makeReaderSize:(UIView*) view size:(CGSize) size
{
    if(view.l_v_y!=0)
        view.hidden=true;
    
    view.backgroundColor=[UIColor clearColor];
    
    for(UIView *v in view.subviews)
    {
        [self makeReaderSize:v size:size];
    }
}

- (IBAction)btnInputTouchUpInside:(id)sender {
    [UIView animateWithDuration:DURATION_DEFAULT delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        scroll.COX=scroll.SW;
    } completion:^(BOOL finished) {
        if(finished)
            [txt becomeFirstResponder];
    }];
}

- (IBAction)btnScanCodeTouchUpInside:(id)sender {
    [UIView animateWithDuration:DURATION_DEFAULT delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        scroll.COX=0;
    } completion:^(BOOL finished) {
        if(finished)
            [self.view endEditing:true];
    }];
}

-(IBAction)btnCloseTouchUpInside:(id)sender
{
    [self.delegate tabScanControllerTouchedClose:self];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:true];
    [self.delegate tabScanController:self scannedText:textField.text type:SCAN_CODE_TYPE_QRCODE];
    
    return true;
}

@end
