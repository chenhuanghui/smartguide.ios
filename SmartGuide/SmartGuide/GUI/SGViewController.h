//
//  SGViewController.h
//  SmartGuide
//
//  Created by MacMini on 28/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "Utility.h"
#import "LocalizationManager.h"
#import "AlertView.h"
#import "ImageManager.h"
#import "LoadingView.h"
#import "Flags.h"
#import "AlphaView.h"
#import "SGData.h"
#import "BasicAnimation.h"

@class SGViewController,SGNavigationController;

@protocol SGViewControllerHandle <NSObject>

-(void) navigationController:(SGNavigationController*) navigationController willPopController:(SGViewController*) controller;

@end

#define SCREEN_CODE_UNKNOW @""
#define SCREEN_CODE_HOME @"S001"
#define SCREEN_CODE_SUGGEST @"S002"
#define SCREEN_CODE_SHOP_LIST @"S003"
#define SCREEN_CODE_PLACE_LIST @"S004"
#define SCREEN_CODE_SHOP_USER @"S005"
#define SCREEN_CODE_SHOP_USER_DETAIL_INFO @"S00501"
#define SCREEN_CODE_SHOP_USER_MAP @"S00502"
#define SCREEN_CODE_SHOP_USER_COMMENT @"S00503"
#define SCREEN_CODE_SHOP_USER_COMMENT_SEND @"S0050301"
#define SCREEN_CODE_SHOP_USER_CAMERA @"S00504"
#define SCREEN_CODE_SHOP_USER_SHOP_GALLERY_FULL @"S00505"
#define SCREEN_CODE_SHOP_USER_USER_GALLERY @"S00506"
#define SCREEN_CODE_SHOP_USER_PROMOTION @"S00507"
#define SCREEN_CODE_SHOP_USER_USER_GALLERY_FULL @"S00508"
#define SCREEN_CODE_SHOP_USER_MAP_FULL @"S00509"
#define SCREEN_CODE_SHOP_USER_LOVE_SHOP @"S00510"
#define SCREEN_CODE_NOTIFICATION @"S006"
#define SCREEN_CODE_SCAN_CODE @"S007"
#define SCREEN_CODE_NAVIGATION @"S008"
#define SCREEN_CODE_NAVIGATION_USER @"S00801"
#define SCREEN_CODE_NAVIGATION_USER_SETTING @"S00802"
#define SCREEN_CODE_NAVIGATION_HOME @"S00803"
#define SCREEN_CODE_USER @"S009"
#define SCREEN_CODE_USER_USER_INFO @"S00901"
#define SCREEN_CODE_USER_USER_COLLECTION @"S00902"
#define SCREEN_CODE_USER_USER_HISTORY @"S00903"
#define SCREEN_CODE_USER_SETTING @"S010"
#define SCREEN_CODE_STORE_LIST @"S011"
#define SCREEN_CODE_STORE_LIST_LATEST @"S01101"
#define SCREEN_CODE_STORE_LIST_SELLERS @"S01102"
#define SCREEN_CODE_STORE_ITEM_LIST @"S012"
#define SCREEN_CODE_STORE_ITEM_LIST_LATEST @"S01201"
#define SCREEN_CODE_STORE_ITEM_LIST_SELLERS @"S01202"
#define SCREEN_CODE_STORE_ITEM_DETAIL @"S013"
#define SCREEN_CODE_STORE_CART @"S014"
#define SCREEN_CODE_WELCOME @"S015"
#define SCREEN_CODE_LOGIN @"S016"
#define SCREEN_CODE_ACTIVE @"S017"
#define SCREEN_CODE_SOCIAL @"S018"
#define SCREEN_CODE_REGISTER_USER @"S019"
#define SCREEN_CODE_RECOMMENDATION @"S020" //màn hình Search lúc chưa nhập keyword
#define SCREEN_CODE_USER_PROMOTION_LIST @"S021"

@class SGViewController,RemoteNotification;

@interface SGViewController : UIViewController<SGViewControllerHandle>
{
    bool _viewWillAppear;
    bool _viewWillDisappear;
}

-(id) initWithDelegate:(id<SGViewControllerDelegate>) delegate;
-(void) storeRect;

-(NSArray*) registerNotifications;
-(void) receiveNotification:(NSNotification*) notification;
-(SGNavigationController*) sgNavigationController;
-(bool) navigationWillBack;
-(void) viewWillAppearOnce;
-(void) viewWillDisappearOnce;
-(void) showActionSheet:(UIActionSheet*) actionSheet;

+(NSString*) screenCode;
-(void) receiveRemoteNotification:(RemoteNotification*) obj;
-(void) processRemoteNotification:(RemoteNotification*) obj;//user touch notification

@property (nonatomic, weak) id<SGViewControllerDelegate> delegate;

@end

@interface UIViewController(PresentViewController)

@property (nonatomic, readwrite, weak) UIViewController *presentSGViewControlelr;
@property (nonatomic, readwrite, weak) UIViewController *presentingSGViewController;

-(void)presentSGViewController:(UIViewController *)viewControllerToPresent completion:(void (^)(void))completion;
-(void)presentSGViewController:(UIViewController *)viewControllerToPresent animate:(bool) animated completion:(void (^)(void))completion;
-(void)presentSGViewController:(UIViewController *)viewControllerToPresent animation:(BasicAnimation*(^)()) animation completion:(void(^)()) completion;

-(void)dismissSGViewControllerCompletion:(void (^)(void))completion;
-(void)dismissSGViewControllerAnimated:(bool) animate completion:(void (^)(void))completion;
-(void)dismissSGViewControllerAnimation:(BasicAnimation*(^)()) animation completion:(void(^)()) completion;
-(void) presentSGViewControllerFinished;
-(float) alphaForPresentView;

@end