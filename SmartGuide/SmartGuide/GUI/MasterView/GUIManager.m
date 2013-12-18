//
//  GUIManager.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "GUIManager.h"
#import "TransportViewController.h"

static GUIManager *_shareInstance=nil;

@interface GUIManager()
{
    
}

@property (nonatomic, weak) UIViewController *previousViewController;

@end

@implementation GUIManager
@synthesize mainWindow,rootNavigation,rootViewController,toolbarController,contentNavigation,adsController,qrCodeController,userController,tutorialController,notificationController,presentedViewController,storeController;
@synthesize previousViewController;
@synthesize shopUserController;

+(void)load
{
}

+(GUIManager *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance=[GUIManager new];
    });
    
    return _shareInstance;
}

-(void)startupWithWindow:(UIWindow *)window
{
    mainWindow=window;
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:true];
    
    NSMutableArray *viewControllers=[NSMutableArray array];
    
    if([[DataManager shareInstance].currentUser isUserDefault])
    {
        WelcomeViewController *welcome=[[WelcomeViewController alloc] init];
        welcome.delegate=self;
        
        [viewControllers addObject:welcome];
    }
    else
    {
        User *user=[DataManager shareInstance].currentUser;
        
        if([user.name stringByRemoveString:@" ",nil].length==0)
        {
            AuthorizationViewController *author=[[AuthorizationViewController alloc] init];
            author.delegate=self;
            [author showCreateUser];
            
            TransportViewController *transport=[[TransportViewController alloc] initWithNavigation:author];
            
            [viewControllers addObject:transport];
        }
        else
        {
            SGRootViewController *root=[[SGRootViewController alloc] initWithDelegate:self];
            
            rootViewController=root;
            
            [viewControllers addObject:root];
        }
    }
    
    SGLoadingScreenViewController *loading=[[SGLoadingScreenViewController alloc] init];
    loading.delegate=self;
    
    [viewControllers addObject:loading];
    
    SGNavigationController *rNavigation=[[SGNavigationController alloc] initWithViewControllers:viewControllers];

    rootNavigation=rNavigation;
    
    mainWindow.rootViewController=rNavigation;
    [mainWindow makeKeyAndVisible];
}

-(void)SGLoadingFinished:(SGLoadingScreenViewController *)loadingScreen
{
    [self.rootNavigation setAnimationPopViewController:^CATransition *(UIViewController *vc) {
        CATransition* transition = [CATransition animation];
        transition.duration = 0.5;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
        transition.subtype = kCATransitionFromRight; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
        
        return transition;
    }];
    
    [self.rootNavigation popViewControllerAnimated:true];
}

-(void)welcomeControllerTouchedLogin:(WelcomeViewController *)viewController
{
    [self showLoginController];
}

-(void)welcomeControllerTouchedTry:(WelcomeViewController *)viewController
{
    [self showRootControlelr];
}

-(void) showRootControlelr
{
    SGRootViewController *rController=[[SGRootViewController alloc] initWithDelegate:self];
    rootViewController=rController;
    
    [self.rootNavigation setRootViewController:rController animate:true];
}

-(void)SGControllerLoadView:(SGViewController *)sgController
{
    if(sgController==rootViewController)
    {
        [self loadContentNavigation];
        [self loadQRCode];
    }
}

-(void)SGControllerDidLoadView:(SGViewController *)sgController
{
    if(sgController==rootViewController)
    {
        [rootViewController.contentView addSubview:contentNavigation.view];
    }
}

-(void) loadContentNavigation
{
    NewFeedViewController *vc=[[NewFeedViewController alloc] init];
    vc.delegate=self;
    
    SGNavigationController *navi=[[SGNavigationController alloc] initWithRootViewController:vc];
    
    contentNavigation=navi;
    
    [rootViewController addChildViewController:navi];
}

-(void)newFeedControllerTouchedTextField:(NewFeedViewController *)controller
{
    SearchViewController *vc=[[SearchViewController alloc] initWithSearch];
    vc.delegate=self;
    
    [rootNavigation pushViewController:vc animated:true];
}

-(void) showUserController
{
    [self.rootNavigation removeLeftSlideViewController];
    
    if([self.contentNavigation.visibleViewController isKindOfClass:[SGUserViewController class]])
        return;
    
    [self.contentNavigation popToRootViewControllerAnimated:false];
    
    if(userController)
    {
        [self.contentNavigation pushViewController:userController animated:false];
        return;
    }
    
    SGUserViewController *vc=[[SGUserViewController alloc] init];
    vc.delegate=self;
    
    userController=vc;
    
    [self.contentNavigation pushViewController:vc animated:false];
}


