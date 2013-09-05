//
//  PromotionDetailType2View.m
//  SmartGuide
//
//  Created by XXX on 8/3/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "PromotionDetailType2View.h"
#import "RootViewController.h"
#import "SlideQRCodeViewController.h"
#import "Utility.h"

@implementation PromotionDetailType2View
@synthesize handler;

-(PromotionDetailType2View *)initWithShop:(Shop *)shop
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"PromotionDetailType2View" owner:nil options:nil] objectAtIndex:0];
    
    btnReward.layer.cornerRadius=8;
    btnReward.layer.masksToBounds=true;
    [self setShop:shop];
    
    FTCoreTextStyle *style=[FTCoreTextStyle styleWithName:@"text"];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.font=[UIFont italicSystemFontOfSize:12];
    style.color=[UIColor darkGrayColor];
    
    [lblP addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"p"];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.color=[UIColor color255WithRed:201 green:84 blue:54 alpha:255];
    style.font=[UIFont boldSystemFontOfSize:12];
    
    [lblP addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"gn"];
    style.textAlignment=FTCoreTextAlignementLeft;
    style.color=[UIColor darkGrayColor];
    style.font=[UIFont systemFontOfSize:10];
    
    [lblDesc addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"vnd"];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.color=[UIColor color255WithRed:201 green:84 blue:54 alpha:255];
    style.font=[UIFont boldSystemFontOfSize:12];
    
    [lblDesc addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"dk"];
    style.textAlignment=FTCoreTextAlignementLeft;
    style.color=[UIColor darkGrayColor];
    style.font=[UIFont boldSystemFontOfSize:11];
    
    [lblDesc addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"text"];
    style.textAlignment=FTCoreTextAlignementLeft;
    style.color=[UIColor darkGrayColor];
    style.font=[UIFont systemFontOfSize:11];
    
    [lblDesc addStyle:style];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userScanedQRCode:) name:NOTIFICATION_USER_SCANED_QR_CODE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userScanedQRCode:) name:NOTIFICATION_USER_CANCELED_SCAN_QR_CODE object:nil];
    
    return self;
}

-(void) userScanedQRCode:(NSNotification*) notification
{
    [self removeLoading];
}

-(void)setShop:(Shop *)shop
{
    if(_operation)
    {
        [_operation cancel];
        _operation=nil;
    }
    
    _shop=shop;
    
    if(shop)
    {
        btnReward.hidden=false;
        lblDuration.text=_shop.promotionDetail.duration;
        
        [btnReward setTitle:[NSNumberFormatter moneyFromNSNumber:shop.promotionDetail.money] forState:UIControlStateNormal];
        btnReward.tag=shop.promotionDetail.idAwardType2.integerValue;
        
        [self setDesc:[NSNumberFormatter moneyFromNSNumber:shop.promotionDetail.money] dk:shop.promotionDetail.desc];
        [self setP:shop.promotionDetail.p.integerValue];
    }
    else
        [self reset];
}

-(void) setDesc:(NSString*) money dk:(NSString*) dk
{
    [lblDesc setText:[NSString stringWithFormat:@"<gn>Giảm ngay </gn><vnd>%@</vnd><text>\ntrên hoá đơn khi </text><dk>%@</dk>",money,dk]];
}

-(void) setP:(int) p
{
    [lblP setText:[NSString stringWithFormat:@"<text>Tích luỹ <p>%iP</p> trên 1 lượt quét thẻ</text>",p]];
}

- (IBAction)btnRewardTouchUpInside:(id)sender
{
//    [self showLoadingWithTitle:nil];
    [[RootViewController shareInstance].slideQRCode scanGetPromotion2WithIDAward:_shop.promotionDetail.idAwardType2.integerValue];
}

-(void)reloadWithShop:(Shop *)shop
{
    [self setShop:shop];
}

-(void)reset
{
    [btnReward setTitle:@"" forState:UIControlStateNormal];
    btnReward.hidden=true;
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
//    [self removeLoading];
    
    [AlertView showAlertOKWithTitle:nil withMessage:@"Bạn đã nhận phần thưởng thành công" onOK:nil];
    
    _operation=nil;
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
//    [self removeLoading];
    
    [AlertView showAlertOKWithTitle:nil withMessage:@"Nhận phần thưởng thất bại" onOK:nil];
    
    _operation=nil;
}

@end
