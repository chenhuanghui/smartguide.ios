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
@synthesize mainWindow,contentController,masterContainerView,masterNavigation,toolbarController,adsController,qrCodeController,settingController, userCollectionController,mapController;
@synthesize previousViewController;
@synthesize isShowingMap;

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
    isShowingMap=false;
    
    mainWindow=window;
    mainWindow.backgroundColor=COLOR_BACKGROUND_APP;
    
    if(NSFoundationVersionNumber>NSFoundationVersionNumber_iOS_6_1)
        mainWindow.center=CGPointMake(mainWindow.center.x, mainWindow.center.y+20);
    
    CGRect rect=CGRectZero;
    
    masterContainerView = [[MasterContainerViewController alloc] init];
    masterNavigation = [[UINavigationController alloc] initWithRootViewController:masterContainerView];
    [masterNavigation setNavigationBarHidden:true];
    
    masterContainerView.view.backgroundColor=COLOR_BACKGROUND_APP;
    
    window.rootViewController=masterNavigation;
    [window makeKeyAndVisible];
    
    masterNavigation.delegate=self;
    
    contentController = [[ContentViewController alloc] init];
    [contentController setNavigationBarHidden:true];
    
    rect=masterContainerView.contentFrame;
    rect.origin=CGPointZero;
    contentController.view.frame=rect;
    
    [contentController showShopController];
    
    [masterContainerView.contentView addSubview:contentController.view];
    contentController.contentDelegate=self;
    
    toolbarController=[[ToolbarViewController alloc] init];
    toolbarController.delegate=self;
    [masterContainerView.toolbarView addSubview:toolbarController.view];
    
    adsController=[[SGAdsViewController alloc] init];
    [masterContainerView.adsView addSubview:adsController.view];
    
    qrCodeController=[[SGQRCodeViewController alloc] init];
    qrCodeController.delegate=self;
    [masterContainerView.qrView addSubview:qrCodeController.view];
    
    mapController=[[SGMapController alloc] init];
    [masterContainerView.mapView addSubview:mapController.view];
    
    rect=masterContainerView.mapFrame;
    rect.origin=CGPointMake(0, rect.size.height-10);
    mapController.view.frame=rect;
    
    if([AuthorizationViewController isNeedFillInfo])
    {
        AuthorizationViewController *authorization=[[AuthorizationViewController alloc] init];
        [authorization showCreateUser];
        
        authorization.delegate=self;
        
        TransportViewController *transport=[[TransportViewController alloc] initWithNavigation:authorization];
        
        [self.masterNavigation pushViewController:transport animated:false];
    }
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
    settingController=[[SGSettingViewController alloc] init];
    settingController.delegate=self;
    
    [settingController showSettingWithContaintView:self.mainWindow slideView:self.masterNavigation.view];
}

-(void)toolbarUserCollection
{
    if(userCollectionController)
    {
        [UIView animateWithDuration:DURATION_DEFAULT animations:^{
            userCollectionController.view.center=CGPointMake(userCollectionController.view.center.x, -userCollectionController.view.frame.size.height/2);
        } completion:^(BOOL finished) {
            [userCollectionController removeFromParentViewController];
            [userCollectionController.view removeFromSuperview];
            userCollectionController=nil;
            masterContainerView.content_ads_upper.hidden=true;
        }];
        return;
    }
    
    masterContainerView.content_ads_upper.hidden=false;
    
    userCollectionController=[[SGUserCollectionController alloc] init];
    [userCollectionController setNavigationBarHidden:true];
    CGRect rect=userCollectionController.view.frame;
    rect.size=masterContainerView.content_ads_upper.frame.size;
    rect.origin=CGPointMake(0, -rect.size.height);
    userCollectionController.view.frame=rect;
    
    [self.masterContainerView addChildViewController:userCollectionController];
    [self.masterContainerView.content_ads_upper addSubview:userCollectionController.view];
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        userCollectionController.view.center=CGPointMake(userCollectionController.view.center.x, userCollectionController.view.frame.size.height/2);
    }];
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
    [self.masterNavigation popViewControllerAnimated:true];
}

