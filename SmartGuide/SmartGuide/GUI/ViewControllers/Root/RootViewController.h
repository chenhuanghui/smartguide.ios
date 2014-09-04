//
//  SGRootViewController.h
//  SmartGuide
//
//  Created by MacMini on 09/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ViewController.h"

@class RemoteNotificationView;

@class NavigationViewController,SGNavigationController, Shop, TabbarButton;

@interface RootViewController : ViewController
{
    __weak IBOutlet UIButton *btnBuildMode;
    __weak IBOutlet UIButton *btnNoti;
    __weak IBOutlet TabbarButton *btnTabHome;
    __weak IBOutlet TabbarButton *btnTabSearch;
    __weak IBOutlet TabbarButton *btnTabScan;
    __weak IBOutlet TabbarButton *btnTabInbox;
    __weak IBOutlet TabbarButton *btnTabUser;

    __weak RemoteNotificationView *remoteNotiView;
}

-(RootViewController*) init;
-(void) showSettingController;
-(void) hideSettingController;
//-(void) presentSGViewController:(SGViewController*) viewController;
-(void) dismissSGPresentedViewController:(void(^)()) onCompleted;
-(void) presentShopUserWithShop:(Shop*) shop;
-(void) presentShopUserWithIDShop:(int) idShop;
-(void) dismissShopUser;
-(void) showSearchShopWithKeywordsSearch:(NSString*) keywords;
-(void) showShopListWithKeywordsShopList:(NSString*) keywords;
-(void) showShopListWithIDPlace:(int) idPlacelist;
-(void) showShopListWithIDShops:(NSString*) idShops;
-(void) showShopListWithIDBranch:(int) idBranch;
-(void) showUserPromotion;
-(void) showUserSetting;
-(void) showTutorial;
-(void) showTerms;

@property (weak, nonatomic) IBOutlet UIView *containView;
@property (nonatomic, strong) SGNavigationController *contentNavigation;
@property (nonatomic, strong) NavigationViewController *settingController;
@property (nonatomic, strong) UITabBarController *tabbarController;

@end

@interface RootViewController(ScanController)

-(void) showScanController;
-(void) removeScanController:(bool) animate;

@end