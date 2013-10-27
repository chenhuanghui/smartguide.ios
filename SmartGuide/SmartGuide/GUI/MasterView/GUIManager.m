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
@synthesize mainWindow,contentController,masterContainerView,masterNavigation,toolbarController,adsController,qrCodeController,settingController, userCollectionController,authorizationController,mapController;

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
    authorizationController=[[AuthorizationViewController alloc] initAuthorazion];
    TransportViewController *transport=[[TransportViewController alloc] initWithNavigation:authorizationController];
    
    [self.masterNavigation pushViewController:transport animated:true];
}

-(void)toolbarMap
{
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

@end