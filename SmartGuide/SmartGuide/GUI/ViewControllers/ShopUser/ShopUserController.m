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
#import "GalleryFullViewController.h"
#import "TouchView.h"
#import "DataManager.h"
#import "GUIManager.h"
#import "WebViewController.h"
#import "Constant.h"
#import "ScanCodeController.h"
#import "NotFound404ViewController.h"

@interface ShopUserController ()<SGNavigationControllerDelegate,ShopUserViewControllerDelegate,GalleryFullControllerDelegate,WebViewDelegate,ScanCodeControllerDelegate>

@end

@implementation ShopUserController

-(ShopUserController *)initWithIDShop:(int)idShop
{
    self=[super initWithNibName:@"ShopUserController" bundle:nil];
    
    [self initNavigationWithIDShop:idShop];
    
    return self;
}

-(ShopUserController *)initWithShop:(Shop *)shop
{
    self=[super initWithNibName:@"ShopUserController" bundle:nil];
    
    [self initNavigationWithShop:shop];
    
    return self;
}

-(void) initNavigationWithShop:(Shop*) shop
{
    ShopUserViewController *vc=[[ShopUserViewController alloc] initWithShopUser:shop];
    vc.delegate=self;
    vc.shopController=self;
    
    _navi=[[SGNavigationController alloc] initWithRootViewController:vc];
    _navi.navigationDelegate=self;
}

-(void) initNavigationWithIDShop:(int) idShop
{
    ShopUserViewController *vc=[[ShopUserViewController alloc] initWithIDShop:idShop];
    vc.delegate=self;
    vc.shopController=self;
    
    _navi=[[SGNavigationController alloc] initWithRootViewController:vc];
    _navi.navigationDelegate=self;
}

-(ShopUserViewController*) shopUserViewControllerWithIDShop:(int) idShop
{
    ShopUserViewController *vc=[[ShopUserViewController alloc] initWithIDShop:idShop];
    vc.delegate=self;
    vc.shopController=self;
    
    return vc;
}

-(ShopUserViewController*) shopUserViewControllerWithShop:(Shop*) shop
{
    ShopUserViewController *vc=[[ShopUserViewController alloc] initWithShopUser:shop];
    vc.delegate=self;
    vc.shopController=self;
    
    return vc;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_navi.view l_v_setS:containView.l_v_s];
    [containView addSubview:_navi.view];
}

-(void) showShopWithIDShop:(int) idShop
{
    ShopUserViewController *vc=[[ShopUserViewController alloc] initWithIDShop:idShop];
    vc.shopController=self;
    
    [self showShopUserViewController:vc];
}

-(void) showShopUserViewController:(ShopUserViewController*) controller
{
    controller.delegate=self;
    controller.shopController=self;
    
    [_navi pushViewController:controller animated:true];
}

- (IBAction)btnBackTouchUpInside:(id)sender
{
    if([_navi.visibleViewController isKindOfClass:[NotFound404ViewController class]])
    {
        [_navi popViewControllerAnimated:true];

        [self btnBackTouchUpInside:btnBack];
        return;
    }
    
    if(_navi.viewControllers.count>1)
    {
        for(SGViewController *vc in _navi.viewControllers)
        {
            if(![vc navigationWillBack])
                return;
        }
        
        btnBack.userInteractionEnabled=false;
        
        [_navi popViewControllerAnimated:true onCompleted:^{
            btnBack.userInteractionEnabled=true;
        }];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:true];
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
    return 0.95f;
}

-(void)galleryFullTouchedBack:(GalleryFullViewController *)controller
{
    id gallery=[controller currentGallery];
    
    if(gallery)
    {
        if([gallery isKindOfClass:[ShopGallery class]])
            [ShopManager shareInstanceWithShop:controller.shop].selectedShopGallery=gallery;
        else
        {
            [ShopManager shareInstanceWithShop:controller.shop].selectedUserGallery=gallery;
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
    [self showScanCodeWithDelegate:self animationType:SCANCODE_ANIMATION_TOP_BOT];
}

-(void)shopUserViewControllerTouchedIDShop:(ShopUserViewController *)controller idShop:(int)idShop
{
    ShopUserViewController *vc=[self shopUserViewControllerWithIDShop:idShop];
    [_navi pushViewController:vc animated:true];
}

-(void)shopUserViewController404Error:(ShopUserViewController *)controller
{
    [[GUIManager shareInstance] show404:^{
        [self btnBackTouchUpInside:btnBack];
    } onBack:^{
        
    }];
}

-(void)shopUserViewControllerTouchedURL:(ShopUserViewController *)controller url:(NSURL *)url
{
    [self showWebViewWithURL:url onCompleted:nil];
}

-(bool)allowDragToNavigation
{
    if([_navi.visibleViewController isKindOfClass:[GalleryFullViewController class]])
        return false;
    
    return [super allowDragToNavigation];
}

@end
