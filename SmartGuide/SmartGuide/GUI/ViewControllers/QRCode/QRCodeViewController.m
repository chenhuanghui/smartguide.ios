//
//  SGQRCodeViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "QRCodeViewController.h"
#import "GUIManager.h"
#import <AVFoundation/AVFoundation.h>
#import "ZBarReaderViewController.h"
#import "ZBarReaderView.h"
#import "ASIOperationScanQRCode.h"
#import "SGNavigationController.h"
#import "Reachability.h"
#import "QRCodeResultViewController.h"

@interface QRCodeViewController ()<ZBarReaderDelegate,ASIOperationPostDelegate>
{
    __weak QRCodeResultViewController *_resultController;
    __strong ZBarReaderViewController *zbarReader;
    ASIOperationScanQRCode *_operationScanCode;
    Reachability *_reach;
    bool _isScanningCode;
    __strong id _result;
}

@end

@implementation QRCodeViewController
@synthesize delegate,containView,containViewFrame,animationType;

- (id)init
{
    self = [super initWithNibName:@"QRCodeViewController" bundle:nil];
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
    
#if DEBUG
    btnMakeQRCode.hidden=false;
#endif
    
    [_navi l_v_setS:contentView.l_v_s];
    [contentView insertSubview:_navi.view atIndex:0];
    
    imgvScanTop.transform=CGAffineTransformMakeScale(1, -1);
    
    AVCaptureDevice *device=zbarReader.readerView.device;
    
    btnTorch.enabled=device.torchAvailable;
    
    zbarReader.showsZBarControls=false;
    zbarReader.showsCameraControls=false;
    zbarReader.cameraFlashMode=UIImagePickerControllerCameraFlashModeAuto;
    zbarReader.wantsFullScreenLayout=false;
    zbarReader.readerDelegate=self;
    zbarReader.supportedOrientationsMask=ZBarOrientationMaskAll;
    //    zbarReader.readerView.showsFPS=true;
    //    zbarReader.readerView.zoom=1.25f;
    zbarReader.videoQuality=UIImagePickerControllerQualityTypeHigh;
    
    [zbarReader.readerView.device lockForConfiguration:nil];
    
    if([zbarReader.readerView.device supportsAVCaptureSessionPreset:AVCaptureFocusModeLocked])
        zbarReader.readerView.device.focusMode=AVCaptureFocusModeLocked;
    
    [zbarReader.readerView.device unlockForConfiguration];
    
    [zbarReader.scanner setSymbology:ZBAR_I25|ZBAR_QRCODE config: ZBAR_CFG_ENABLE to:0];
    
    [zbarReader.view l_v_setS:cameraView.l_v_s];
    
    zbarReader.view.autoresizingMask=UIViewAutoresizingAll();
    for(UIView *subview in zbarReader.view.subviews)
    {
        [subview l_v_setS:cameraView.l_v_s];
        zbarReader.view.autoresizingMask=UIViewAutoresizingAll();
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

-(void)viewWillAppearOnce
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
    
}

-(void) processCode:(NSString*) data
{
    if([data containsString:QRCODE_DOMAIN_INFORY])
    {
        NSURL *url=[NSURL URLWithString:data];
        if([data containsString:QRCODE_INFORY_SHOPS])
        {
            NSString *idShops=[url query];
            if(idShops.length>0)
            {
                NSArray *array=[idShops componentsSeparatedByString:@"="];
                if(array.count>1)
                {
                    idShops=array[1];
                    
                    [self.delegate qrCodeController:self scannedIDShops:idShops];
                    return;
                }
            }
            
            [self requestScanCodeWithCode:data];
        }
        else if([data containsString:QRCODE_INFORY_SHOP])
        {
            int idShop=[[url lastPathComponent] integerValue];
            
            [self.delegate qrCodeController:self scannedIDShop:idShop];
        }
        else if([data containsString:QRCODE_INFORY_PLACELIST])
        {
            int idPlacelist=[[url lastPathComponent] integerValue];
            
            [self.delegate qrCodeController:self scannedIDPlacelist:idPlacelist];
        }
        else if([data containsString:QRCODE_INFORY_CODE])
        {
            NSString *hash=[url lastPathComponent];
            
            [self requestScanCodeWithCode:hash];
        }
        else if([data containsString:QRCODE_INFORY_BRANCH])
        {
            int idBranch=[[url lastPathComponent] integerValue];
            
            [self.delegate qrCodeController:self scannedIDBranch:idBranch];
        }
        else
        {
            [self requestScanCodeWithCode:data];
        }
    }
    else
    {
        NSDataDetector *dataDetector=[NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
        
        if([dataDetector numberOfMatchesInString:data options:0 range:NSMakeRange(0, data.length)]!=0)
        {
            [self.delegate qrCodeController:self scannedURL:URL(data)];
        }
        else
        {
            [self requestScanCodeWithCode:data];
        }
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    id <NSFastEnumeration> syms = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *sym;
    for(sym in syms) {
        break;
    }
    
    NSString *data=[NSString stringWithStringDefault:sym.data];
    
    if(data.length==0)
        return;
    
    zbarReader.readerDelegate=nil;
    
    [self processCode:data];
}

-(void) requestScanCodeWithCode:(NSString*) code
{
    if(currentUser().enumDataMode!=USER_DATA_FULL)
    {
        [[GUIManager shareInstance] showLoginDialogWithMessage:@"Bạn cần đăng nhập để xem thông tin này" onOK:^{
            [SGData shareInstance].fScreen=[QRCodeViewController screenCode];
        } onCancelled:nil onLogined:^(bool isLogined) {
            if(isLogined)
            {
                [self requestScanCodeWithCode:code];
            }
        }];
        return;
    }
    
    _operationScanCode=[[ASIOperationScanQRCode alloc] initWithCode:code userLat:userLat() userLng:userLng()];
    _operationScanCode.delegate=self;
    
    [_operationScanCode addToQueue];
    
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

    bool validateUserLogined=false;
    if(validateUserLogined && currentUser().enumDataMode==USER_DATA_TRY)
    {
        [[GUIManager shareInstance] showLoginDialogWithMessage:localizeLoginRequire() onOK:^
         {
             [SGData shareInstance].fScreen=[QRCodeViewController screenCode];
         } onCancelled:^{
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
    btnTorch.alpha=0;
    btnTorch.hidden=false;
    lblTorch.alpha=0;
    lblTorch.hidden=false;
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        bgResultView.alpha=0;
        scanCodeView.alpha=1;
        contentView.alpha=0;
        btnCloseCamera.alpha=1;
        lblTorch.alpha=1;
        btnTorch.alpha=1;
    } completion:^(BOOL finished) {
        
        [self addBarReaderView];
        zbarReader.readerDelegate=self;
        
        contentView.hidden=true;
        bgResultView.hidden=true;
    }];
}

-(void) displayResult:(id) result
{
    DLOG_DEBUG(@"%@",result);
    
    _result=result;
    _isScanningCode=false;
    QRCodeResultViewController *vc=[[QRCodeResultViewController alloc] initWithResult:result];
    
    _resultController=vc;
    [_navi setRootViewController:vc animate:false];
    
    bgResultView.alpha=0;
    bgResultView.hidden=false;
    contentView.alpha=0;
    contentView.hidden=false;
    btnTorch.alpha=1;
    btnTorch.hidden=false;
    lblTorch.alpha=1;
    lblTorch.hidden=false;
    
    if([_result isKindOfClass:[ScanQRCodeResult0 class]] || [_result isKindOfClass:[ScanQRCodeResult1 class]])
        [btnScan setTitle:@"Quét tiếp" forState:UIControlStateNormal];
    else
        [btnScan setTitle:@"Đến địa điểm" forState:UIControlStateNormal];
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        bgResultView.alpha=0.7f;
        scanCodeView.alpha=0;
        contentView.alpha=1;
        btnCloseCamera.alpha=0;
        lblTorch.alpha=0;
        btnTorch.alpha=0;
    } completion:^(BOOL finished) {
        btnCloseCamera.hidden=true;
        btnTorch.hidden=true;
        lblTorch.hidden=true;
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
    _result=nil;
    
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

- (IBAction)btnMakeQRCodeTouchUpInside:(id) sender
{
    UIButton *btn=sender;
    
    btn.tag=RANDOM(0, 5);
    btn.tag=5;
    
    if(btn.tag==0)
        [self processCode:[QRCODE_INFORY_CODE stringByAppendingPathComponent:@"123829038120"]];
    else if(btn.tag==1)
        [self processCode:[QRCODE_INFORY_PLACELIST stringByAppendingPathComponent:@"1"]];
    else if(btn.tag==2)
        [self processCode:[QRCODE_INFORY_SHOP stringByAppendingPathComponent:@"1"]];
    else if(btn.tag==3)
        [self processCode:[QRCODE_INFORY_BRANCH stringByAppendingPathComponent:@"1"]];
    else if(btn.tag==4)
        [self processCode:[QRCODE_INFORY_SHOPS stringByAppendingPathComponent:@"?id=1,2,3,4,5,6"]];
    else if(btn.tag==5)
        [self processCode:@"https://infory.vn"];
    
    btn.tag++;
    
    if(btn.tag>=5)
        btn.tag=0;
    
    return;
    
    
    if(btn.tag==0)
    {
        ScanQRCodeResult0 *result=[ScanQRCodeResult0 new];
        result.message=@"Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat";
        
        [self displayResult:result];
    }
    else if(btn.tag==1)
    {
        NSString *str=@"Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat";
        
        ScanQRCodeResult1 *result=[ScanQRCodeResult1 new];
        result.message=str;
        result.idShop=25;
        result.shopName=@"Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat";
        
        [self displayResult:result];
    }
    else if(btn.tag==2)
    {
        ScanQRCodeResult2 *result=[ScanQRCodeResult2 new];
        result.message=@"Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat";
        result.idShop=25;
        result.shopName=@"Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat";
        result.sgp=@"⁺5000";
        result.totalSGP=@"1.000";
        
        [self displayResult:result];
    }
    else if(btn.tag==3)
    {
        
        ScanQRCodeResult3 *result=[ScanQRCodeResult3 new];
        result.message=@"Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat";
        result.type=@"Loại A";
        result.giftName=@"Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat";
        result.sgp=@"⁻5";
        result.totalSGP=@"999.999";
        result.idShop=25;
        
        [self displayResult:result];
    }
    else if(btn.tag==4)
    {
        ScanQRCodeResult4 *result=[ScanQRCodeResult4 new];
        result.message=@"Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat";
        result.type=@"Loại B";
        result.voucherName=@"Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat";
        result.idShop=25;
        result.shopName=@"Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat";
        
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
    
    if([_result isKindOfClass:[ScanQRCodeResult0 class]] || [_result isKindOfClass:[ScanQRCodeResult1 class]])
        [self displayScan];
    else
    {
        [self closeOnCompleted:^{
            
            int idShop=0;
            
            if([_result isKindOfClass:[ScanQRCodeResult2 class]])
                idShop=[((ScanQRCodeResult2*)_result) idShop];
            else if([_result isKindOfClass:[ScanQRCodeResult3 class]])
                idShop=[((ScanQRCodeResult3*)_result) idShop];
            else if([_result isKindOfClass:[ScanQRCodeResult4 class]])
                idShop=[((ScanQRCodeResult4*)_result) idShop];
            
            if(idShop==0)
                return;
            
            [SGData shareInstance].fScreen=[QRCodeViewController screenCode];
            
            [[GUIManager shareInstance].rootViewController presentShopUserWithIDShop:idShop];
        }];
    }
}

- (IBAction)btnCloseCameraTouchUpInside:(id)sender {
    [self close];
}

+(NSString *)screenCode
{
    return SCREEN_CODE_SCAN_CODE;
}

-(void) close
{
    [self closeOnCompleted:nil];
}

-(void) closeOnCompleted:(void(^)()) completed
{
    __block void(^_completed)()=nil;
    
    if(completed)
        _completed=[completed copy];
    
    __block void(^_animationCompleted)()=^()
    {
        [SGData shareInstance].fScreen=[QRCodeViewController screenCode];
        [self.delegate qrcodeControllerFinished:self];
        
        if(_completed)
        {
            _completed();
            _completed=nil;
        }
        
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
static char SGQRControllerHandleObjectKey;

@implementation SGViewController(QRCode)

-(void)setQrController:(QRCodeViewController *)qrController_
{
    objc_setAssociatedObject(self, &SGQRControllerObjectKey, qrController_, OBJC_ASSOCIATION_ASSIGN);
}

-(QRCodeViewController *)qrController
{
    return objc_getAssociatedObject(self, &SGQRControllerObjectKey);
}

-(void)setQrCodeControllerHandle:(SGViewController<QRCodeControllerDelegate> *)qrCodeControllerHandle_
{
    objc_setAssociatedObject(self, &SGQRControllerHandleObjectKey, qrCodeControllerHandle_, OBJC_ASSOCIATION_ASSIGN);
}

-(SGViewController<QRCodeControllerDelegate> *)qrCodeControllerHandle
{
    return objc_getAssociatedObject(self, &SGQRControllerHandleObjectKey);
}

-(void)showQRCodeWithController:(SGViewController<QRCodeControllerDelegate> *)controller inView:(UIView *)view withAnimationType:(enum QRCODE_ANIMATION_TYPE)animationType screenCode:(NSString *)screenCode
{
    if(self.qrCodeControllerHandle)
    {
        UIView *displayView=self.qrCodeControllerHandle.view;
        if([self.qrCodeControllerHandle respondsToSelector:@selector(qrCodeControllerDisplayView)])
            displayView=[self.qrCodeControllerHandle qrCodeControllerDisplayView];
        
        enum QRCODE_ANIMATION_TYPE qrCodeAnimationType=QRCODE_ANIMATION_TOP_BOT;
        
        if([self.qrCodeControllerHandle respondsToSelector:@selector(qrCodeAnimationType)])
            qrCodeAnimationType=[self.qrCodeControllerHandle qrCodeAnimationType];
            
        [self.qrCodeControllerHandle showQRCodeWithController:self.qrCodeControllerHandle inView:displayView withAnimationType:qrCodeAnimationType screenCode:@""];
        return;
    }
    
    QRCodeViewController *qr=[QRCodeViewController new];
    qr.delegate=controller;
    qr.containView=view;
    qr.animationType=animationType;
    [controller setQrController:qr];
    
    [controller addChildViewController:qr];
    
    [qr.view l_v_setH:view.l_v_h];
    [view addSubview:qr.view];
}

-(void)qrCodeController:(QRCodeViewController *)controller scannedIDBranch:(int)idBranch
{
    //un support
    [controller closeOnCompleted:nil];
}

-(void)qrCodeController:(QRCodeViewController *)controller scannedIDPlacelist:(int)idPlacelist
{
}

-(void)qrCodeController:(QRCodeViewController *)controller scannedIDShop:(int)idShop
{
    
}

-(void)qrCodeController:(QRCodeViewController *)controller scannedIDShops:(NSString *)idShops
{
    
}

-(void)qrCodeController:(QRCodeViewController *)controller scannedURL:(NSURL *)url
{
    
}

-(void)qrcodeControllerFinished:(QRCodeViewController *)controller
{
    self.qrController=nil;
}

@end

@implementation QRCodePattern

-(void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"pattern-navigation.jpg"] drawAsPatternInRect:rect];
}

@end