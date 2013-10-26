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
@implementation GUIManager
@synthesize mainWindow,contentController,masterContainerView,masterNavigation,toolbarController,adsController,qrCodeController,settingController, userCollectionController,authorizationController;

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
    mainWindow.backgroundColor=COLOR_BACKGROUND_APP;

    if(NSFoundationVersionNumber>NSFoundationVersionNumber_iOS_6_1)
        mainWindow.center=CGPointMake(mainWindow.center.x, mainWindow.center.y+20);
    
    masterContainerView = [[MasterContainerViewController alloc] init];
    masterNavigation = [[UINavigationController alloc] initWithRootViewController:masterContainerView];
    [masterNavigation setNavigationBarHidden:true];
    
    masterContainerView.view.backgroundColor=COLOR_BACKGROUND_APP;
    
    contentController = [[ContentViewController alloc] init];
    [masterContainerView.contentView addSubview:contentController.view];
    contentController.contentDelegate=self;
    
    toolbarController=[[ToolbarViewController alloc] init];
    toolbarController.delegate=self;
    [masterContainerView.toolbarView addSubview:toolbarController.view];
    
    adsController=[[SGAdsViewController alloc] init];
    [masterContainerView.adsView addSubview:adsController.view];
    
    qrCodeController=[[SGQRCodeViewController alloc] init];
    [masterContainerView.qrView addSubview:qrCodeController.view];
    
    window.rootViewController=masterNavigation;
    [window makeKeyAndVisible];
    
    masterNavigation.delegate=self;
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
        [userCollectionController removeFromParentViewController];
        [userCollectionController.view removeFromSuperview];
        userCollectionController=nil;
        return;
    }
    
    masterContainerView.content_ads.hidden=false;
    
    userCollectionController=[[SGUserCollectionController alloc] init];
    [userCollectionController setNavigationBarHidden:true];
    CGRect rect=userCollectionController.view.frame;
    rect.size=masterContainerView.content_ads.frame.size;
    userCollectionController.view.frame=rect;

    [self.masterContainerView addChildViewController:userCollectionController];
    [self.masterContainerView.content_ads addSubview:userCollectionController.view];
}

-(void)toolbarUserLogin
{
    authorizationController=[[AuthorizationViewController alloc] initAuthorazion];
    TransportViewController *transport=[[TransportViewController alloc] initWithNavigation:authorizationController];
    
    [self.masterNavigation pushViewController:transport animated:true];
}

-(void)toolbarMap
{
    
}

-(void)SGSettingHided
{
    settingController.delegate=nil;
    settingController=nil;
}

@end