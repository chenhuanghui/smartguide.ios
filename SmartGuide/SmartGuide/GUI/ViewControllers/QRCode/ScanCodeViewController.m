//
//  ScanCodeViewController.m
//  Infory
//
//  Created by XXX on 7/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanCodeViewController.h"
#import "ZBarReaderViewController.h"
#import "ZBarReaderView.h"
#import <AVFoundation/AVFoundation.h>

@interface ScanCodeViewController ()<ZBarReaderDelegate>
{
    __strong ZBarReaderViewController *_zbarReaderController;
}

@end

@implementation ScanCodeViewController

- (instancetype)init
{
    self = [super initWithNibName:@"ScanCodeViewController" bundle:nil];
    if (self) {
        
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    
    _zbarReaderController=[[ZBarReaderViewController alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
#if DEBUG
    btnMakeCode.hidden=false;
#endif
}

-(void)viewWillAppearOnce
{
    [cameraView l_v_setS:UIScreenSize()];
    
    AVCaptureDevice *device=_zbarReaderController.readerView.device;
    
    btnTorch.enabled=device.torchAvailable;
    
    _zbarReaderController.showsZBarControls=false;
    _zbarReaderController.showsCameraControls=false;
    _zbarReaderController.cameraFlashMode=UIImagePickerControllerCameraFlashModeAuto;
    _zbarReaderController.wantsFullScreenLayout=false;
    _zbarReaderController.readerDelegate=self;
    _zbarReaderController.supportedOrientationsMask=ZBarOrientationMaskAll;
    _zbarReaderController.videoQuality=UIImagePickerControllerQualityTypeHigh;
    
    [_zbarReaderController.view l_v_setS:cameraView.l_v_s];
    
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
    
    enum SCANCODE_CODE_TYPE codeType=SCANCODE_CODE_TYPE_QRCODE;
    
    if(sym.type==ZBAR_EAN13)
    {
        codeType=SCANCODE_CODE_TYPE_BARCODE;
    }
    
    [self.delegate scanCodeViewController:self scannedText:data codeType:codeType];
}

-(IBAction) btnMakeCodeTouchUpInside:(id) sender
{
#if DEBUG
    NSString *codeTest=@"test1";
    [self.delegate scanCodeViewController:self scannedText:codeTest codeType:SCANCODE_CODE_TYPE_QRCODE];
#endif
}

-(void)dealloc
{
    [_zbarReaderController.readerView.device removeObserver:self forKeyPath:@"torchAvailable"];
    [_zbarReaderController.readerView.device removeObserver:self forKeyPath:@"torchMode"];
    
    [_zbarReaderController.readerView stop];
    [_zbarReaderController.readerView flushCache];
    
    for(UIView *subview in _zbarReaderController.view.subviews)
        [subview removeFromSuperview];
    
    [_zbarReaderController.view removeFromSuperview];
    [_zbarReaderController removeFromParentViewController];
    _zbarReaderController.readerDelegate=nil;
    _zbarReaderController=nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _zbarReaderController.readerDelegate=self;
    [_zbarReaderController.readerView start];
}

@end

@implementation ScanCodeBackgroundView

-(void)drawRect:(CGRect)rect
{
    rect.origin=CGPointZero;
    [[UIImage imageNamed:@"pattern-navigation.jpg"] drawInRect:rect];
}

@end