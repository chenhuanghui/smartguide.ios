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
        
        NSNumberFormatter *format=[[NSNumberFormatter alloc] init];
        format.groupingSeparator=@".";
        format.maximumFractionDigits=0;

        [btnReward setTitle:[format stringFromNumber:shop.promotionDetail.money] forState:UIControlStateNormal];
        btnReward.tag=shop.promotionDetail.idAwardType2.integerValue;
        lblDesc.text=shop.promotionDetail.desc;
    }
    else
        [self reset];
        
}

- (IBAction)btnRewardTouchUpInside:(id)sender
{
    [self showLoadingWithTitle:nil];
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
    [self removeLoading];
    
    [AlertView showAlertOKWithTitle:nil withMessage:@"Bạn đã nhận phần thưởng thành công" onOK:nil];
    
    _operation=nil;
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    [self removeLoading];
    
    [AlertView showAlertOKWithTitle:nil withMessage:@"Nhận phần thưởng thất bại" onOK:nil];
    
    _operation=nil;
}

@end
