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
#import "PanDragViewHandle.h"
#import "AlphaView.h"

@class ContentViewController;

@interface GUIManager : NSObject<ToolbarDelegate,UINavigationControllerDelegate,SGSettingDelegate,ContentViewDelegate,SGQRCodeDelegate,PanDragViewDelegate,UIGestureRecognizerDelegate,AuthorizationDelegate>
{
    UIPanGestureRecognizer *panGes;
    PanDragViewHandle *panHandle;
}

+(GUIManager*) shareInstance;
-(void) startupWithWindow:(UIWindow*) window;
-(void) presentModalViewController:(UIViewController*) viewController animated:(BOOL)animated;
-(void) dismissModalViewController:(UIViewController*) viewController animated:(BOOL) animated;

@property (nonatomic, readonly) UIWindow *mainWindow;
@property (nonatomic, strong, readonly) ContentViewController *contentController;
@property (nonatomic, strong, readonly) MasterContainerViewController *masterContainerView;
@property (nonatomic, strong, readonly) ToolbarViewController *toolbarController;
@property (nonatomic, strong, readonly) SGAdsViewController *adsController;
@property (nonatomic, strong, readonly) SGQRCodeViewController *qrCodeController;
@property (nonatomic, strong, readonly) UINavigationController *masterNavigation;
@property (nonatomic, strong, readonly) SGSettingViewController *settingController;
@property (nonatomic, strong, readonly) SGUserCollectionController *userCollectionController;
@property (nonatomic, strong, readonly) SGMapController *mapController;

@property (nonatomic, readonly) bool isShowingMap;

@end