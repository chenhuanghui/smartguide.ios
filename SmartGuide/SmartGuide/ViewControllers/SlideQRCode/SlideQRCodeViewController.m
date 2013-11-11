//
//  SlideQRCodeViewController.m
//  SmartGuide
//
//  Created by XXX on 7/26/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SlideQRCodeViewController.h"
#import "Utility.h"
#import "ZBarReaderView.h"
#import "NSBKeyframeAnimation.h"
#import "ASIOperationGetSGP.h"
#import "ASIOperationGetRewardPromotionType2.h"
#import "RootViewController.h"
#import "ASIOperationSGPToReward.h"
#import "FrontViewController.h"
#import "ShopDetailViewController.h"
#import "LocationManager.h"
//#import <MultiFormatReader.h>
//#import <QRCodeReader.h>
//#import <DataMatrixReader.h>
#import "AlphaView.h"

@interface SlideQRCodeViewController ()
{
    QRCodeViewController *qrCodeView;
//    ZXingWidgetController *zxWidget;
}

@end

@implementation SlideQRCodeViewController
@synthesize qrCodes,qrCode,delegate,mode,idReward;

//-(void)zxingController:(ZXingWidgetController *)controller didScanResult:(NSString *)result
//{
//    controller.delegate=nil;
//    [self processResult:result];
//}

//-(void)zxingControllerDidCancel:(ZXingWidgetController *)controller
//{
//    
//}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UITextField *qr = [alertView textFieldAtIndex:0];
    
    [self processResult:qr.text];
}

-(void) addCamera
{
#if TARGET_IPHONE_SIMULATOR
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"QR Code" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    alert.alertViewStyle=UIAlertViewStylePlainTextInput;
    
    [alert show];
    return;
#endif
    
    if(self.mode==SCAN_GET_SGP)
        [lblSlide setText:@"<a>TÍCH ĐIỂM</a><text> - CỬA HÀNG SẼ CUNG CẤP THẺ CHO BẠN</text>"];
    else
        [lblSlide setText:@"<a>NHẬN QUÀ</a><text> - CỬA HÀNG SẼ CUNG CẤP THẺ CHO BẠN</text>"];
    
    if(qrCodeView)
    {
        [qrCodeView.readerView start];
        qrCodeView.view.hidden=false;
        
        CGRect rect=qrView.frame;
        rect.origin=CGPointZero;
        qrCodeView.view.frame=rect;
        
        UIImageView *imgv=[[UIImageView alloc] initWithFrame:rect];
        imgv.image=[UIImage imageNamed:@"scan.png"];
        imgv.contentMode=UIViewContentModeCenter;
        imgv.tag=112;
        
        [qrView addSubview:imgv];
        
        return;
    }
    
    qrView.backgroundColor=[UIColor clearColor];
    
    qrCodeView=[[QRCodeViewController alloc] init];
    qrCodeView.delegate=self;
    
    [self addChildViewController:qrCodeView];
    
    [qrView addSubview:qrCodeView.view];
    
    CGRect rect=qrView.frame;
    rect.origin=CGPointZero;
    qrCodeView.view.frame=rect;
    
    UIImageView *imgv=[[UIImageView alloc] initWithFrame:rect];
    imgv.image=[UIImage imageNamed:@"scan.png"];
    imgv.contentMode=UIViewContentModeCenter;
    imgv.tag=112;
    
    [qrView addSubview:imgv];
    
    qrCodeView.view.center=CGPointMake(qrView.frame.size.width/2, qrView.frame.size.height/2);
    
    [self resizeQRView:qrCodeView.view];
}

