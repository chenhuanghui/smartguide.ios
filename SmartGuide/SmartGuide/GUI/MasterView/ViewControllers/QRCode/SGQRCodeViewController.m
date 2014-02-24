//
//  SGQRCodeViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGQRCodeViewController.h"
#import "GUIManager.h"
#import <AVFoundation/AVFoundation.h>

@interface SGQRCodeViewController ()

@end

@implementation SGQRCodeViewController
@synthesize delegate,containView,containViewFrame,animationType;

- (id)init
{
    self = [super initWithNibName:@"SGQRCodeViewController" bundle:nil];
    if (self) {
        // Custom initialization
        _isShowed=false;
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    zbarReader=[[ZBarReaderViewController alloc] init];
    _navi=[[SGNavigationController alloc] init];
    _reach=[Reachability reachabilityWithHostName:@"smartguide.vn"];
    _isScanningCode=false;
}

-(NSArray *)registerNotifications
{
    return @[kReachabilityChangedNotification];
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:kReachabilityChangedNotification])
    {
        switch (_reach.currentReachabilityStatus) {
            case NotReachable:
            {
                if(_isScanningCode)
                {
                    [self displayDisconnect];
                }
            }
                break;
                
            default:
                if(_resultController && [_resultController.result isKindOfClass:[ScanQRCodeDisconnect class]])
                {
                    [self displayScan];
                }
                break;
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_navi l_v_setS:contentView.l_v_s];
    [contentView insertSubview:_navi.view atIndex:0];
    
    imgvScanTop.transform=CGAffineTransformMakeScale(1, -1);
    
    AVCaptureDevice *device=zbarReader.readerView.device;
    
    btnTorch.enabled=device.torchAvailable;
    
    zbarReader.showsZBarControls=false;
    zbarReader.showsCameraControls=false;
    zbarReader.cameraFlashMode=UIImagePickerControllerCameraFlashModeAuto;
    zbarReader.wantsFullScreenLayout=true;
    zbarReader.readerDelegate=self;
    zbarReader.supportedOrientationsMask=ZBarOrientationMask(UIInterfaceOrientationMaskPortrait);
    
    [zbarReader.scanner setSymbology:ZBAR_I25|ZBAR_QRCODE config: ZBAR_CFG_ENABLE to:0];
    
    [zbarReader.view l_v_setS:cameraView.l_v_s];
    
    for(UIView *subview in zbarReader.view.subviews)
    {
        [subview l_v_setS:cameraView.l_v_s];
    }
    
    [self displayScan];
    
    [device addObserver:self forKeyPath:@"torchAvailable" options:NSKeyValueObservingOptionNew context:nil];
    [device addObserver:self forKeyPath:@"torchMode" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"torchAvailable"])
    {
        btnTorch.enabled=zbarReader.readerView.device.torchAvailable;
    }
    else if([keyPath isEqualToString:@"torchMode"])
    {
        [self makeTorchStatus];
    }
}

-(void) makeTorchStatus
{
    switch (zbarReader.readerView.device.torchMode) {
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

-(void) addBarReaderView
{
    [cameraView insertSubview:zbarReader.view atIndex:0];
    [zbarReader.readerView start];
    _isScanningCode=true;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(!_viewWillAppear)
    {
        switch (animationType) {
            case QRCODE_ANIMATION_TOP_BOT:
            {
                [imgvScanTop l_v_addY:-imgvScanTop.l_v_h];
                [imgvScanBot l_v_addY:imgvScanBot.l_v_h];
                self.view.alpha=0;
                
                [UIView animateWithDuration:DURATION_DEFAULT animations:^{
                    [imgvScanTop l_v_addY:imgvScanTop.l_v_h];
                    [imgvScanBot l_v_addY:-imgvScanBot.l_v_h];
                    self.view.alpha=1;
                    
                    [_reach startNotifier];
                }];
            }
                break;
                
            case QRCODE_ANIMATION_TOP:
            {
                [imgvScanTop l_v_addY:-imgvScanTop.l_v_h];
                self.view.alpha=0;
                
                [UIView animateWithDuration:DURATION_DEFAULT animations:^{
                    [imgvScanTop l_v_addY:imgvScanTop.l_v_h];
                    self.view.alpha=1;
                    
                    [_reach startNotifier];
                }];
            }
                break;
        }
        
        _viewWillAppear=true;
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    id <NSFastEnumeration> syms = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *sym;
    for(sym in syms) {
        break;
    }
    
    zbarReader.readerDelegate=nil;
    
    _operationScanCode=[[ASIOperationScanQRCode alloc] initWithCode:sym.data userLat:userLat() userLng:userLng()];
    _operationScanCode.delegatePost=self;
    
    [_operationScanCode startAsynchronous];
    
    [self.view showLoading];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationScanQRCode class]])
    {
        [self.view removeLoading];
        
        ASIOperationScanQRCode *ope=(ASIOperationScanQRCode*) operation;
        
        [self displayResult:ope.result];
        
        _operationScanCode=nil;
    }
}

