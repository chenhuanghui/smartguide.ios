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
@synthesize mainWindow,contentController,masterContainerView,masterNavigation,toolbarController,adsController,qrCodeController;

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
    
    masterContainerView = [[MasterContainerViewController alloc] init];
    masterNavigation = [[UINavigationController alloc] initWithRootViewController:masterContainerView];
    [masterNavigation setNavigationBarHidden:true];
    
    masterContainerView.view.backgroundColor=COLOR_BACKGROUND_APP;
    
    contentController = [[ContentViewController alloc] init];
    [masterContainerView.contentView addSubview:contentController.view];
    
    toolbarController=[[ToolbarViewController alloc] init];
    [masterContainerView.toolbarView addSubview:toolbarController.view];
    
    adsController=[[SGAdsViewController alloc] init];
    [masterContainerView.adsView addSubview:adsController.view];
    
    qrCodeController=[[SGQRCodeViewController alloc] init];
    [masterContainerView.qrView addSubview:qrCodeController.view];
    
    window.rootViewController=masterNavigation;
    [window makeKeyAndVisible];
}

@end