-(id)init
{
    self=[super initWithNibName:NIB_PHONE(@"SlideQRCodeViewController") bundle:nil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    qrView.layer.cornerRadius=12;
    qrView.layer.masksToBounds=true;
    
    idReward=-1;
    mode=SCAN_GET_SGP;
    self.qrCodes=[[NSMutableArray alloc] init];
    
    ray.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"ray_red.png"]];
    
    FTCoreTextStyle *style=[FTCoreTextStyle styleWithName:@"vuot"];
    
    style.textAlignment=FTCoreTextAlignementCenter;
    style.color=[UIColor whiteColor];
    style.font=[UIFont boldSystemFontOfSize:10];
    
    [lblSlide addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"a"];
    
    style.font=[UIFont boldSystemFontOfSize:10];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.color=[UIColor whiteColor];
    
    [lblSlide addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"text"];
    
    style.textAlignment=FTCoreTextAlignementCenter;
    style.color=[UIColor whiteColor];
    style.font=[UIFont systemFontOfSize:10];
    
    [lblSlide addStyle:style];
    
    [lblSlide setText:OBJ_IOS(@"<vuot>VUỐT LÊN ĐỂ NHẬN ĐIỂM</vuot>", @"<vuot>CHẠM VÀO ĐỂ NHẬN ĐIỂM</vuot>")];
    
    style=[FTCoreTextStyle styleWithName:@"cm"];
    
    style.font=[UIFont boldSystemFontOfSize:12];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.color=[UIColor color255WithRed:171 green:209 blue:245 alpha:255];
    
    [lblReward addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"bdnd"];
    
    style.font=[UIFont systemFontOfSize:12];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.color=[UIColor color255WithRed:171 green:209 blue:245 alpha:255];
    
    [lblReward addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"reward"];
    
    style.font=[UIFont boldSystemFontOfSize:12];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.color=[UIColor whiteColor];
    
    [lblReward addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"text"];
    
    style.font=[UIFont systemFontOfSize:12];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.color=[UIColor color255WithRed:171 green:209 blue:245 alpha:255];
    
    [lblReward addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"shop"];
    
    style.font=[UIFont boldSystemFontOfSize:12];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.color=[UIColor whiteColor];
    
    [lblReward addStyle:style];
    
    [self loopAnimation];
}

-(void) loopAnimation
{
    return;
    NSBKeyframeAnimation *keyAnim = [NSBKeyframeAnimation animationWithKeyPath:@"position.y" duration:DURATION_SHOW_CATALOGUE startValue:0 endValue:10 function:NSBKeyframeAnimationFunctionFloaing];
    [btnSlide.layer addAnimation:keyAnim forKey:@"position.y"];
    
    [self performSelector:@selector(loopAnimation) withObject:nil afterDelay:3];
}

- (void)viewDidUnload {
    btnSlide = nil;
    lblSlide = nil;
    qrView = nil;
    ray = nil;
    darkLayer = nil;
    rewardView = nil;
    imgvRewardIcon = nil;
    lblError = nil;
    btnClose = nil;
    btnCloseStartup = nil;
    lblReward = nil;
    [super viewDidUnload];
}

-(BOOL)canBecomeFirstResponder
{
    return true;
}

-(bool) isAllowLocation
{
    [[LocationManager shareInstance] checkLocationAuthorize];
    
    return [LocationManager shareInstance].isAllowLocation;
}

-(void) showCameraQRCode
{
    _isUserScanded=false;
    _isLoadingShopDetail=false;
    _isUserClickClose=false;
    
    btnCloseStartup.hidden=false;
    
    [UIView animateWithDuration:0.2f animations:^{
        CGPoint pnt=btnSlide.center;
        pnt.y=14+10;
        btnSlide.center=pnt;
        
        pnt=lblSlide.center;
        pnt.y=32.5f+10;
        lblSlide.center=pnt;
    } completion:^(BOOL finished) {
        [self addCamera];
        _isLoadedShopDetailSuccess=true;
    }];
    
    darkLayer.backgroundColor=[UIColor clearColor];
    rewardView.hidden=true;
}

-(void) getLocation
{
    [self showCameraQRCode];
    [[LocationManager shareInstance] getLocation:nil];
}

-(void)showCamera
{
    [self getLocation];
}

-(void) resizeQRView:(UIView*) vvv
{
    CGRect rect=vvv.frame;
    rect.size.height=qrView.frame.size.height;
    vvv.frame=rect;
    for(UIView *vv in vvv.subviews)
    {
        [self resizeQRView:vv];
    }
}

