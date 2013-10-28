//
//  GUIManager.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NavigationViewController.h"
#import "DataManager.h"
#import "MasterContainerViewController.h"
#import "ToolbarViewController.h"
#import "SGAdsViewController.h"
#import "SGQRCodeViewController.h"
#import "SGSettingViewController.h"
#import "SGUserCollectionController.h"
#import "AuthorizationViewController.h"
#import "ContentViewController.h"
#import "SGMapController.h"

@class ContentViewController;

@interface GUIManager : NSObject<ToolbarDelegate,UINavigationControllerDelegate,SGSettingDelegate,ContentViewDelegate,SGQRCodeDelegate>

+(GUIManager*) shareInstance;
-(void) startupWithWindow:(UIWindow*) window;

@property (nonatomic, readonly) UIWindow *mainWindow;
@property (nonatomic, strong, readonly) ContentViewController *contentController;
@property (nonatomic, strong, readonly) MasterContainerViewController *masterContainerView;
@property (nonatomic, strong, readonly) ToolbarViewController *toolbarController;
@property (nonatomic, strong, readonly) SGAdsViewController *adsController;
@property (nonatomic, strong, readonly) SGQRCodeViewController *qrCodeController;
@property (nonatomic, strong, readonly) UINavigationController *masterNavigation;
@property (nonatomic, strong, readonly) SGSettingViewController *settingController;
@property (nonatomic, strong, readonly) SGUserCollectionController *userCollectionController;
@property (nonatomic, strong, readonly) AuthorizationViewController *authorizationController;
@property (nonatomic, strong, readonly) SGMapController *mapController;

@end