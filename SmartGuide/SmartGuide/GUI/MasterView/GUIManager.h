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
#import "SGQRCodeViewController.h"
#import "SGSettingViewController.h"
#import "SGUserViewController.h"
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
#import "HomeViewController.h"
#import "SearchViewController.h"
#import "UserPromotionViewController.h"

@class ContentViewController;

@interface GUIManager : NSObject<ToolbarDelegate,UINavigationControllerDelegate,SGSettingDelegate,UIGestureRecognizerDelegate,AuthorizationDelegate,WelcomeControllerDelegate,SGLoadingScreenDelegate,SGViewControllerDelegate,ShopUserDelegate,SGUserSettingControllerDelegate,NotificationControllerDelegate,UserControllerDelegate,StoreControllerDelegate,HomeControllerDelegate>
{
    void(^_onLoginedCompleted)(bool isLogined);
    CGRect _qrCodeBeforeShowFrame;
}

+(GUIManager*) shareInstance;
-(void) startupWithWindow:(UIWindow*) window;
-(void) logout;

-(void) presentViewController:(SGViewController*) viewController;
-(void) dismissPresentedViewController:(void(^)()) onCompleted;
-(void) presentShopUserWithShopList:(ShopList*) shopList;
-(void) presentShopUserWithShopUser:(Shop*) shop;
-(void) presentShopUserWithHome8:(UserHome8*) home8;
-(void) presentShopUserWithIDShop:(int) idShop;
-(void) dismissShopUser;
-(void) showStoreWithStore:(StoreShop*) store;
-(void) showShopListWithKeywork:(NSString*) keyword;

-(void) showLoginDialogWithMessage:(NSString*) message onOK:(void(^)()) onOK onCancelled:(void(^)()) onCancelled onLogined:(void(^)(bool isLogined)) onLogin;

@property (nonatomic, readonly) UIWindow *mainWindow;
@property (nonatomic, weak, readonly) SGNavigationController *rootNavigation;
@property (nonatomic, weak, readonly) SGRootViewController *rootViewController;
@property (nonatomic, weak, readonly) SGToolbarViewController *toolbarController;
@property (nonatomic, weak, readonly) SGNavigationController *contentNavigation;
@property (nonatomic, weak, readonly) SGQRCodeViewController *qrCodeController;
@property (nonatomic, weak, readonly) ShopUserViewController *shopUserController;
@property (nonatomic, weak, readonly) SGUserViewController *userController;
@property (nonatomic, weak, readonly) SGUserSettingViewController *userSettingController;
@property (nonatomic, weak, readonly) SGNotificationViewController *notificationController;
@property (nonatomic, weak, readonly) StoreViewController *storeController;
@property (nonatomic, weak, readonly) SGTutorialViewController *tutorialController;
@property (nonatomic, weak, readonly) UserPromotionViewController *userPromotionControlelr;
@property (nonatomic, weak, readonly) HomeViewController *homeController;
@end