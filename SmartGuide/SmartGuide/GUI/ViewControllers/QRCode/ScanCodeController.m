//
//  ScanCodeController.m
//  Infory
//
//  Created by XXX on 6/30/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanCodeController.h"
#import "ScanCodeViewController.h"
#import "SGNavigationController.h"
#import "ScanResultViewController.h"

@interface ScanCodeController ()<ScanCodeViewControllerDelegate, ScanResultControllerDelegate>

@end

@implementation ScanCodeController

- (instancetype)init
{
    self = [super initWithNibName:@"ScanCodeController" bundle:nil];
    if (self) {
        
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    
    _navi=[[SGNavigationController alloc] initWithRootViewController:[self scanCodeViewController]];
}

-(ScanCodeViewController*) scanCodeViewController
{
    ScanCodeViewController *vc=[ScanCodeViewController new];
    vc.delegate=self;
    
    return vc;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_navi.view l_v_setS:contentView.l_v_s];
    [contentView addSubview:_navi.view];
    
    imgvScanTop.transform=CGAffineTransformMakeScale(1, -1);
}

-(void)viewWillAppearOnce
{
    switch (self.scanAnimationType) {
        case QRCODE_ANIMATION_TOP_BOT:
        {
            [topView l_v_addY:-topView.l_v_h];
            [botView l_v_addY:botView.l_v_h];
            self.view.alpha=0;
            
            [UIView animateWithDuration:DURATION_DEFAULT animations:^{
                [topView l_v_addY:topView.l_v_h];
                [botView l_v_addY:-botView.l_v_h];
                self.view.alpha=1;
            }];
        }
            break;
            
        case QRCODE_ANIMATION_TOP:
        {
            [topView l_v_addY:-topView.l_v_h];
            self.view.alpha=0;
            
            [UIView animateWithDuration:DURATION_DEFAULT animations:^{
                [topView l_v_addY:imgvScanTop.l_v_h];
                self.view.alpha=1;
            }];
        }
            break;
    }
}

-(void)dealloc
{
    _navi=nil;
}

-(IBAction)btnCloseTouchUpInside:(id)sender
{
    [self.delegate scanCodeControllerTouchedClose:self];
}

-(void)closeScanOnCompleted:(void (^)())completed
{
    __block void(^_animationCompleted)()=^{
        if(completed)
            completed();
    };
    
    switch (self.scanAnimationType) {
        case QRCODE_ANIMATION_TOP_BOT:
        {
            [UIView animateWithDuration:DURATION_DEFAULT animations:^{
                [topView l_v_addY:-topView.l_v_h];
                [botView l_v_addY:botView.l_v_h];
            } completion:^(BOOL finished) {
                _animationCompleted();
                _animationCompleted=nil;
            }];
        }
            break;
            
        case QRCODE_ANIMATION_TOP:
        {
            [UIView animateWithDuration:DURATION_DEFAULT animations:^{
                [topView l_v_addY:-topView.l_v_h];
            } completion:^(BOOL finished) {
                _animationCompleted();
                _animationCompleted=nil;
            }];
        }
            break;
    }
}

-(void) animationShowScan
{
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        [topView l_v_setY:0];
        [botView l_v_setY:self.l_v_h-botView.l_v_h];
        self.view.alpha=1;
    }];
}

-(void) animationHideScan
{
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        [topView l_v_setY:-topView.l_v_h];
        [botView l_v_setY:self.l_v_h+botView.l_v_h];
    } completion:^(BOOL finished) {
    }];
}

