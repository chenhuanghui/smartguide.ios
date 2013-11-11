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
    self=[[[NSBundle mainBundle] loadNibNamed:NIB_PHONE(@"PromotionDetailType2View") owner:nil options:nil] objectAtIndex:0];
    
    [self setShop:shop];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userScanedQRCode:) name:NOTIFICATION_USER_SCANED_QR_CODE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userScanedQRCode:) name:NOTIFICATION_USER_CANCELED_SCAN_QR_CODE object:nil];
    
    FTCoreTextStyle *style=[FTCoreTextStyle styleWithName:@"text"];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.color=[UIColor blackColor];
    style.font=[UIFont systemFontOfSize:11];
    
    [lblP addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"p"];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.color=[UIColor redColor];
    style.font=[UIFont systemFontOfSize:11];
    
    [lblP addStyle:style];
    
    [lblP setText:@"<text>Mỗi lần quét thẻ bạn nhận được điểm <p>P</p> tương ứng</text>"];
    
    return self;
}

-(void) userScanedQRCode:(NSNotification*) notification
{
    [self removeLoading];
}

-(void)setShop:(Shop *)shop
{
    _shop=shop;
    
    if(shop)
    {
        lblDuration.text=_shop.promotionDetail.duration;
    }
    else
        [self reset];
}

- (IBAction)bntRewardTouchUpInside:(id)sender {
    [self getRewardWithID:-1];
}

- (IBAction)btnListRewardTouchUpInside:(id)sender
{
    PopupGiftPromotion2 *popup=nil;
    
    if(_shop.promotionDetail.vouchersInserted && _shop.promotionDetail.vouchersInserted.count>0)
    {
        NSMutableArray *array=[NSMutableArray array];
        
        for(NSNumber *num in _shop.promotionDetail.vouchersInserted)
        {
            int idVoucher=[num integerValue];
            [array addObject:[_shop.promotionDetail voucherWithID:idVoucher]];
        }
        
        popup=[[PopupGiftPromotion2 alloc] initWithVouchers:array delegate:self];
    }
    
    if(!popup)
        popup=[[PopupGiftPromotion2 alloc] initWithVouchers:_shop.promotionDetail.vouchersObjects delegate:self];
    
    _rootView=[[RootViewController shareInstance] giveARootView];
    _rootView.backgroundColor=[UIColor clearColor];
    
    popup.frame=_rootView.frame;
    
    _rootView.alpha=0;
    [_rootView addSubview:popup];
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        _rootView.alpha=1;
    }];

}

-(void)popupGiftDidCancelled:(PopupGiftPromotion2 *)popup
{
    [self removePopup:popup];
}

-(void)popupGiftDidSelectedVoucher:(PopupGiftPromotion2 *)popup voucher:(PromotionVoucher *)voucher
{
    [self removePopup:popup];
    
//    [self getRewardWithID:voucher.idVoucher.integerValue];
}

-(void) removePopup:(PopupGiftPromotion2*) popup
{
    _rootView.userInteractionEnabled=false;
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        _rootView.alpha=0;
    } completion:^(BOOL finished) {
        [popup removeFromSuperview];
        [[RootViewController shareInstance] removeRootView:_rootView];
    }];
}

-(void) getRewardWithID:(int) idReward
{
    [[RootViewController shareInstance].slideQRCode scanGetPromotion2WithIDAward:idReward];
}

-(void)reloadWithShop:(Shop *)shop
{
    [self setShop:shop];
}

-(void)reset
{
    lblDuration.text=@"";
}

@end
