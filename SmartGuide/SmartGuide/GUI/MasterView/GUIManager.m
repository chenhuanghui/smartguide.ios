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
@synthesize mainWindow,masterContainerView,masterNavigation,rootNavigation,rootViewController,toolbarController,contentNavigation,adsController,qrCodeController,userController,userSettingController;
@synthesize previousViewController;
@synthesize shopUserController;

+(void)load
{
    [DataManager shareInstance].currentUser=[User userWithIDUser:[Flags lastIDUser]];
    
    if(![DataManager shareInstance].currentUser)
    {
        [[DataManager shareInstance] makeTryUser];
    }
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
        [self loadToolbar];
        [self loadContentNavigation];
        [self loadAds];
        [self loadQRCode];
    }
}

-(void)SGControllerDidLoadView:(SGViewController *)sgController
{
    if(sgController==rootViewController)
    {
        [rootViewController.toolbarView addSubview:toolbarController.view];
        [rootViewController.contentView addSubview:contentNavigation.view];
        [rootViewController.adsView addSubview:adsController.view];
        [rootViewController.qrCodeView addSubview:qrCodeController.view];
    }
}

-(void) loadToolbar
{
    ToolbarViewController *vc=[[ToolbarViewController alloc] init];
    vc.delegate=self;
    
    toolbarController=vc;
    
    [rootViewController addChildViewController:vc];
}

-(void) loadContentNavigation
{
    ShopViewController *shopController=[[ShopViewController alloc] init];
    TransportViewController *transport=[[TransportViewController alloc] initWithNavigation:shopController];
    
    SGNavigationController *vc=[[SGNavigationController alloc] initWithRootViewController:transport];
    contentNavigation=vc;
    
    [rootViewController addChildViewController:vc];
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
    qrCodeController=vc;
    
    [rootViewController addChildViewController:vc];
}

-(void)startupWithWindow1:(UIWindow *)window
{
    mainWindow=window;
    mainWindow.backgroundColor=COLOR_BACKGROUND_APP;
    
    NSMutableArray *controllers=[NSMutableArray array];
    
    //isShowedWelcomeScreen true:khi user touch vào try hoặc login
    if(![Flags isShowedWelcomeScreen])
    {        
        WelcomeViewController *vc=[[WelcomeViewController alloc] init];
        vc.delegate=self;
        
        [controllers addObject:vc];
    }
    else
    {
        [DataManager shareInstance].currentUser=[User userWithIDUser:[Flags lastIDUser]];
        
        //currentUser nil:khi touched vào login nhưng không nhập thông tin
        if(![DataManager shareInstance].currentUser)
        {
            WelcomeViewController *welcome=[[WelcomeViewController alloc] init];
            welcome.delegate=self;
            
            [controllers addObject:welcome];
            
            AuthorizationViewController *author=[[AuthorizationViewController alloc] init];
            author.delegate=self;
            [author showLogin];
            TransportViewController *transport=[[TransportViewController alloc] initWithNavigation:author];
            
            [controllers addObject:transport];
        }
        else
        {
            MasterContainerViewController *vc=[[MasterContainerViewController alloc] initWithDelegate:self];
            masterContainerView=vc;
            
            [controllers addObject:vc];
        }
    }
    
    SGLoadingScreenViewController *loadingController=[[SGLoadingScreenViewController alloc] init];
    loadingController.delegate=self;
    [controllers addObject:loadingController];
    
    SGNavigationController *navi=[[SGNavigationController alloc] initWithViewControllers:controllers];
    masterNavigation=navi;
    
    [navi setNavigationBarHidden:true];
    
    window.rootViewController=navi;
    [window makeKeyAndVisible];
}

-(void)masterContainerLoadedView:(MasterContainerViewController *)masterController
{
    masterController.toolbarController.delegate=self;
}

-(void)SGQRCodeRequestShow
{
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        CGRect rect=self.masterContainerView.qrView.frame;
        rect.origin.y=self.masterContainerView.toolbarFrame.origin.y+self.masterContainerView.toolbarFrame.size.height;
        self.masterContainerView.qrView.frame=rect;
    }];
}

-(void)contentViewSelectedShop
{
    [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
        CGRect rect=self.masterContainerView.adsView.frame;
        rect.origin.y+=rect.size.height;
        self.masterContainerView.adsView.frame=rect;
    }];
}

-(void)contentViewBackToShopListAnimated:(bool)isAnimated
{
    [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
        self.masterContainerView.adsView.frame=self.masterContainerView.adsFrame;
    }];
}

-(void)toolbarSetting
{
    SGSettingViewController *settingController=[[SGSettingViewController alloc] init];
    settingController.delegate=self;
 
    [self.rootNavigation showLeftSlideViewController:settingController animate:true];
}

