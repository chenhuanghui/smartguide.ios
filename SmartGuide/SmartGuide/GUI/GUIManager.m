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
    
    [[UIApplication sharedApplication] setStatusBarHidden:true];
    
    [[TokenManager shareInstance] checkToken];
    
    LoadingScreenViewController *loading=[[LoadingScreenViewController alloc] init];
    loading.delegate=self;
    
    SGNavigationController *rNavigation=[[SGNavigationController alloc] initWithRootViewController:loading];
    
    rootNavigation=rNavigation;
    rootNavigation.view.layer.masksToBounds=true;
    rootNavigation.view.layer.cornerRadius=4;
    
    mainWindow.rootViewController=rNavigation;
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
        }
            break;
            
        case USER_DATA_CREATING:
        {
            WelcomeViewController *welcome=[[WelcomeViewController alloc] init];
            welcome.delegate=self;
            
            [viewControllers addObject:welcome];
            
            AuthorizationViewController *author=[[AuthorizationViewController alloc] init];
            author.delegate=self;
            
            [viewControllers addObject:author];
        }
            break;
            
        case USER_DATA_FULL:
        {
            RootViewController *root=[RootViewController new];
            
            rootViewController=root;
            
            [viewControllers addObject:rootViewController];
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
    
    [AlertView showAlertOKCancelWithTitle:nil withMessage:message onOK:^{
        
        if(_onOK)
        {
            _onOK();
            _onOK=nil;
        }
        
        [self showLoginController];
    } onCancel:^{
        
        if(_onCancelled)
        {
            _onCancelled();
            _onCancelled=nil;
        }
        
        _onLoginedCompleted(false);
        _onLoginedCompleted=nil;
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