-(void) displayDisconnect
{
    if(_resultController && [_resultController.result isKindOfClass:[ScanQRCodeDisconnect class]])
        return;
    
    [self displayResult:[ScanQRCodeDisconnect new]];
}

-(void) displayScan
{
    if(_reach.currentReachabilityStatus==NotReachable)
        return;
    
    if(false && currentUser().enumDataMode==USER_DATA_TRY)
    {
        [[GUIManager shareInstance] showLoginDialogWithMessage:localizeLoginRequire() onOK:nil onCancelled:^{
            [self close];
        } onLogined:^(bool isLogined) {
            if(isLogined)
                [self displayScan];
            else
                [self close];
        }];
        
        return;
    }
    
    scanCodeView.alpha=0;
    scanCodeView.hidden=false;
    btnCloseCamera.alpha=0;
    btnCloseCamera.hidden=false;
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        bgResultView.alpha=0;
        scanCodeView.alpha=1;
        contentView.alpha=0;
        btnCloseCamera.alpha=1;
    } completion:^(BOOL finished) {
        
        [self addBarReaderView];
        zbarReader.readerDelegate=self;
        
        contentView.hidden=true;
        bgResultView.hidden=true;
    }];
}

-(void) displayResult:(id) result
{
    _isScanningCode=false;
    SGQRCodeResultViewController *vc=[[SGQRCodeResultViewController alloc] initWithResult:result];
    
    _resultController=vc;
    [_navi setRootViewController:vc animate:false];
    
    bgResultView.alpha=0;
    bgResultView.hidden=false;
    contentView.alpha=0;
    contentView.hidden=false;
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        bgResultView.alpha=0.7f;
        scanCodeView.alpha=0;
        contentView.alpha=1;
        btnCloseCamera.alpha=0;
    } completion:^(BOOL finished) {
        btnCloseCamera.hidden=true;
        [zbarReader.readerView stop];
        [zbarReader.readerView flushCache];
        [zbarReader.view removeFromSuperview];
    }];
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationScanQRCode class]])
    {
        [self.view removeLoading];
        
        _operationScanCode=nil;
    }
}