-(void)scanCodeViewController:(ScanCodeViewController *)controller scannedText:(NSString *)text
{
    if([text containsString:QRCODE_DOMAIN_INFORY])
    {
        NSURL *url=[NSURL URLWithString:text];
        if([text containsString:QRCODE_INFORY_SHOPS])
        {
            NSString *idShops=[url query];
            if(idShops.length>0)
            {
                NSArray *array=[idShops componentsSeparatedByString:@"="];
                if(array.count>1)
                {
                    idShops=array[1];
                    
                    ScanObject *obj=[ScanObject new];
                    obj.idShops=idShops;
                    obj.type=@(SCAN_OBJECT_TYPE_IDSHOPS);
                    [self.delegate scanCodeController:self scannedObject:obj];
                    return;
                }
            }
            
            [self showScanCodeResultWithCode:text];
        }
        else if([text containsString:QRCODE_INFORY_SHOP])
        {
            int idShop=[[url lastPathComponent] integerValue];
            
            ScanObject *obj=[ScanObject new];
            obj.type=@(SCAN_OBJECT_TYPE_IDSHOP);
            obj.idShop=@(idShop);
            [self.delegate scanCodeController:self scannedObject:obj];
        }
        else if([text containsString:QRCODE_INFORY_PLACELIST])
        {
            int idPlacelist=[[url lastPathComponent] integerValue];
            
            ScanObject *obj=[ScanObject new];
            obj.type=@(SCAN_OBJECT_TYPE_IDPLACELIST);
            obj.idPlacelist=@(idPlacelist);
            [self.delegate scanCodeController:self scannedObject:obj];
        }
        else if([text containsString:QRCODE_INFORY_CODE])
        {
            NSString *hash=[url lastPathComponent];
            
            [self showScanCodeResultWithCode:hash];
        }
        else if([text containsString:QRCODE_INFORY_BRANCH])
        {
            int idBranch=[[url lastPathComponent] integerValue];
            
            ScanObject *obj=[ScanObject new];
            obj.type=@(SCAN_OBJECT_TYPE_IDBRANCH);
            obj.idBranch=@(idBranch);
            [self.delegate scanCodeController:self scannedObject:obj];
        }
        else
        {
            [self showScanCodeResultWithCode:text];
        }
    }
    else
    {
        NSDataDetector *dataDetector=[NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
        
        if([dataDetector numberOfMatchesInString:text options:0 range:NSMakeRange(0, text.length)]!=0)
        {
            ScanObject *obj=[ScanObject new];
            obj.type=@(SCAN_OBJECT_TYPE_URL);
            obj.url=URL(text);
            
            [self.delegate scanCodeController:self scannedObject:obj];
        }
        else
        {
            [self showScanCodeResultWithCode:text];
        }
    }
}

-(void) showScanCodeResultWithCode:(NSString*) code
{
    [self animationHideScan];
    
    ScanResultViewController *vc=[[ScanResultViewController alloc] initWithCode:code];
    vc.delegate=self;
    
    [_navi pushViewController:vc animated:true];
}

-(void)scanResultControllerTouchedBack:(ScanResultViewController *)controller
{
    [_navi popViewControllerAnimated:true];
    [self animationShowScan];
}

-(void)scanResultController:(ScanResultViewController *)controller touchedObject:(ScanResult *)object
{
    
}

@end

@implementation UIViewController(ScanCode)

-(void)showScanCodeWithDelegate:(id<ScanCodeControllerDelegate>)delegate
{
    ScanCodeController *vc=[ScanCodeController new];
    vc.delegate=delegate;
    
    [self showDialogController:vc withAnimation:self.dialogControllerDefaultAnimationShow onCompleted:nil];
}

-(void)showScanCodeWithDelegate:(id<ScanCodeControllerDelegate>)delegate animationType:(enum SCANCODE_ANIMATION_TYPE)animationType
{
    ScanCodeController *vc=[ScanCodeController new];
    vc.delegate=delegate;
    vc.scanAnimationType=animationType;
    
    [self showDialogController:vc withAnimation:self.dialogControllerDefaultAnimationShow onCompleted:nil];
}

-(void)closeScanCode
{
    if(self.dialogController && [self.dialogController isKindOfClass:[ScanCodeController class]])
    {
        ScanCodeController *vc=(ScanCodeController*)self.dialogController;
        
        [vc closeScanOnCompleted:nil];
        [self closeDialogControllerWithAnimation:self.dialogControllerDefaultAnimationClose onCompleted:nil];
    }
}

@end

@implementation ScanObject

-(enum SCAN_OBJECT_TYPE)enumType
{
    switch ((enum SCAN_OBJECT_TYPE)self.type.integerValue) {
        case SCAN_OBJECT_TYPE_IDBRANCH:
            return SCAN_OBJECT_TYPE_IDBRANCH;
            
        case SCAN_OBJECT_TYPE_IDPLACELIST:
            return SCAN_OBJECT_TYPE_IDPLACELIST;
            
        case SCAN_OBJECT_TYPE_IDSHOP:
            return SCAN_OBJECT_TYPE_IDSHOP;
            
        case SCAN_OBJECT_TYPE_IDSHOPS:
            return SCAN_OBJECT_TYPE_IDSHOPS;
            
        case SCAN_OBJECT_TYPE_URL:
            return SCAN_OBJECT_TYPE_URL;
            
        case SCAN_OBJECT_TYPE_TEXT:
            return SCAN_OBJECT_TYPE_TEXT;
    }
    
    return SCAN_OBJECT_TYPE_URL;
}

@end