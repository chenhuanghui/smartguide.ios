//
//  GUIManager.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataManager.h"
#import "SGToolbarViewController.h"
#import "SGAdsViewController.h"
#import "SGQRCodeViewController.h"
#import "SGSettingViewController.h"
#import "SGUserViewController.h"
#import "UserSettingViewController.h"
#import "AuthorizationViewController.h"
#import "ContentViewController.h"
#import "SGMapController.h"
#import "AlphaView.h"
#import "WelcomeViewController.h"
#import "SGViewController.h"
#import "SGLoadingScreenViewController.h"
#import "SGRootViewController.h"
#import "SGNotificationViewController.h"
#import "SGTutorialViewController.h"
#import "SGUserSettingViewController.h"
#import "StoreViewController.h"
#import "NewFeedViewController.h"
#import "SearchViewController.h"

@class ContentViewController;

@interface GUIManager : NSObject<ToolbarDelegate,UINavigationControllerDelegate,SGSettingDelegate,SGQRCodeControllerDelegate,UIGestureRecognizerDelegate,AuthorizationDelegate,WelcomeControllerDelegate,SGLoadingScreenDelegate,SGViewControllerDelegate,ShopUserDelegate,SGUserSettingControllerDelegate,NotificationControllerDelegate,UserControllerDelegate,StoreControllerDelegate,NewFeedControllerDelegate>
{
    void(^_onLoginedCompleted)(bool isLogined);
    CGRect _qrCodeBeforeShowFrame;
}

+(GUIManager*) shareInstance;
-(void) startupWithWindow:(UIWindow*) window;

-(void) displayViewController:(SGViewController*) viewController;
-(void) closeViewController:(SGViewController*) viewController;

-(void) presentViewController:(SGViewController*) viewController;
-(void) dismissPresentedViewController:(void(^)()) onCompleted;
-(void) presentShopUserWithShopList:(ShopList*) shopList;
-(void) presentShopUserWithShopUser:(Shop*) shop;
-(void) dismissShopUser;

-(void) showLoginDialogWithMessage:(NSString*) message onCompleted:(void(^)(bool isLogined)) onCompleted;

@property (nonatomic, readonly) UIWindow *mainWindow;
@property (nonatomic, weak, readonly) SGNavigationController *rootNavigation;
@property (nonatomic, weak, readonly) SGRootViewController *rootViewController;
@property (nonatomic, weak, readonly) SGToolbarViewController *toolbarController;
@property (nonatomic, weak, readonly) SGNavigationController *contentNavigation;
@property (nonatomic, weak, readonly) SGAdsViewController *adsController;
@property (nonatomic, weak, readonly) SGQRCodeViewController *qrCodeController;
@property (nonatomic, weak, readonly) ShopUserViewController *shopUserController;
@property (nonatomic, weak, readonly) SGUserViewController *userController;
@property (nonatomic, weak, readonly) SGNotificationViewController *notificationController;
@property (nonatomic, weak, readonly) StoreViewController *storeController;
@property (nonatomic, weak, readonly) SGTutorialViewController *tutorialController;
@property (nonatomic, weak, readonly) SGViewController *presentedViewController;
@end