-(void)hideCamera
{
    _isUserScanded=false;
    self.idReward=-1;
    
    [UIView animateWithDuration:0.2f animations:^{
        CGPoint pnt=btnSlide.center;
        pnt.y=14;
        btnSlide.center=pnt;
        
        pnt=lblSlide.center;
        pnt.y=32.5f;
        lblSlide.center=pnt;
    } completion:^(BOOL finished) {
       [self removeCamera];
    }];
    
    [lblSlide setText:OBJ_IOS(@"<vuot>VUỐT LÊN ĐỂ NHẬN ĐIỂM</vuot>", @"<vuot>CHẠM VÀO ĐỂ NHẬN ĐIỂM</vuot>")];
    
    darkLayer.backgroundColor=[UIColor clearColor];
    rewardView.hidden=true;
    
    if(self.qrCodes.count>0)
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_SCANED_QR_CODE object:[NSArray arrayWithArray:self.qrCodes]];
    else
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_CANCELED_SCAN_QR_CODE object:nil];
    
    self.qrCodes=[NSMutableArray array];
}

-(void) removeCamera
{
    [qrCodeView.readerView stop];
    [qrCodeView.readerView flushCache];
    qrCodeView.view.hidden=true;

    while ([qrView viewWithTag:112]) {
        [[qrView viewWithTag:112] removeFromSuperview];
    }
}

+(CGSize)size
{
    return CGSizeMake(320, 39);
}

-(UIButton *)btnSlide
{
    return btnSlide;
}

-(FTCoreTextView *)lblSlide
{
    return lblSlide;
}

-(bool) validateQRCodeFormat:(NSString*) text
{
    if(text.length>0)
    {
        if([text isContainStrings:@"type",@"url",@"name",@"code",nil])
        {
            NSData *data=[text dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error=nil;
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments|NSJSONReadingMutableContainers error:&error];
            
            if(error)
                return false;
            
            if([dict isKindOfClass:[NSDictionary class]])
                return true;
        }
    }
    
    return false;
}

-(void) scanGetAwardPromotion1WithIDAward:(int) idAward
{
    self.idReward=idAward;
    [[RootViewController shareInstance] showQRSlide:true onCompleted:^(BOOL finished) {
        mode=SCAN_GET_AWARD_PROMOTION_1;
    }];
}

-(void) scanGetPromotion2WithIDAward:(int) idAward
{
    self.idReward=idAward;
    [[RootViewController shareInstance] showQRSlide:true onCompleted:^(BOOL finished) {
        mode=SCAN_GET_PROMOTION2;
    }];
}

-(void) processResult:(NSString*) text
{
//    if(![self validateQRCodeFormat:text])
//    {
//        [self removeCamera];
//        [AlertView showAlertOKWithTitle:nil withMessage:@"QRCode không hợp lệ" onOK:^{
//            [btnSlide sendActionsForControlEvents:UIControlEventTouchUpInside];
//        }];
//        return;
//    }
    
    if(![NSThread isMainThread])
    {
        [self performSelectorOnMainThread:@selector(processResult:) withObject:text waitUntilDone:true];
        return;
    }
    
    btnCloseStartup.hidden=true;
    
    _isSuccessed=false;
    _isUserScanded=true;
    
    //qrCodeView.delegate=nil;
    
    [self.view.window showLoadingWithTitle:nil];
    [UIView animateWithDuration:DURATION_SHOW_QRCODE_REWARD animations:^{
        darkLayer.backgroundColor=COLOR_BACKGROUND_APP_ALPHA(0.9);
    }];
    
    switch (mode) {
        case SCAN_GET_SGP:
            [self getSGPWithCode:text idShop:[Utility idShopFromQRCode:text]];
            break;
            
        case SCAN_GET_AWARD_PROMOTION_1:
            [self getPromotion1Reward:text idReward:self.idReward idShop:[Utility idShopFromQRCode:text]];
            break;
            
        case SCAN_GET_PROMOTION2:
            [self getPromotion2Reward:text idReward:self.idReward];
            break;
    }
    
    btnSlide.enabled=false;

}

-(void)qrCodeCaptureImage:(UIImage *)image text:(NSString *)text
{
    [self processResult:text];
}