-(void) loadAds
{
    SGAdsViewController *vc=[[SGAdsViewController alloc] init];
    adsController=vc;
    
    [rootViewController addChildViewController:vc];
}

-(void) loadQRCode
{
    SGQRCodeViewController *vc=[[SGQRCodeViewController alloc] init];
    vc.delegate=self;
    
    qrCodeController=vc;
    
    [rootViewController addChildViewController:vc];
}

-(void)toolbarSetting
{
}

-(void)settingTouchedCatalog:(SGSettingViewController *)settingController
{
    [self.rootNavigation removeLeftSlideViewController];
    [self.contentNavigation popToRootViewControllerAnimated:false];
}

-(void)settingTouchedUser:(SGSettingViewController *)settingController
{
    [self showUserController];
}

-(void)settingTouchedUserSetting:(SGSettingViewController *)settingController
{
    SGUserSettingViewController *vc=[[SGUserSettingViewController alloc] init];
    vc.delegate=self;
    
    [self presentViewController:vc];
}

-(void)userSettingControllerTouchedClose:(SGUserSettingViewController *)controller
{
    [self dismissPresentedViewController:nil];
}

-(void) showStoreController
{
    [self.rootNavigation removeLeftSlideViewController];
    
    if([self.contentNavigation.visibleViewController isKindOfClass:[StoreViewController class]])
        return;
    
    [self.contentNavigation popToRootViewControllerAnimated:false];
    
    if(storeController)
    {
        [self.contentNavigation pushViewController:storeController animated:false];
        return;
    }
    
    StoreViewController *vc=[[StoreViewController alloc] init];
    vc.delegate=self;
    
    storeController=vc;
    
    [self.contentNavigation pushViewController:vc animated:false];

}

-(void)settingTouchedStore:(SGSettingViewController *)controller
{
    [self showStoreController];
}

-(void)storeControllerTouchedSetting:(StoreViewController *)controller
{
    [self showLeftController];
}

-(void)notificationControllerTouchedBack:(SGNotificationViewController *)controller
{
    if(self.rootNavigation.rightSlideController)
    {
        [self.rootNavigation removeRightSlideViewController:controller];
    }
    else
    {
        [self showLeftController];
    }
}

-(void)settingTouchedOtherView:(SGSettingViewController *)controller
{
    [self.rootNavigation removeLeftSlideViewController];
    
    if([self.contentNavigation.visibleViewController isKindOfClass:[SGTutorialViewController class]])
        return;
    
    [self.contentNavigation popToRootViewControllerAnimated:false];
    
    if(tutorialController)
    {
        [self.contentNavigation pushViewController:tutorialController animated:false];
        return;
    }
    
    SGTutorialViewController *vc=[[SGTutorialViewController alloc] init];
    vc.delegate=self;
    
    tutorialController=vc;
    
    [self.contentNavigation pushViewController:vc animated:false];
}

-(void)toolbarUserCollection
{
//    if(userCollectionController)
//    {
//        [UIView animateWithDuration:DURATION_DEFAULT animations:^{
//            userCollectionController.view.center=CGPointMake(userCollectionController.view.center.x, -userCollectionController.view.frame.size.height/2);
//        } completion:^(BOOL finished) {
//            [userCollectionController removeFromParentViewController];
//            [userCollectionController.view removeFromSuperview];
//            userCollectionController=nil;
//            masterContainerView.content_ads_upper.hidden=true;
//        }];
//        return;
//    }
//    
//    masterContainerView.content_ads_upper.hidden=false;
//    
//    userCollectionController=[[SGUserCollectionController alloc] init];
//    [userCollectionController setNavigationBarHidden:true];
//    CGRect rect=userCollectionController.view.frame;
//    rect.size=masterContainerView.content_ads_upper.frame.size;
//    rect.origin=CGPointMake(0, -rect.size.height);
//    userCollectionController.view.frame=rect;
//    
//    [self.masterContainerView addChildViewController:userCollectionController];
//    [self.masterContainerView.content_ads_upper addSubview:userCollectionController.view];
//    
//    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
//        userCollectionController.view.center=CGPointMake(userCollectionController.view.center.x, userCollectionController.view.frame.size.height/2);
//    }];
}

#pragma - ViewControllers Delegate

-(void)authorizationSuccessed
{
    if(_onLoginedCompleted)
    {
        _onLoginedCompleted(true);
        _onLoginedCompleted=nil;
    }
    
    if(!self.rootViewController)
    {
        [self showRootControlelr];
    }
    else
        [self.rootNavigation popViewControllerAnimated:true];
}

