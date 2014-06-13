//
//  ShopUserController.m
//  Infory
//
//  Created by XXX on 6/9/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopUserController.h"
#import "ButtonBackShopUser.h"
#import "SGNavigationController.h"
#import "ShopUserViewController.h"
#import "ShopManager.h"
#import "QRCodeViewController.h"
#import "GalleryFullViewController.h"
#import "TouchView.h"

@interface ShopUserController ()<SGNavigationControllerDelegate,ShopUserViewControllerDelegate,GalleryFullControllerDelegate>

@end

@implementation ShopUserController

-(ShopUserController *)initWithIDShop:(int)idShop
{
    self=[super initWithNibName:@"ShopUserController" bundle:nil];
    
    _idShop=idShop;
    _shop=[Shop makeWithIDShop:_idShop];
    
    if([_shop hasChanges])
        [[DataManager shareInstance] save];
    
    return self;
}

-(ShopUserController *)initWithShop:(Shop *)shop
{
    self=[super initWithNibName:@"ShopUserController" bundle:nil];
    
    _shop=shop;
    _idShop=_shop.idShop.integerValue;
    
    return self;
}

-(void)loadView
{
    [super loadView];
    
    ShopUserViewController *vc=nil;
    if(_shop)
        vc=[[ShopUserViewController alloc] initWithShopUser:_shop];
    else
        vc=[[ShopUserViewController alloc] initWithIDShop:_idShop];
    
    vc.delegate=self;
    self.shopController=vc;
    
    _navi=[[SGNavigationController alloc] initWithRootViewController:vc];
    _navi.navigationDelegate=self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
#if DEBUG
    [[SDWebImageManager sharedManager].imageCache clearDisk];
    [[SDWebImageManager sharedManager].imageCache clearMemory];
#endif
    
    [_navi.view l_v_setS:containView.l_v_s];
    [containView addSubview:_navi.view];
}

- (IBAction)btnCloseTouchUpInside:(id)sender {
    [ShopManager clean];
    [self.delegate shopUserControllerTouchedClose:self];
}

- (IBAction)btnBackTouchUpInside:(id)sender {
    
    for(SGViewController *vc in _navi.viewControllers)
    {
        if(![vc navigationWillBack])
            return;
    }
    
    [btnBack startHideAnimateOnCompleted:^(UIButton *btn) {
        
        [_navi popViewControllerAnimated:true];
        btnBack.hidden=true;
        
        btnClose.hidden=false;
        btnClose.alpha=0;
        [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
            btnClose.alpha=1;
        }];
    }];}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if([viewController isKindOfClass:[ShopUserViewController class]])
    {
    }
    else
    {
        [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
            btnClose.alpha=0;
        } completion:^(BOOL finished) {
            btnClose.hidden=true;
        }];
    }
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if([viewController isKindOfClass:[ShopUserViewController class]])
        return;
    
    if(btnBack.hidden)
    {
        btnBack.hidden=false;
        [btnBack startShowAnimateOnCompleted:nil];
    }
}

-(void)shopUserViewControllerPresentGallery:(ShopUserViewController *)controller galleryController:(GalleryFullViewController *)galleryController
{
    galleryController.delegate=self;
    
    [self presentSGViewController:galleryController animation:^BasicAnimation *{
        BasicAnimation *ani=[BasicAnimation animationWithKeyPath:@"opacity"];
        ani.fromValue=@(0);
        ani.toValue=@(1);
        ani.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        ani.removedOnCompletion=true;
        ani.fillMode=kCAFillModeForwards;
        
        return ani;
    } completion:nil];
}

-(float)alphaForPresentView
{
    return 0.9f;
}

-(void)galleryFullTouchedBack:(GalleryFullViewController *)controller
{
    id gallery=[controller currentGallery];
    
    if(gallery)
    {
        if([gallery isKindOfClass:[ShopGallery class]])
            [ShopManager shareInstanceWithShop:_shop].selectedShopGallery=gallery;
        else
        {
            [ShopManager shareInstanceWithShop:_shop].selectedUserGallery=gallery;
        }
    }
    
    [self dismissSGViewControllerAnimation:^BasicAnimation *{
        BasicAnimation *animation=[BasicAnimation animationWithKeyPath:@"opacity"];
        animation.fromValue=@(1);
        animation.toValue=@(0);
        animation.fillMode=kCAFillModeForwards;
        animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        animation.removedOnCompletion=true;
        
        return animation;
    } completion:nil];
}

-(void)shopUserViewControllerTouchedQRCode:(ShopUserViewController *)controller
{
    [self showQRCodeWithContorller:self inView:self.view withAnimationType:QRCODE_ANIMATION_TOP_BOT screenCode:[ShopUserViewController screenCode]];
}

@end
