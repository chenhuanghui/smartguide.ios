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
#import "ToolbarViewController.h"
#import "SGAdsViewController.h"
#import "SGQRCodeViewController.h"
#import "SGSettingViewController.h"
#import "UserViewController.h"
#import "UserSettingViewController.h"
#import "AuthorizationViewController.h"
#import "ContentViewController.h"
#import "SGMapController.h"
#import "PanDragViewHandle.h"
#import "AlphaView.h"
#import "WelcomeViewController.h"
#import "SGViewController.h"
#import "SGLoadingScreenViewController.h"
#import "SGRootViewController.h"

@class ContentViewController;

@interface GUIManager : NSObject<ToolbarDelegate,UINavigationControllerDelegate,SGSettingDelegate,ContentViewDelegate,SGQRCodeDelegate,PanDragViewDelegate,UIGestureRecognizerDelegate,AuthorizationDelegate,WelcomeControllerDelegate,SGLoadingScreenDelegate,SGViewControllerDelegate,ShopUserDelegate>
{
    UIPanGestureRecognizer *panGes;
    PanDragViewHandle *panHandle;
    void(^_onLoginedCompleted)(bool isLogined);
}

+(GUIManager*) shareInstance;
-(void) startupWithWindow:(UIWindow*) window;

-(void) presentShopUserWithIDShop:(int) idShop;
-(void) dismissShopUser;

-(void) hideAdsWithDuration:(float) duration;
-(void) showAdsWithDuration:(float) duration;
-(void) showLoginDialogWithMessage:(NSString*) message onCompleted:(void(^)(bool isLogined)) onCompleted;

@property (nonatomic, readonly) UIWindow *mainWindow;
@property (nonatomic, weak, readonly) SGNavigationController *rootNavigation;
@property (nonatomic, weak, readonly) SGRootViewController *rootViewController;
@property (nonatomic, weak, readonly) ToolbarViewController *toolbarController;
@property (nonatomic, weak, readonly) SGNavigationController *contentNavigation;
@property (nonatomic, weak, readonly) SGAdsViewController *adsController;
@property (nonatomic, weak, readonly) SGQRCodeViewController *qrCodeController;
@property (nonatomic, weak, readonly) ShopUserViewController *shopUserController;
@property (nonatomic, weak, readonly) UserViewController *userController;
@property (nonatomic, weak, readonly) UserSettingViewController *userSettingController;
@end