//
//  SlideQRCodeViewController.m
//  SmartGuide
//
//  Created by XXX on 7/26/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SlideQRCodeViewController.h"
#import "Utility.h"
#import "QRCodeViewController.h"
#import "ZBarReaderView.h"
#import "NSBKeyframeAnimation.h"
#import "ASIOperationGetSGP.h"
#import "ASIOperationGetRewardPromotionType2.h"
#import "RootViewController.h"
#import "ASIOperationSGPToReward.h"
#import "FrontViewController.h"
#import "CatalogueListViewController.h"
#import "ShopDetailViewController.h"
#import "LocationManager.h"

@interface SlideQRCodeViewController ()
{
    QRCodeViewController *qrCodeView;
}

@end

@implementation SlideQRCodeViewController
@synthesize qrCodes,qrCode,delegate,mode,idReward;

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
    
    [lblSlide setText:@"<vuot>VUỐT LÊN ĐỂ NHẬN ĐIỂM</vuot>"];
    
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
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidBecomeActiveNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
       if(alertLocation)
       {
           [alertLocation dismissWithClickedButtonIndex:-1 animated:false];
           alertLocation=nil;
           
           [self showCamera];
       }
        else
        {
            if([RootViewController shareInstance].isShowedQRSlide)
            {
                if(![self isAllowLocation])
                {
                    [self removeCamera];
                    
                    [self showCamera];
                }
            }
        }
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
    imgvScan = nil;
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
    mode=SCAN_GET_SGP;
    
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
    }];
    
    darkLayer.backgroundColor=[UIColor clearColor];
    rewardView.hidden=true;
    imgvScan.hidden=false;
}

-(void) getLocation
{
    [self.view.window showLoadingWithTitle:nil];
    [[LocationManager shareInstance] getLocation:^(CLLocationCoordinate2D location) {
        
        [self.view.window removeLoading];
        
        if(isVailCLLocationCoordinate2D(location))
        {
            [self showCameraQRCode];
        }
        else
        {
            _isAlertGetLocation=true;
            alertLocation=[[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Lấy thông tin vị trí thất bại. Bạn có muốn thử lại?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles:@"Đóng", nil];
            [alertLocation show];
        }
    }];
}

-(void)showCamera
{
    _isAlertGetLocation=false;
    if([self isAllowLocation])
    {
        [self getLocation];
    }
    else
    {
        alertLocation=nil;
        
        alertLocation=[[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Hãy cho phép ứng dụng kết nối với Location Services ở mục Setting/Privacy để có thể tích điểm với SmartGuide" delegate:self cancelButtonTitle:@"Đóng" otherButtonTitles:nil];
        
        [alertLocation show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(!_isAlertGetLocation && buttonIndex==0)
    {
        [self hideMe];
        return;
    }
    
    if(buttonIndex==1)
    {
        [self hideMe];
    }
    else
    {
        [self showCamera];
    }
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
    }];
    
    [self removeCamera];
    
    [lblSlide setText:@"<vuot>VUỐT LÊN ĐỂ NHẬN ĐIỂM</vuot>"];
    
    darkLayer.backgroundColor=[UIColor clearColor];
    rewardView.hidden=true;

    if(self.qrCodes.count>0)
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_SCANED_QR_CODE object:[NSArray arrayWithArray:self.qrCodes]];
    else
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_CANCELED_SCAN_QR_CODE object:nil];
    
    self.qrCodes=[NSMutableArray array];
}

-(void) addCamera
{
    if(qrCodeView)
    {
        return;
    }
    
    qrCodeView=[[QRCodeViewController alloc] init];
    qrCodeView.delegate=self;
    [qrView addSubview:qrCodeView.view];
    
    CGRect rect=qrView.frame;
    rect.origin=CGPointZero;
    qrCodeView.view.frame=rect;
    
    [self resizeQRView:qrCodeView.view];
    
    if(self.mode==SCAN_GET_SGP)
        [lblSlide setText:@"<a>TÍCH ĐIỂM</a><text> - CỬA HÀNG SẼ CUNG CẤP THẺ CHO BẠN</text>"];
    else
        [lblSlide setText:@"<a>NHẬN QUÀ</a><text> - CỬA HÀNG SẼ CUNG CẤP THẺ CHO BẠN</text>"];
}

-(void) removeCamera
{
    qrCodeView.delegate=nil;
    [qrCodeView removeFromParentViewController];
    [qrCodeView.view removeFromSuperview];
    qrCodeView=nil;
}

+(CGSize)size
{
    return CGSizeMake(320, 36);
}

-(UIButton *)btnSlide
{
    return btnSlide;
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

-(void)qrCodeCaptureImage:(UIImage *)image text:(NSString *)text
{
    if(![self validateQRCodeFormat:text])
    {
        [self removeCamera];
        [AlertView showAlertOKWithTitle:nil withMessage:@"QRCode không hợp lệ" onOK:^{
            [btnSlide sendActionsForControlEvents:UIControlEventTouchUpInside];
        }];
        return;
    }
    
    btnCloseStartup.hidden=true;
    
    _isSuccessed=false;
    _isUserScanded=true;
    
    qrCodeView.delegate=nil;
    
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
    
    ASIOperationGetRewardPromotionType2 *operation=[[ASIOperationGetRewardPromotionType2 alloc] initWithIDUser:idUser promotionID:_idReward code:code];
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
    imgvScan.hidden=true;
    
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
    
    if(_isSuccessed)
        [self requestShopDetailWithIDShop:qrCode.idShop];
}

-(void) requestShopDetailWithIDShop:(int) idShop
{
    _isLoadingShopDetail=true;
    
    __block __weak id obs = [[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_SHOPDETAIL_LOAD_FINISHED object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        
        _isLoadingShopDetail=false;
        [self showShopDetail];
        
        [[NSNotificationCenter defaultCenter] removeObserver:obs];
    }];
    
    [[RootViewController shareInstance].shopDetail loadWithIDShop:idShop];
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    imgvScan.hidden=true;
    
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

-(void)touchesBegan1:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self qrCodeCaptureImage:nil text:@"{\"type\": 1,\"url\":\"shop.smartguide.vn/100012\",\"name\": \"Trung Nguyên 12\",\"code\":\"32a1073560540b9e2ecdcf1c485d2f3d\"}"];
}

-(void) showShopDetail
{
    if(_isLoadingShopDetail || !_isUserClickClose)
        return;
    
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

@end

@implementation SlideQRView
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