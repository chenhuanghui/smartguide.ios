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
#import "UserNotificationAction.h"
#import "OperationNotificationAction.h"
#import "WebViewController.h"
#import "UserSettingViewController.h"
#import "ShopUserViewController.h"
#import "SearchShopViewController.h"
#import "ShopUserController.h"
#import "UserPromotionViewController.h"
#import "GUIManager.h"
#import "ScanCodeRelated.h"
#import "ScanResultRelatedViewController.h"

@interface ScanCodeController ()<ScanCodeViewControllerDelegate, ScanResultControllerDelegate,SGUserSettingControllerDelegate,WebViewDelegate,ShopUserControllerDelegate,SGNavigationControllerDelegate, ScanResultRelatedControllerDelegate>

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
    
    _navi.navigationDelegate=self;
    [_navi.view l_v_setS:contentView.l_v_s];
    [contentView addSubview:_navi.view];
    
    imgvScanTop.transform=CGAffineTransformMakeScale(1, -1);
}

-(void)viewWillAppearOnce
{
    switch (self.scanAnimationType) {
        case SCANCODE_ANIMATION_TOP_BOT:
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
            
        case SCANCODE_ANIMATION_TOP:
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
        case SCANCODE_ANIMATION_TOP_BOT:
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
            
        case SCANCODE_ANIMATION_TOP:
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

-(void)scanCodeViewController:(ScanCodeViewController *)controller scannedText:(NSString *)text codeType:(enum SCANCODE_CODE_TYPE)codeType
{
    if(codeType==SCANCODE_CODE_TYPE_BARCODE)
    {
        NSString *url=[NSString stringWithFormat:@"http://shp.li/barcode/ean_13/%@/?t=v&partner=scan",text];
        [self.delegate scanCodeController:self scannedURL:URL(url)];
        return;
    }
    
    if([text containsString:@"?infory=true"]
       || [text containsString:@"&infory=true"])
    {
        [self showScanCodeResultWithCode:text];
    }
    else if([text startsWithStrings:
             [@"http://" stringByAppendingString:QRCODE_DOMAIN_INFORY]
             , [@"www." stringByAppendingString:QRCODE_DOMAIN_INFORY]
             , QRCODE_DOMAIN_INFORY
             , nil])
    {
        NSURL *url=[NSURL URLWithString:text];
        if([text containsString:QRCODE_INFORY_SHOPS])
        {
            NSString *idShops=[[[url query] componentsSeparatedByString:@"&"] firstObject];
            if(idShops.length>0)
            {
                NSArray *array=[idShops componentsSeparatedByString:@"="];
                if(array.count>1)
                {
                    idShops=array[1];
                    
                    [self animationHideScan];
                    [self showShopListWithIDShops:idShops];
                    return;
                }
            }
            
            [self showScanCodeResultWithCode:text];
        }
        else if([text containsString:QRCODE_INFORY_SHOP])
        {
            int idShop=[[url lastPathComponent] integerValue];
            
            [self animationHideScan];
            [self presentShopUserWithIDShop:idShop];
        }
        else if([text containsString:QRCODE_INFORY_PLACELIST])
        {
            int idPlacelist=[[url lastPathComponent] integerValue];
            
            [self animationHideScan];
            [self showShopListWithIDPlace:idPlacelist];
        }
        else if([text containsString:QRCODE_INFORY_CODE])
        {
            NSString *hash=[url lastPathComponent];
            
            [self animationHideScan];
            [self showScanCodeResultWithCode:hash];
        }
        else if([text containsString:QRCODE_INFORY_BRANCH])
        {
            int idBranch=[[url lastPathComponent] integerValue];
            
            [self animationHideScan];
            [self showShopListWithIDBranch:idBranch];
        }
        else
        {
            [self animationHideScan];
            [self showScanCodeResultWithCode:text];
        }
    }
    else
    {
        if([text startsWithStrings:@"http://", @"https://", @"www.", nil])
        {
            if([text startsWith:@"www."])
                text=[@"http://" stringByAppendingString:text];
            
            [self.delegate scanCodeController:self scannedURL:URL(text)];
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
    [self.delegate scanCodeControllerTouchedClose:self];
}

-(void)scanResultController:(ScanResultViewController *)controller touchedRelated:(ScanCodeRelated *)related
{
    [self showScanCodeRelated:related];
}

-(void) showScanCodeRelated:(ScanCodeRelated*) related
{
    switch (related.enumType) {
        case SCANCODE_RELATED_TYPE_PLACELISTS:
            [self showShopListWithIDPlace:related.idPlacelist.integerValue];
            break;
            
        case SCANCODE_RELATED_TYPE_PROMOTIONS:
            [self showShopListWithIDShops:related.idShops];
            break;
            
        case SCANCODE_RELATED_TYPE_SHOPS:
            [self presentShopUserWithIDShop:related.idShop.integerValue];
            break;
            
        case SCANCODE_RELATED_TYPE_UNKNOW:
            break;
    }
}

-(void)scanResultController:(ScanResultViewController *)controller touchedAction:(UserNotificationAction *)action
{
    switch (action.enumActionType) {
        case NOTIFICATION_ACTION_TYPE_CALL_API:
        {
            [[OperationNotificationAction operationWithURL:action.url method:action.methodName params:action.params] addToQueue];
        }
            break;
            
        case NOTIFICATION_ACTION_TYPE_POPUP_URL:
            
            [self showWebViewWithURL:URL(action.url) onCompleted:nil];
            
            break;
            
        case NOTIFICATION_ACTION_TYPE_SHOP_LIST:
            
            switch (action.enumShopListDataType) {
                case NOTIFICATION_ACTION_SHOP_LIST_TYPE_IDPLACELIST:
                    [self showShopListWithIDPlace:action.idPlacelist.integerValue];
                    break;
                    
                case NOTIFICATION_ACTION_SHOP_LIST_TYPE_KEYWORDS:
                    [self showShopListWithKeywordsShopList:action.keywords];
                    break;
                    
                case NOTIFICATION_ACTION_SHOP_LIST_TYPE_IDSHOPS:
                    [self showShopListWithIDShops:action.idShops];
                    break;
            }
            
            break;
            
        case NOTIFICATION_ACTION_TYPE_SHOP_USER:
            [self presentShopUserWithIDShop:action.idShop.integerValue];
            break;
            
        case NOTIFICATION_ACTION_TYPE_USER_PROMOTION:
            [self showUserPromotion];
            break;
            
        case NOTIFICATION_ACTION_TYPE_USER_SETTING:
            [self showUserSetting];
            break;
            
        case NOTIFICATION_ACTION_TYPE_UNKNOW:
            break;
    }
}

-(void)scanResultController:(ScanResultViewController *)controller touchedMore:(ScanCodeRelatedContain *)object
{
    ScanResultRelatedViewController *vc=[[ScanResultRelatedViewController alloc] initWithRelatedContain:object];
    vc.delegate=self;
    
    [_navi pushViewController:vc animated:true];
}

-(void)scanResultRelatedControllerTouchedBack:(ScanResultRelatedViewController *)controller
{
    [_navi popViewControllerAnimated:true];
}

-(void)scanResultRelatedController:(ScanResultRelatedViewController *)controller touchedRelatedObject:(ScanCodeRelated *)obj
{
    [self showScanCodeRelated:obj];
}

-(void) showUserPromotion
{
}

-(void) presentShopUserWithIDShop:(int) idShop
{
    ShopUserController *vc=[[ShopUserController alloc] initWithIDShop:idShop];
    vc.delegate=self;
    
    [_navi pushViewController:vc animated:true];
}

-(void)shopUserControllerTouchedClose:(ShopUserController *)controller
{
    [_navi popViewControllerAnimated:true];
}

-(void)shopUserControllerTouchedScanQRCode:(ShopUserController *)controller
{
    [_navi popToRootViewControllerAnimated:true];
}

-(void) showUserSetting
{
    if(currentUser().enumDataMode==USER_DATA_TRY)
    {
        [[GUIManager shareInstance] showLoginDialogWithMessage:localizeLoginRequire() onOK:nil onCancelled:nil onLogined:^(bool isLogined) {
            if(isLogined)
                [self showUserSetting];
        }];
        return;
    }
    
    [_navi pushViewController:[self userSettingController] animated:true];
}

-(UserSettingViewController*) userSettingController
{
    UserSettingViewController *vc=[UserSettingViewController new];
    vc.delegate=self;
    
    return vc;
}

-(void)userSettingControllerFinished:(UserSettingViewController *)controller
{
    [_navi popViewControllerAnimated:true];
}

-(void)userSettingControllerTouchedBack:(UserSettingViewController *)controller
{
    [_navi popViewControllerAnimated:true];
}

-(void) showShopListWithKeywordsShopList:(NSString*) keywords
{
    SearchViewController *vc=[[SearchViewController alloc] initWithKeywordShopList:keywords];
    [self showSearchController:vc];
}

-(void)showShopListWithIDPlace:(int)idPlacelist
{
    SearchViewController *vc=[[SearchViewController alloc] initWithIDPlace:idPlacelist];
    [self showSearchController:vc];
}

-(void)showShopListWithIDShops:(NSString *)idShops
{
    SearchViewController *vc=[[SearchViewController alloc] initWithIDShops:idShops];
    [self showSearchController:vc];
}

-(void)showShopListWithIDBranch:(int)idBranch
{
    SearchViewController *vc=[[SearchViewController alloc] initWithIDBranch:idBranch];
    [self showSearchController:vc];
}

-(void) showSearchController:(SearchViewController*) controller
{
    controller.delegate=self;
    
    [_navi pushViewController:controller animated:true];
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if([viewController isKindOfClass:[ScanCodeViewController class]])
    {
        [self animationShowScan];
    }
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

-(void) scanCodeControllerTouchedClose:(ScanCodeController*) controller
{
    [self closeScanCode];
}

-(void) scanCodeController:(ScanCodeController*) controller scannedURL:(NSURL*) url
{
    [self showWebViewWithURL:url onCompleted:^(WebViewController *webviewController) {
        [self closeScanCode];
    }];
}

@end