-(void) getPromotion1Reward:(NSString*) code idReward:(int) _idReward idShop:(int) idShop
{
    int idUser=[DataManager shareInstance].currentUser.idUser.integerValue;
    ASIOperationSGPToReward *operation=[[ASIOperationSGPToReward alloc] initWithIDUser:idUser idRewward:_idReward code:code idShop:idShop];
    operation.delegatePost=self;
    
    [operation startAsynchronous];
}

-(void) getPromotion2Reward:(NSString*) code idReward:(int) _idReward
{
    int idUser=[DataManager shareInstance].currentUser.idUser.integerValue;
    double lat=[DataManager shareInstance].currentUser.location.latitude;
    double lon=[DataManager shareInstance].currentUser.location.longitude;
    
    ASIOperationGetRewardPromotionType2 *operation=[[ASIOperationGetRewardPromotionType2 alloc] initWithIDUser:idUser promotionID:_idReward code:code lat:lat lon:lon];
    operation.delegatePost=self;
    
    [operation startAsynchronous];
}

-(void) getSGPWithCode:(NSString*) code idShop:(int) idShop;
{
    int idUser=[DataManager shareInstance].currentUser.idUser.integerValue;
    double lat=[DataManager shareInstance].currentUser.location.latitude;
    double lon=[DataManager shareInstance].currentUser.location.longitude;
    ASIOperationGetSGP *operation=[[ASIOperationGetSGP alloc] initWithUserID:idUser code:code idShop:idShop lat:lat lon:lon];
    operation.delegatePost=self;
    
    [operation startAsynchronous];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    [self.view.window removeLoading];
    btnSlide.enabled=true;
    lblReward.hidden=true;
    lblError.hidden=true;
    
    imgvRewardIcon.hidden=false;
    rewardView.hidden=false;
    
    if([operation isKindOfClass:[ASIOperationGetSGP class]])
    {
        ASIOperationGetSGP *ope=(ASIOperationGetSGP*) operation;
        
        if(ope.status==3)
        {
            lblReward.hidden=false;
            imgvRewardIcon.highlighted=false;
            
            [self setReward1:[NSString stringWithFormat:@"%i",ope.SGP] name:ope.shopName];
            
            qrCode=[QRCode qrCodeWithCode:ope.code];
            qrCode.totalSGP=ope.totalSGP;
            qrCode.idShop=ope.idShop;
            
            [qrCodes addObject:qrCode];
            
            _isSuccessed=true;
        }
        else
        {
            lblError.hidden=false;
            lblError.text=ope.content;
            imgvRewardIcon.highlighted=true;
        }
        
        rewardView.hidden=false;
    }
    else if([operation isKindOfClass:[ASIOperationGetRewardPromotionType2 class]])
    {
        ASIOperationGetRewardPromotionType2 *ope=(ASIOperationGetRewardPromotionType2*) operation;
        
        if(ope.status==1)
        {
            lblReward.hidden=false;
            imgvRewardIcon.highlighted=false;
            
            NSNumberFormatter *moneyFormat=[[NSNumberFormatter alloc] init];
            [moneyFormat setNumberStyle:NSNumberFormatterCurrencyStyle];
            [moneyFormat setMinimumFractionDigits:0];
            [moneyFormat setMaximumFractionDigits:0];
            moneyFormat.currencySymbol=@"";
            
            [self setReward2:[NSString stringWithFormat:@"%@ vnđ",[moneyFormat stringFromNumber:@(ope.money)]] name:ope.shopName];
            
            qrCode=[QRCode qrCodeWithCode:ope.code];
            qrCode.idShop=ope.idShop;
            [self.qrCodes addObject:qrCode];
            
            _isSuccessed=true;
        }
        else
        {
            lblError.hidden=false;
            lblError.text=ope.content;
            imgvRewardIcon.highlighted=true;
        }
        
        rewardView.hidden=false;
    }
    else if([operation isKindOfClass:[ASIOperationSGPToReward class]])
    {
        ASIOperationSGPToReward *ope=(ASIOperationSGPToReward*) operation;
        
        if(ope.status==2)
        {
            lblReward.hidden=false;
            imgvRewardIcon.highlighted=false;
            
            [self setReward2:ope.award name:ope.shopName];
            
            qrCode=[QRCode qrCodeWithCode:ope.code];
            qrCode.totalSGP=ope.totalSGP;
            qrCode.idShop=ope.idShop;
            
            [self.qrCodes addObject:qrCode];
            
            _isSuccessed=true;
        }
        else
        {
            lblError.hidden=false;
            lblError.text=ope.content;
            imgvRewardIcon.highlighted=true;
        }
    }
    
    if(qrCode.idShop<=0)
        qrCode.idShop=[Utility idShopFromQRCode:qrCode.code];
    
    if(_isSuccessed)
        [self requestShopDetailWithIDShop:qrCode.idShop];
}

