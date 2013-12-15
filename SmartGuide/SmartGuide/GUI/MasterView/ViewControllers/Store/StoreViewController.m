//
//  StoreViewController.m
//  SmartGuide
//
//  Created by MacMini on 08/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "StoreViewController.h"
#import "StoreShopViewController.h"
#import "StoreShopInfoViewController.h"

@interface StoreViewController ()

@end

@implementation StoreViewController
@synthesize delegate;

- (id)init
{
    self = [super initWithNibName:@"StoreViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) storeRect
{
    _rayViewFrame=rayView.frame;
    _bgViewFrame=bgView.frame;
    _bgImageViewFrame=bgImageView.frame;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self storeRect];
    
    bgView.layer.masksToBounds=true;
    
    [self addChildViewController:storeNavigation];
    
    [contentView addSubview:storeNavigation.view];
    [storeNavigation.view l_v_setS:contentView.l_v_s];
    
    StoreShopViewController *vc=[StoreShopViewController new];
    vc.storeController=self;

    [storeNavigation setRootViewController:vc animate:true];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapQR:)];
    
    [qrView addGestureRecognizer:tap];
}

-(void) tapQR:(UITapGestureRecognizer*) tap
{
    [self showQRCodeWithContorller:self inView:qrView];
}

-(void)qrcodeControllerRequestClose:(SGQRCodeViewController *)controller
{
    [self hideQRCode];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    storeNavigation=nil;
}

- (IBAction)btnSettingTouchUpInside:(id)sender {
    [self.delegate storeControllerTouchedSetting:self];
}

- (IBAction)btnBackTouchUpInside:(id)sender {
    btnBack.userInteractionEnabled=false;
    
    StoreShopInfoViewController *vc=(StoreShopInfoViewController*)storeNavigation.visibleViewController;
    
    [vc prepareOnBack];
    
    [UIView animateWithDuration:0.1f animations:^{
        rayView.frame=_rayViewFrame;
        bgView.frame=_bgViewFrame;
    } completion:^(BOOL finished) {
        [storeNavigation popToRootViewControllerAnimated:true];
        
        btnSetting.alpha=0;
        btnSetting.hidden=false;
        
        [UIView animateWithDuration:0.1f animations:^{
            btnBack.alpha=0;
            btnSetting.alpha=1;
        } completion:^(BOOL finished) {
            btnBack.hidden=true;
            btnBack.userInteractionEnabled=true;
        }];
    }];
}

-(UIView *)rayView
{
    return rayView;
}

-(CGRect)rayViewFrame
{
    return _rayViewFrame;
}

-(UIView *)bgView
{
    return bgView;
}

-(CGRect)bgViewFrame
{
    return _bgViewFrame;
}

-(UIImageView *)bgImageView
{
    return bgImageView;
}

-(CGRect)bgImageViewFrame
{
    return _bgImageViewFrame;
}

-(UIButton *)buttonLatest
{
    return btnLatest;
}

-(UIButton *)buttonTopSellers
{
    return btnTopSellers;
}

-(IBAction) btnCartTouchUpInside:(id)sender
{
    StoreCardViewController *vc=[StoreCardViewController new];
    
    [storeNavigation pushViewController:vc animated:true];
}

-(void)showShop:(StoreShop *)shop
{
    StoreShopInfoViewController *vc=[StoreShopInfoViewController new];
    vc.storeController=self;
    
    [storeNavigation pushViewController:vc animated:true];
    
    btnBack.alpha=0;
    btnBack.hidden=false;
    
    [UIView animateWithDuration:0.1f animations:^{
        btnBack.alpha=1;
        btnSetting.alpha=0;
    } completion:^(BOOL finished) {
        btnSetting.hidden=false;
    }];
}

-(IBAction) btnLatestTouchUpInside:(id)sender
{
    [[self visibleController] storeControllerButtonLatestTouched:sender];
}

-(SGViewController<StoreControllerHandle>*) visibleController
{
    return (SGViewController<StoreControllerHandle>*)storeNavigation.visibleViewController;
}

-(IBAction) btnTopSellersTouchUpInside:(id)sender
{
    [[self visibleController] storeControllerButtonTopSellersTouched:sender];
}

-(void)enableTouch
{
    self.view.userInteractionEnabled=true;
}

-(void)disableTouch
{
    self.view.userInteractionEnabled=false;
}

@end

@implementation StoreScrollView



@end