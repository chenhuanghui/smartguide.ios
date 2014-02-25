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
#import "StoreItemInfoViewController.h"

@interface StoreViewController ()

@end

@implementation StoreViewController
@synthesize delegate,sortType;

-(StoreViewController *)initWithStore:(StoreShop *)store
{
    self = [super initWithNibName:@"StoreViewController" bundle:nil];
    if (self) {
        // Custom initialization
        
        _store=store;
    }
    return self;
}

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
    _bgViewFrame=bgView.frame;
    _bgImageViewFrame=bgImageView.frame;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self storeRect];
    
    bgView.layer.masksToBounds=true;
    
    StoreShopViewController *vc=[StoreShopViewController new];
    vc.storeController=self;
    
    SGNavigationController *navi=[[SGNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:navi];
    
    storeNavigation=navi;
    
    if(_store)
    {
        [self showShop:_store animate:false];
    }
    
    [contentView addSubview:storeNavigation.view];
    [storeNavigation.view l_v_setS:contentView.l_v_s];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapQR:)];
    
    [qrView addGestureRecognizer:tap];
}

-(void) tapQR:(UITapGestureRecognizer*) tap
{
    [self showQRCodeWithContorller:self inView:qrView withAnimationType:QRCODE_ANIMATION_TOP screenCode:SCREEN_CODE_STORE_LIST];
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
    
    if([[self visibleController] respondsToSelector:@selector(handleBackCallbackCompleted:)])
    {
        [[self visibleController] handleBackCallbackCompleted:^{
            [UIView animateWithDuration:0.1f animations:^{
                //                rayView.frame=_rayViewFrame;
                //                bgView.frame=_bgViewFrame;
            } completion:^(BOOL finished) {
                [storeNavigation popViewControllerAnimated:true];
                
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
        }];
        
        return;
    }
    
    [UIView animateWithDuration:0.1f animations:^{
        //        rayView.frame=_rayViewFrame;
        //        bgView.frame=_bgViewFrame;
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

-(UIView *)qrView
{
    return qrView;
}

-(IBAction) btnCartTouchUpInside:(id)sender
{
    StoreCardViewController *vc=[StoreCardViewController new];
    
    [storeNavigation pushViewController:vc animated:true];
}

-(void)showShop:(StoreShop *)shop animate:(bool) animate
{
    StoreShopInfoViewController *vc=[[StoreShopInfoViewController alloc] initWithStore:shop];
    vc.storeController=self;
    
    [storeNavigation pushViewController:vc animated:animate];
    
    if(animate)
    {
        btnBack.alpha=0;
        btnBack.hidden=false;
        
        [UIView animateWithDuration:0.1f animations:^{
            btnBack.alpha=1;
            btnSetting.alpha=0;
        } completion:^(BOOL finished) {
            btnSetting.hidden=false;
        }];
    }
    else
    {
        btnSetting.alpha=0;
        btnSetting.hidden=true;
        btnBack.alpha=1;
        btnBack.hidden=false;
    }
}

-(void)showItem:(StoreShopItem *)item
{
    
}

-(void)buyItem:(StoreShopItem *)item
{
    [item buy];
    
    NSString *str=[NSString stringWithFormat:@"%i",[StoreCart allObjects].count];
    
    lblCart.text=str;
}

-(IBAction) btnLatestTouchUpInside:(id)sender
{
    sortType=SORT_STORE_SHOP_LIST_LATEST;
    //    [[self visibleController] storeControllerButtonLatestTouched:sender];
}

-(SGViewController<StoreControllerHandle>*) visibleController
{
    return (SGViewController<StoreControllerHandle>*)storeNavigation.visibleViewController;
}

-(IBAction) btnTopSellersTouchUpInside:(id)sender
{
    sortType=SORT_STORE_SHOP_LIST_TOP_SELLER;
    //    [[self visibleController] storeControllerButtonTopSellersTouched:sender];
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