-(void)authorizationCancelled
{
    [self.masterNavigation popViewControllerAnimated:true];
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    return;
    int idx=[self.masterNavigation.viewControllers indexOfObject:viewController];
    
    idx--;
    
    if(idx<0)
        idx=0;
    
    UIViewController *previousVC=self.masterNavigation.viewControllers[idx];
    
    if(previousVC!=viewController)
    {
        self.previousViewController=previousVC;
        if([viewController isKindOfClass:[AuthorizationViewController class]])
        {
            [self removePanGes_Handle];
        
            [self applyPanGes_HandleWithCurrentView:previousViewController.view withOtherView:viewController.view];
            
            previousViewController.view.center=CGPointMake(-self.masterNavigation.view.frame.size.width/2, previousViewController.view.center.y);
            [self.masterNavigation.view addSubview:previousViewController.view];
        }
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

-(void) applyPanGes_HandleWithCurrentView:(UIView*) currentView withOtherView:(UIView*) otherView
{
    panGes=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGes:)];
    panGes.delegate=self;
    
    [self.masterNavigation.view addGestureRecognizer:panGes];
    
    panHandle=[[PanDragViewHandle alloc] initWithDirection:PanGestureDirectionToLeft withCurrentView:currentView withOtherView:otherView];
    panHandle.delegate=self;
}

-(void) panGes:(UIPanGestureRecognizer*) ges
{
    [panHandle handlePanGesture:ges];
}

-(void)toolbarMap
{
    if(self.isShowingMap)
    {
        masterContainerView.ads_mapView.mapView.userInteractionEnabled=false;
        
        [UIView animateWithDuration:DURATION_DEFAULT animations:^{
            CGRect rect=masterContainerView.mapFrame;
            rect.origin=CGPointMake(0, rect.size.height-10);
            mapController.view.frame=rect;
        } completion:^(BOOL finished) {
            [mapController.mapViewController removeMap];
            
            isShowingMap=false;
        }];
    }
    else
    {
        [mapController .mapViewController addMap];
        
        masterContainerView.ads_mapView.mapView.userInteractionEnabled=true;
        
        [UIView animateWithDuration:DURATION_DEFAULT animations:^{
            mapController.view.center=CGPointMake(mapController.view.center.x, mapController.view.frame.size.height/2);
        } completion:^(BOOL finished) {
            
            isShowingMap=true;
        }];
    }
    return;
    if(mapController)
    {
        [UIView animateWithDuration:DURATION_DEFAULT animations:^{
            mapController.view.center=CGPointMake(mapController.view.center.x, mapController.view.center.y+mapController.view.frame.size.height);
        } completion:^(BOOL finished) {
            [mapController removeFromParentViewController];
            [mapController.view removeFromSuperview];
            mapController=nil;
            self.masterContainerView.mapView.hidden=true;
        }];
        return;
    }
    
    mapController=[[SGMapController alloc] init];
    [mapController setNavigationBarHidden:true];
    CGRect rect=self.masterContainerView.mapFrame;
    rect.origin=CGPointMake(0, rect.size.height);
    
    mapController.view.frame=rect;
    
    [self.masterContainerView addChildViewController:mapController];
    [self.masterContainerView.mapView addSubview:mapController.view];
    
    
    self.masterContainerView.mapView.hidden=false;
    [UIView animateWithDuration:0.3f animations:^{
        mapController.view.center=CGPointMake(mapController.view.center.x, mapController.view.frame.size.height/2);
    }];
}

-(void)SGSettingHided
{
    settingController.delegate=nil;
    settingController=nil;
}

-(void)presentModalViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.masterContainerView addChildViewController:viewController];
    
    [self.masterContainerView.view alphaViewWithColor:[UIColor blackColor]];
    self.masterContainerView.view.alphaView.alpha=0;
    
    viewController.view.center=CGPointMake(self.masterContainerView.view.frame.size.width/2, -self.masterContainerView.view.frame.size.height/2);
    
    [self.masterContainerView.view addSubview:viewController.view];
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        self.masterContainerView.view.alphaView.alpha=0.7f;
        float otherHeight=self.masterContainerView.view.frame.size.height-viewController.view.frame.size.height;
        otherHeight/=2;
        viewController.view.center=CGPointMake(viewController.view.center.x, self.masterContainerView.view.frame.size.height/2-otherHeight);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)dismissModalViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if([self.masterContainerView.childViewControllers containsObject:viewController])
    {
        [UIView animateWithDuration:DURATION_DEFAULT animations:^{
            self.masterContainerView.view.alphaView.alpha=0;
            viewController.view.center=CGPointMake(viewController.view.center.x, -self.masterContainerView.view.frame.size.height/2);
        } completion:^(BOOL finished) {
            [self.masterContainerView.view removeAlphaView];
            
            [viewController removeFromParentViewController];
            [viewController.view removeFromSuperview];
        }];
    }
}

@end