-(void) requestShopDetailWithIDShop:(int) idShop
{
    _isLoadingShopDetail=true;
    _isLoadedShopDetailSuccess=true;
    
    if(idShop<=0)
    {
        [self.view.window removeLoading];
        _isLoadingShopDetail=false;
        _isLoadedShopDetailSuccess=false;
        
        [self showShopDetail];
    }
    
    __block __weak id obs = [[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_SHOPDETAIL_LOAD_FINISHED object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        
        [self.view.window removeLoading];
        _isLoadingShopDetail=false;
        _isLoadedShopDetailSuccess=[note.object boolValue];
        
        [self showShopDetail];
        
        [[NSNotificationCenter defaultCenter] removeObserver:obs];
    }];
    
    [[RootViewController shareInstance].shopDetail loadWithIDShop:idShop];
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    [self.view.window removeLoading];
    
    lblReward.hidden=true;
    lblError.hidden=true;
    imgvRewardIcon.hidden=false;
    
    lblError.hidden=false;
    lblError.text=@"Lỗi đã xảy ra";
    imgvRewardIcon.highlighted=true;
    rewardView.hidden=false;
}

-(void) hideMe
{
    btnSlide.enabled=false;
    [[RootViewController shareInstance] hideQRSlide:true onCompleted:^(BOOL finished) {
        btnSlide.enabled=true;
    }];
}

- (IBAction)btnSlideTouchUpInside:(UIButton *)sender
{
    if(_isUserScanded)
        return;
    
    btnSlide.enabled=false;
    
    if([[RootViewController shareInstance] isShowedQRSlide])
    {
        [[RootViewController shareInstance] hideQRSlide:true onCompleted:^(BOOL finished) {
            btnSlide.enabled=true;
        }];
    }
    else
    {
        [[RootViewController shareInstance] showQRSlide:true onCompleted:^(BOOL finished) {
            btnSlide.enabled=true;
        }];
    }
}

- (IBAction)btnCloseTouchUpInside:(UIButton *)sender {
    if([[RootViewController shareInstance] isShowedQRSlide])
    {
        if(!_isSuccessed)
        {
            [[RootViewController shareInstance] hideQRSlide:true onCompleted:^(BOOL finished) {
                btnSlide.enabled=true;
            }];
            
            return;
        }
        
        if(_isLoadingShopDetail)
        {
            [self.view.window showLoadingWithTitle:nil];
            return;
        }
        else
        {
            _isUserClickClose=true;
            [self showShopDetail];
            return;
        }
    }
}

-(bool)isUserScanded
{
    return _isUserScanded;
}