-(void)dealloc
{
    [zbarReader.readerView.device removeObserver:self forKeyPath:@"torchAvailable"];
    [zbarReader.readerView.device removeObserver:self forKeyPath:@"torchMode"];
    
    [zbarReader.readerView stop];
    [zbarReader.readerView flushCache];
    
    for(UIView *subview in zbarReader.view.subviews)
        [subview removeFromSuperview];
    
    [zbarReader.view removeFromSuperview];
    [zbarReader removeFromParentViewController];
    zbarReader.readerDelegate=nil;
    zbarReader=nil;
    
    [_reach stopNotifier];
    _reach=nil;
    
    _navi=nil;
    
    if(_operationScanCode)
    {
        [_operationScanCode clearDelegatesAndCancel];
        _operationScanCode=nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setContainView:(UIView *)_containView
{
    containView=_containView;
    containViewFrame=containView.frame;
}

- (IBAction)btnnext:(id)sender {
    UIButton *btn=sender;

    if(btn.tag==0)
    {
        ScanQRCodeResult0 *result=[ScanQRCodeResult0 new];
        result.message=@"Lorem ipsum dolor sit";
        
        [self displayResult:result];
    }
    else if(btn.tag==1)
    {
        NSString *str=@"Lorem ipsum dolor sit amet, consectetuer Lorem ";
        
        ScanQRCodeResult1 *result=[ScanQRCodeResult1 new];
        result.message=str;
        result.idShop=18;
        result.shopName=@"Lorem ipsum dolor sit amet, consectetuer";
        
        [self displayResult:result];
    }
    else if(btn.tag==2)
    {
        ScanQRCodeResult2 *result=[ScanQRCodeResult2 new];
        result.message=@"Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet";
        result.idShop=18;
        result.shopName=@"Lorem ipsum dolor sit amet, consectetuer";
        result.sgp=@"⁺5000";
        result.totalSGP=@"1.000";
        
        [self displayResult:result];
    }
    else if(btn.tag==3)
    {
        
        ScanQRCodeResult3 *result=[ScanQRCodeResult3 new];
        result.message=@"Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet";
        result.type=@"Loại A";
        result.giftName=@"Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet";
        result.sgp=@"⁻5";
        result.totalSGP=@"999.999";
        
        [self displayResult:result];
    }
    else if(btn.tag==4)
    {
        ScanQRCodeResult4 *result=[ScanQRCodeResult4 new];
        result.message=@"Lorem ipsum dolor sit amet";
        result.type=@"Loại B";
        result.voucherName=@"Lorem ipsum dolor sit amet";
        result.idShop=18;
        result.shopName=@"Lorem ipsum dolor sit amet, consectetuer";
        
        [self displayResult:result];
    }
    
    btn.tag++;
    
    if(btn.tag>4)
        btn.tag=0;
}

- (IBAction)btnCloseTouchUpInside:(id)sender {
    [self close];
}

- (IBAction)btnScanTouchUpInside:(id)sender {
    [self displayScan];
}

- (IBAction)btnCloseCameraTouchUpInside:(id)sender {
    [self close];
}

-(void) close
{
    __block void(^_animationCompleted)()=^()
    {
        [self.delegate qrcodeControllerFinished:self];
        
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    };
    switch (animationType) {
        case QRCODE_ANIMATION_TOP_BOT:
        {
            [UIView animateWithDuration:DURATION_DEFAULT animations:^{
                [imgvScanTop l_v_addY:-imgvScanTop.l_v_h];
                [imgvScanBot l_v_addY:imgvScanBot.l_v_h];
                
                self.view.alpha=0;
            } completion:^(BOOL finished) {
                
                _animationCompleted();
                _animationCompleted=nil;
            }];
        }
            break;
            
        case QRCODE_ANIMATION_TOP:
        {
            [UIView animateWithDuration:DURATION_DEFAULT animations:^{
                [imgvScanTop l_v_addY:-imgvScanTop.l_v_h];
                
                self.view.alpha=0;
            } completion:^(BOOL finished) {
                
                _animationCompleted();
                _animationCompleted=nil;
            }];
        }
            break;
    }
    
    
}

- (IBAction)btnTorchTouchUpInside:(id)sender {
    
    NSError *error=nil;
    [zbarReader.readerView.device lockForConfiguration:&error];
    
    if(!error)
    {
        switch (zbarReader.readerView.device.torchMode) {
            case AVCaptureTorchModeOn:
                zbarReader.readerView.device.torchMode=AVCaptureTorchModeOff;
                break;
                
            case AVCaptureTorchModeOff:
                zbarReader.readerView.device.torchMode=AVCaptureTorchModeAuto;
                break;
                
            case AVCaptureTorchModeAuto:
                zbarReader.readerView.device.torchMode=AVCaptureTorchModeOn;
                break;
        }
        
        [zbarReader.readerView.device unlockForConfiguration];
    }
}

@end

#import <objc/runtime.h>

static char SGQRControllerObjectKey;

@implementation SGViewController(QRCode)

-(void)setQrController:(SGQRCodeViewController *)qrController
{
    objc_setAssociatedObject(self, &SGQRControllerObjectKey, qrController, OBJC_ASSOCIATION_ASSIGN);
}

-(SGQRCodeViewController *)qrController
{
    return objc_getAssociatedObject(self, &SGQRControllerObjectKey);
}

-(void)showQRCodeWithContorller:(SGViewController<SGQRCodeControllerDelegate> *)controller inView:(UIView *)view withAnimationType:(enum QRCODE_ANIMATION_TYPE)animationType
{
    SGQRCodeViewController *qr=[SGQRCodeViewController new];
    qr.delegate=controller;
    qr.containView=view;
    qr.animationType=animationType;
    [controller setQrController:qr];
    
    [controller addChildViewController:qr];
    [view addSubview:qr.view];
}

-(void)qrcodeControllerFinished:(SGQRCodeViewController *)controller
{
    self.qrController=nil;
}

@end