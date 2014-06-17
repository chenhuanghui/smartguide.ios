//
//  GUIManager.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "GUIManager.h"
#import "AlphaView.h"
#import "WelcomeViewController.h"
#import "LoadingScreenViewController.h"
#import "AuthorizationViewController.h"
#import "DataManager.h"
#import "LocationManager.h"

static GUIManager *_shareInstance=nil;

@interface GUIManager()<WelcomeControllerDelegate,SGLoadingScreenDelegate,AuthorizationDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate>
{
    
}

@property (nonatomic, weak) UIViewController *previousViewController;

@end

@implementation GUIManager
@synthesize mainWindow,rootNavigation,rootViewController;
@synthesize previousViewController;

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
    if(NSFoundationVersionNumber>NSFoundationVersionNumber_iOS_6_1)
        mainWindow.backgroundColor=[UIColor blackColor];
    else
        mainWindow.backgroundColor=[UIColor whiteColor];
    
    [[TokenManager shareInstance] checkToken];
    
    LoadingScreenViewController *loading=[[LoadingScreenViewController alloc] init];
    loading.delegate=self;
    
    SGNavigationController *rNavigation=[[SGNavigationController alloc] initWithRootViewController:loading];

    rootNavigation=rNavigation;
    
    if(NSFoundationVersionNumber>NSFoundationVersionNumber_iOS_6_1)
    {
        CGRect rect=CGRectZero;
        rect.origin=CGPointMake(0, UIStatusBarHeight());
        rect.size=UIApplicationSize();
        rootNavigation.view.frame=rect;
    }
    else
        [rootNavigation l_v_setS:window.l_v_s];
    rootNavigation.view.layer.masksToBounds=true;

    [mainWindow addSubview:rootNavigation.view];
//    mainWindow.rootViewController=rNavigation;
    [mainWindow makeKeyAndVisible];
}

-(void)logout
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_LOGOUT object:nil];
    [self showFirstController];
}

-(void) showFirstController
{
    NSMutableArray *viewControllers=[NSMutableArray array];
    
    switch (currentUser().enumDataMode) {
        case USER_DATA_TRY:
        {
            WelcomeViewController *welcome=[[WelcomeViewController alloc] init];
            welcome.delegate=self;
            
            [viewControllers addObject:welcome];
            
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        }
            break;
            
        case USER_DATA_CREATING:
        {
            AuthorizationViewController *author=[[AuthorizationViewController alloc] init];
            author.delegate=self;
            
            [viewControllers addObject:author];
        }
            break;
            
        case USER_DATA_FULL:
        {
            if([[NSUserDefaults standardUserDefaults] boolForKey:@"RegisterWillOpen"])
            {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RegisterWillOpen"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                AuthorizationViewController *author=[[AuthorizationViewController alloc] init];
                author.delegate=self;
                
                [viewControllers addObject:author];
            }
            else
            {
                [Flags setIDCitySearch:currentUser().idCity.integerValue];
                
                RootViewController *root=[RootViewController new];
                
                rootViewController=root;
                
                [viewControllers addObject:rootViewController];
            }
        }
            break;
    }
    
    [self.rootNavigation setRootViewControllers:viewControllers animate:true];
}

#pragma mark View Controller Delegate

#pragma mark Loading controller

-(void)SGLoadingFinished:(LoadingScreenViewController *)loadingScreen
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_INFORY_LAUNCHED object:nil];
    [self showFirstController];
}

#pragma mark Welcome controller

-(void)welcomeControllerTouchedLogin:(WelcomeViewController *)viewController
{
    [self showLoginController:transitionPushFromTop()];
}

-(void)welcomeControllerTouchedTry:(WelcomeViewController *)viewController
{
    [self showRootControlelr];
}

#pragma mark GUIManager function

-(void) showRootControlelr
{
    RootViewController *root=[RootViewController new];
    rootViewController=root;
    
    [self.rootNavigation setRootViewController:root animate:true];
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
    if(_onLoginedCompleted)
    {
        _onLoginedCompleted(false);
        _onLoginedCompleted=nil;
    }
    
    bool found=false;
    for(UIViewController *vc in self.rootNavigation.viewControllers)
        if([vc isKindOfClass:[WelcomeViewController class]])
        {
            found=true;
            break;
        }
    
    if(found)
        [self.rootNavigation popSGViewControllerWithTransition:transitionPushFromBottom()];
    else
        [self.rootNavigation popViewControllerAnimated:true];
}

-(void)presentSGViewController:(UIViewController *)controller completion:(void (^)())completed
{
    [self.rootNavigation presentSGViewController:controller completion:completed];
}

-(void)dismissSGViewControllerCompletion:(void (^)())onCompleted
{
    [self.rootNavigation dismissSGViewControllerCompletion:onCompleted];
}

-(void)showLoginDialogWithMessage:(NSString *)message onOK:(void (^)())onOK onCancelled:(void (^)())onCancelled onLogined:(void (^)(bool))onLogin
{
    _onLoginedCompleted=[onLogin copy];
    __block void(^_onOK)()=nil;
    __block void(^_onCancelled)()=nil;
    
    if(onOK)
        _onOK=[onOK copy];
    if(onCancelled)
        _onCancelled=[onCancelled copy];
    
    [AlertView showWithTitle:@"Thông báo" withMessage:message withLeftTitle:@"Huỷ" withRightTitle:@"Đồng ý" onOK:^{
        if(_onCancelled)
        {
            _onCancelled();
            _onCancelled=nil;
        }
        
        _onLoginedCompleted(false);
        _onLoginedCompleted=nil;
    } onCancel:^{
        if(_onOK)
        {
            _onOK();
            _onOK=nil;
        }
        
        [self showLoginController];
    }];
}

-(void) showLoginController
{
    [self showLoginController:nil];
}

-(void) showLoginController:(CATransition*) transition
{
    AuthorizationViewController *author=[AuthorizationViewController new];
    author.delegate=self;
    
    if(transition)
        [self.rootNavigation pushViewController:author withTransition:transition];
    else
        [self.rootNavigation pushViewController:author animated:true];
}

-(void) showLoginControll:(void(^)(bool isLogin)) onLogin
{
    if(onLogin)
        _onLoginedCompleted=[onLogin copy];
    
    [self showLoginController];
}

@end