-(void) showShopDetail
{
    if(_isUserClickClose)
    {
        //user clicked close va load shop detail error->close slide qr
        if(!_isLoadingShopDetail && !_isLoadedShopDetailSuccess)
        {
            btnClose.userInteractionEnabled=false;
            
            [[RootViewController shareInstance] hideQRSlide:true onCompleted:^(BOOL finished) {
                btnClose.userInteractionEnabled=true;
                btnSlide.enabled=true;
            }];
            
            return;
        }
    }
    
    if(_isLoadingShopDetail || !_isUserClickClose)
        return;
    
    if(!_isLoadedShopDetailSuccess)
    {
        btnClose.userInteractionEnabled=false;
        
        [[RootViewController shareInstance] hideQRSlide:true onCompleted:^(BOOL finished) {
            btnClose.userInteractionEnabled=true;
            btnSlide.enabled=true;
        }];

        return;
    }
    
    btnClose.userInteractionEnabled=false;
    if([[[RootViewController shareInstance].frontViewController currentVisibleViewController] isKindOfClass:[ShopDetailViewController class]])
    {
        [[RootViewController shareInstance] hideQRSlide:true onCompleted:^(BOOL finished) {
            btnSlide.enabled=true;
            
            btnClose.userInteractionEnabled=true;
        }];
    }
    else if([RootViewController shareInstance].isShowedMap)
    {
        [[RootViewController shareInstance] showShopDetailFromMap];
        
        double delayInSeconds = 0.5f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self.view.window removeLoading];
            [[RootViewController shareInstance] hideQRSlide:true onCompleted:^(BOOL finished) {
                btnSlide.enabled=true;
                
                btnClose.userInteractionEnabled=true;
            }];
        });
    }
    else if([RootViewController shareInstance].isShowedUserCollection)
    {
        [[RootViewController shareInstance] showShopDetailFromUserCollection];
        
        double delayInSeconds = 0.5f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self.view.window removeLoading];
            [[RootViewController shareInstance] hideQRSlide:true onCompleted:^(BOOL finished) {
                btnSlide.enabled=true;
                
                btnClose.userInteractionEnabled=true;
            }];
        });
    }
    else if([RootViewController shareInstance].frontViewController.isShowedCatalogueBlock)
    {
        [[RootViewController shareInstance].frontViewController hideCatalogueBlock:false];
        [[RootViewController shareInstance].frontViewController.catalogueList showShopDetail];
        
        double delayInSeconds = 0.5f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self.view.window removeLoading];
            [[RootViewController shareInstance] hideQRSlide:true onCompleted:^(BOOL finished) {
                btnSlide.enabled=true;
                
                btnClose.userInteractionEnabled=true;
            }];
        });
    }
    else if([[[RootViewController shareInstance].frontViewController currentVisibleViewController] isKindOfClass:[CatalogueListViewController class]])
    {
        [[RootViewController shareInstance].frontViewController.catalogueList showShopDetail];
        
        [self.view.window removeLoading];
        [[RootViewController shareInstance] hideQRSlide:true onCompleted:^(BOOL finished) {
            btnSlide.enabled=true;
            
            btnClose.userInteractionEnabled=true;
        }];
    }
}

- (IBAction)btnCloseStartupTouchUpInside:(id)sender {
    [[RootViewController shareInstance] hideQRSlide:true onCompleted:^(BOOL finished) {
        btnSlide.enabled=true;
    }];
}

-(void) setReward1:(NSString*) sgp name:(NSString*) name
{
    [lblReward setText:[NSString stringWithFormat:@"<cm>Chúc mừng</cm><bdnd>\nbạn đã nhận được</bdnd><reward>\n\n%@ SGP</reward><text>\n\ntại cửa hàng </text><shop>%@</shop>",sgp,name]];
}

-(void) setReward2:(NSString*) reward name:(NSString*) name
{
    [lblReward setText:[NSString stringWithFormat:@"<cm>Chúc mừng</cm><bdnd>\nbạn đã nhận được</bdnd><reward>\n\n%@</reward><text>\n\ntại cửa hàng </text><shop>%@</shop>",reward,name]];
}

@end

@implementation SlideQRView

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

-(void)setCenter:(CGPoint)center
{
    [super setCenter:center];
}

@end

@implementation QRCode
@synthesize code,name,type,url,idShop,totalSGP,sourceCode;

+(QRCode *)qrCodeWithCode:(NSString *)code
{
    NSData *data=[code dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments|NSJSONReadingMutableContainers error:nil];
    
    QRCode *qrCode=[[QRCode alloc] init];
    
    qrCode.type=[dict integerForKey:@"type"];
    qrCode.url=[NSString stringWithStringDefault:[dict objectForKey:@"url"]];
    qrCode.name=[NSString stringWithStringDefault:[dict objectForKey:@"name"]];
    qrCode.code=[NSString stringWithStringDefault:[dict objectForKey:@"code"]];
    qrCode.sourceCode=[NSString stringWithStringDefault:code];
    qrCode.idShop=[Utility idShopFromQRCode:qrCode.url];
    
    return qrCode;
}

@end