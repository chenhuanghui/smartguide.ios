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
#import "TPKeyboardAvoidingScrollView.h"
#import "UIScrollView+TPKeyboardAvoidingAdditions.h"
#import "KeyboardUtility.h"
#import "TextField.h"

@interface ScanCodeViewController ()<ZBarReaderDelegate, UITextFieldDelegate,UIScrollViewDelegate>
{
    __strong ZBarReaderViewController *_zbarReaderController;
    __weak UITapGestureRecognizer *_tapScroll;
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
    
    txtCode.placeHolderColor=[UIColor darkGrayColor];
}

-(NSArray *)registerNotifications
{
    return @[UIKeyboardWillShowNotification, UIKeyboardWillHideNotification];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:true];
}

-(void) tapScroll:(UITapGestureRecognizer*) tap
{
    [self.view endEditing:true];
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:UIKeyboardWillShowNotification])
    {
        float duration=[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        float height=[notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
        _zbarReaderController.readerDelegate=nil;
        
        [UIView animateWithDuration:duration animations:^{
            coverCamera.alpha=1;
            scroll.contentOffset=CGPointMake(0, height);
            scroll.contentInset=UIEdgeInsetsMake(0, 0, height, 0);
        }];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScroll:)];
        tap.cancelsTouchesInView=false;
        tap.delaysTouchesEnded=false;
        
        [scroll.panGestureRecognizer requireGestureRecognizerToFail:tap];
        
        [scroll addGestureRecognizer:tap];
        
        _tapScroll=tap;
    }
    else if([notification.name isEqualToString:UIKeyboardWillHideNotification])
    {
        float duration=[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        
        _zbarReaderController.readerDelegate=self;
        
        [UIView animateWithDuration:duration animations:^{
            coverCamera.alpha=0;
            scroll.contentInset=UIEdgeInsetsZero;
        }];
    }
}

-(void)viewWillAppearOnce
{
    scroll.contentSize=scroll.frame.size;
    txtCode.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    
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
    
    if([KeyboardUtility shareInstance].isKeyboardVisible)
    {
        _zbarReaderController.readerDelegate=nil;
        [txtCode becomeFirstResponder];
    }
    else
    {
        _zbarReaderController.readerDelegate=self;
    }
    
    [_zbarReaderController.readerView start];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    _zbarReaderController.readerDelegate=nil;
    [self.view endEditing:true];
    
    [self.delegate scanCodeViewController:self scannedText:textField.text codeType:SCANCODE_CODE_TYPE_QRCODE];
    
    return true;
}

@end

@implementation ScanCodeBackgroundView

-(void)drawRect:(CGRect)rect
{
    rect.origin=CGPointZero;
    [[UIImage imageNamed:@"pattern-navigation.jpg"] drawInRect:rect];
}

@end