-(void)settingTouchedCatalog:(SGSettingViewController *)settingController
{
    [self.rootNavigation removeLeftSlideViewController];
    [self.contentNavigation popToRootViewControllerAnimated:false];
}

-(void)settingTouchedUser:(SGSettingViewController *)settingController
{
    [self.rootNavigation removeLeftSlideViewController];
    
    if([self.contentNavigation.visibleViewController isKindOfClass:[UserViewController class]])
        return;
    
    [self.contentNavigation popToRootViewControllerAnimated:false];
    
    if(userController)
    {
        [self.contentNavigation pushViewController:userController animated:false];
        return;
    }
    
    UserViewController *vc=[[UserViewController alloc] init];
    vc.delegate=self;
    
    userController=vc;
    
    [self.contentNavigation pushViewController:vc animated:false];
}

-(void)settingTouchedUserSetting:(SGSettingViewController *)settingController
{
    [self.rootNavigation removeLeftSlideViewController];
    
    if([self.contentNavigation.visibleViewController isKindOfClass:[UserSettingViewController class]])
        return;
    
    [self.contentNavigation popToRootViewControllerAnimated:false];
    
    if(userSettingController)
    {
        [self.contentNavigation pushViewController:userSettingController animated:false];
        return;
    }
    
    UserSettingViewController *vc=[[UserSettingViewController alloc] init];
    vc.delegate=self;
    
    userSettingController=vc;
    
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

-(void)toolbarUserLogin
{
    AuthorizationViewController *authorizationController=[[AuthorizationViewController alloc] init];
    authorizationController.delegate=self;
    
    [authorizationController showLogin];
    
    TransportViewController *transport=[[TransportViewController alloc] initWithNavigation:authorizationController];
    
    [self.masterNavigation pushViewController:transport animated:true];
}

-(void)authorizationSuccessed
{
    if(_onLoginedCompleted)
    {
        _onLoginedCompleted(true);
        _onLoginedCompleted=nil;
    }
    
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

-(void)panGestureMovedToView:(UIView *)view
{
    if(view==self.previousViewController.view)
    {
        [self.masterNavigation popViewControllerAnimated:false];
        [self removePanGes_Handle];
    }
}

-(void) removePanGes_Handle
{
    if(panGes)
    {
        panGes.delegate=nil;
        [panGes removeTarget:self action:@selector(panGes:)];
        [self.masterNavigation.view removeGestureRecognizer:panGes];
        panGes=nil;
    }
    
    if(panHandle)
    {
        panHandle.delegate=nil;
        panHandle=nil;
    }
}

-(void)SGSettingHided
{
//    settingController.delegate=nil;
//    settingController=nil;
}
#pragma - ViewControllers Delegate
-(void) presentShopUserWithIDShop:(int)idShop
{
    ShopUserViewController *shopUser=[[ShopUserViewController alloc] init];
    shopUserController=shopUser;
    shopUser.delegate=self;
    
    [self.rootNavigation addChildViewController:shopUser];
    
    [shopUser view];
    
    shopUser.view.center=CGPointMake(self.rootNavigation.l_v_w/2, -self.rootNavigation.l_v_h/2);
    [shopUser l_c_setY:-self.rootNavigation.l_v_h/2];
    
    [self.rootNavigation.view alphaViewWithColor:[UIColor blackColor]];
    self.rootNavigation.view.alphaView.alpha=0;
    
    [self.rootNavigation.view addSubview:shopUser.view];
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        self.rootNavigation.view.alphaView.alpha=.7f;
        
        [shopUser l_c_setY:self.rootNavigation.l_v_h/2];
    }];
}

-(void)shopUserFinished
{
    [self dismissShopUser];
}

-(void)dismissShopUser
{
    if(shopUserController)
    {
        [UIView animateWithDuration:DURATION_DEFAULT animations:^{
            self.rootNavigation.view.alphaView.alpha=0;
            [shopUserController l_c_setY:-self.rootNavigation.l_v_h/2];
        } completion:^(BOOL finished) {
            
            [self.rootNavigation.view removeAlphaView];
            
            [shopUserController.view removeFromSuperview];
            [shopUserController removeFromParentViewController];
            shopUserController=nil;
        }];
    }
}

-(void)hideAdsWithDuration:(float)duration
{
    [UIView animateWithDuration:duration animations:^{
        [self.rootViewController.adsView l_c_addY:self.rootViewController.adsFrame.size.height];
        self.rootViewController.adsView.alpha=0;
    } completion:^(BOOL finished) {
        self.rootViewController.adsView.hidden=true;
    }];
}

-(void)showAdsWithDuration:(float)duration
{
    self.rootViewController.adsView.hidden=false;
    
    [UIView animateWithDuration:duration animations:^{
        self.rootViewController.adsView.frame=[self.rootViewController adsFrame];
        self.rootViewController.adsView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
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

@end