-(void)authorizationCancelled
{
    [self.rootNavigation popViewControllerAnimated:true];
    
    if(_onLoginedCompleted)
    {
        _onLoginedCompleted(false);
        _onLoginedCompleted=nil;
    }
    
    
}

-(void)presentViewController:(SGViewController *)viewController
{
    presentedViewController=viewController;
    
    [self.rootNavigation addChildViewController:viewController];
    
    [viewController view];
    
    viewController.view.center=CGPointMake(self.rootNavigation.l_v_w/2, -self.rootNavigation.l_v_h/2);
    [viewController l_c_setY:-self.rootNavigation.l_v_h/2];
    
    [self.rootNavigation.view alphaViewWithColor:[UIColor blackColor]];
    self.rootNavigation.view.alphaView.alpha=0;
    
    [self.rootNavigation.view addSubview:viewController.view];
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        self.rootNavigation.view.alphaView.alpha=.7f;
        
        [viewController l_c_setY:self.rootNavigation.l_v_h/2];
    }];
}

-(void)dismissPresentedViewController:(void (^)())onCompleted
{
    if(!presentedViewController)
        return;
    
    void(^_onCompleted)()=[onCompleted copy];
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        self.rootNavigation.view.alphaView.alpha=0;
        [presentedViewController l_c_setY:-self.rootNavigation.l_v_h/2];
    } completion:^(BOOL finished) {
        
        [self.rootNavigation.view removeAlphaView];
        
        [presentedViewController.view removeFromSuperview];
        [presentedViewController removeFromParentViewController];
        presentedViewController=nil;
        
        if(_onCompleted)
        {
            _onCompleted();
        }
    }];
}

-(void) presentShopUserWithIDShop:(int)idShop
{
    ShopUserViewController *shopUser=[[ShopUserViewController alloc] init];
    shopUserController=shopUser;
    shopUser.delegate=self;
    
    [self presentViewController:shopUser];
}

-(void)shopUserFinished
{
    [self dismissShopUser];
}

-(void)dismissShopUser
{
    if(shopUserController)
    {
        [self dismissPresentedViewController:^{
            shopUserController=nil;
        }];
    }
}

-(void)showLoginDialogWithMessage:(NSString *)message onCompleted:(void (^)(bool))onCompleted
{
    _onLoginedCompleted=[onCompleted copy];
    
    [AlertView showAlertOKCancelWithTitle:nil withMessage:message onOK:^{
        [self showLoginController];
    } onCancel:^{
        _onLoginedCompleted(false);
        _onLoginedCompleted=nil;
    }];
}

-(void) showLoginController
{
    AuthorizationViewController *author=[[AuthorizationViewController alloc] init];
    [author showLogin];
    author.delegate=self;
    
    TransportViewController *transport=[[TransportViewController alloc] initWithNavigation:author];
    [self.rootNavigation pushViewController:transport animated:true];
}

-(void)qrcodeControllerRequestShow:(SGQRCodeViewController *)controller
{
//    _qrCodeBeforeShowFrame=self.rootViewController.qrCodeView.frame;
//    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
//        CGRect rect=self.rootViewController.qrCodeFrame;
//        rect.origin.y=0;
//        self.rootViewController.qrCodeView.frame=rect;
//    }];
}

-(void) qrcodeControllerRequestClose:(SGQRCodeViewController *)controller
{
//    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
//        self.rootViewController.qrCodeView.frame=_qrCodeBeforeShowFrame;
//    }];
}

-(void) qrcodeControllerScanned:(SGQRCodeViewController *)controller
{
//    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
//        self.rootViewController.qrCodeView.frame=self.rootViewController.qrCodeFrame;
//    }];
}

-(void)displayViewController:(SGViewController *)viewController
{
    [self.rootViewController moveToTopView:viewController];
}

-(void)closeViewController:(SGViewController *)viewController
{
    [self.rootViewController removeTopView:viewController];
}

-(void) showLeftController
{
    SGSettingViewController *settingController=[[SGSettingViewController alloc] init];
    settingController.delegate=self;
    
    [self.rootNavigation showLeftSlideViewController:settingController animate:true];
}

-(void) showRightController
{
    SGNotificationViewController *vc=[[SGNotificationViewController alloc] init];
    vc.delegate=self;
    
    [self.rootNavigation showRightSlideViewController:vc animate:true];
}

-(void)userControllerTouchedSetting:(SGUserViewController *)controller
{
    [self showLeftController];
}

-(void)newFeedControllerTouchedNavigation:(NewFeedViewController *)controller
{
    [self showLeftController];
}

@end