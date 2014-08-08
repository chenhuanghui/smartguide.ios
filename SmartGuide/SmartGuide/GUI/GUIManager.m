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
#import "ASIOperationUserProfile.h"
#import "NotFound404ViewController.h"

static GUIManager *_shareInstance=nil;

@interface GUIManager()<WelcomeControllerDelegate,SGLoadingScreenDelegate,AuthorizationDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate,ASIOperationPostDelegate,WebViewDelegate, NotFound404ViewControllerDelegate>
{
    ASIOperationUserProfile *_opeUserProfile;
    void(^_onBack404)();
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

- (instancetype)init
{
    self = [super init];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:NOTIFICATION_REFRESH_TOKEN_FAILED object:nil];
    
    return self;
}

-(void)receiveNotification:(NSNotification*) notification
{
    if([notification.name isEqualToString:NOTIFICATION_REFRESH_TOKEN_FAILED])
    {
        [[ASIOperationManager shareInstance] clearAllOperation];
        [[TokenManager shareInstance] useDefaultToken];
        [User markDeleteAllObjects];
        [[DataManager shareInstance] save];
        [DataManager shareInstance].currentUser=nil;
        
        [self.mainWindow showLoading];
        
        [self requestUserProfile];
    }
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserProfile class]])
    {
        [self.mainWindow removeLoading];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_LOGOUT object:nil];
        [self showFirstController];
        _opeUserProfile=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserProfile class]])
    {
        User *user=[User insert];
        user.idUser=@(DEFAULT_USER_ID);
        user.idCity=@(DEFAULT_USER_IDCITY);
        
        [[DataManager shareInstance] save];
        
        [DataManager shareInstance].currentUser=user;
        
        [self.mainWindow removeLoading];
        [self showFirstController];
        _opeUserProfile=nil;
    }
}

-(void) requestUserProfile
{
    if(_opeUserProfile)
    {
        [_opeUserProfile clearDelegatesAndCancel];
        _opeUserProfile=nil;
    }
    
    _opeUserProfile=[[ASIOperationUserProfile alloc] initOperation];
    _opeUserProfile.delegate=self;
    
    [_opeUserProfile addToQueue];
}

-(void)startupWithWindow:(UIWindow *)window
{
    mainWindow=window;
    if(NSFoundationVersionNumber>NSFoundationVersionNumber_iOS_6_1)
        mainWindow.backgroundColor=[UIColor blackColor];
    else
        mainWindow.backgroundColor=[UIColor whiteColor];
    
    [[TokenManager shareInstance] checkToken];
    [[DataManager shareInstance] clean];
    
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

-(void)webviewTouchedBack:(WebViewController *)controller
{
    [self.rootNavigation dismissSGViewControllerAnimated:true completion:nil];
}

-(void)show404:(void (^)())onShow onBack:(void (^)())onBack
{
    NotFound404ViewController *vc=[NotFound404ViewController new];
    vc.delegate=self;
    
    if(onBack)
        _onBack404=[onBack copy];
    
    [self.rootNavigation pushViewController:vc onCompleted:^{
        if(onShow)
            onShow();
    }];
}

-(void)notFound404ControllerTouchedBack:(NotFound404ViewController *)controller
{
    if(self.rootNavigation.visibleViewController==controller)
        [self.rootNavigation popViewControllerAnimated:true];
    
    if(_onBack404)
    {
        _onBack404();
        _onBack404=nil;
    }
}

@end