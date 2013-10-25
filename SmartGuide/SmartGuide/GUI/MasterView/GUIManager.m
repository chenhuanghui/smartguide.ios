//
//  GUIManager.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "GUIManager.h"
#import "ContentViewController.h"

static GUIManager *_shareInstance=nil;
@implementation GUIManager
@synthesize mainWindow,contentController,masterContainerView,masterNavigation,toolbarController,adsController,qrCodeController,settingController;

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

-(void)toolbarSetting
{
    settingController=[[SGSettingViewController alloc] init];
    __block CGRect rect=settingController.view.frame;
    rect.origin.x=-rect.size.width;
    settingController.view.frame=rect;
    settingController.view.layer.masksToBounds=true;
    settingController.delegate=self;
    
    [self.mainWindow addSubview:settingController.view];
    
    [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
        rect=settingController.view.frame;
        rect.origin.x=0;
        settingController.view.frame=rect;
        self.masterNavigation.view.center=CGPointMake(self.masterNavigation.view.center.x+245, self.masterNavigation.view.center.y);
    }];
}

-(void)SGSettingHide
{
    [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
        CGRect rect=settingController.view.frame;
        rect.origin.x=-rect.size.width;
        settingController.view.frame=rect;
        
        self.masterNavigation.view.center=CGPointMake(self.masterNavigation.view.center.x-245, self.masterNavigation.view.center.y);
    } completion:^(BOOL finished) {
        
        settingController.delegate=nil;
        [settingController.view removeFromSuperview];
        [settingController removeFromParentViewController];
        settingController=nil;
        
    }];
    
}

@end