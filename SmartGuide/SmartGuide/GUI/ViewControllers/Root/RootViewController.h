//
//  SGRootViewController.h
//  SmartGuide
//
//  Created by MacMini on 09/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class RemoteNotificationView;

@class NavigationViewController,ScrollViewRoot,SGNavigationController;

@interface RootViewController : SGViewController
{   
    __weak IBOutlet ScrollViewRoot *scrollContent;
    __weak IBOutlet UIView *leftView;
    UITapGestureRecognizer *tapGes;
    bool _isAnimatingSetting;
    __weak IBOutlet UIButton *btnMakeNotification;
    
    __weak RemoteNotificationView *remoteNotiView;
    
#if DEBUG
    int _loopMakeNotification;
#endif
}

-(RootViewController*) init;
-(void) showSettingController;
-(void) hideSettingController;
-(void) presentSGViewController:(SGViewController*) viewController;
-(void) dismissSGPresentedViewController:(void(^)()) onCompleted;
-(void) presentShopUserWithShopList:(ShopList*) shopList;
-(void) presentShopUserWithShopUser:(Shop*) shop;
-(void) presentShopUserWithHome8:(UserHome8*) home8;
-(void) presentShopUserWithIDShop:(int) idShop;
-(void) dismissShopUser;
-(void) showSearchShopWithKeywordsSearch:(NSString*) keywords;
-(void) showShopListWithKeywordsShopList:(NSString*) keywords;
-(void) showShopListWithIDPlace:(int) idPlacelist;
-(void) showShopListWithIDShops:(NSString*) idShops;
-(void) showUserPromotion;
-(void) showUserSetting;
-(void) showTutorial;
-(void) showTerms;
-(void) showWebviewWithURL:(NSURL*) url;

@property (weak, nonatomic) IBOutlet UIView *containView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, strong) SGNavigationController *contentNavigation;

@property (nonatomic, readonly, assign) CGRect containFrame;
@property (nonatomic, readonly, assign) CGRect contentFrame;
@property (nonatomic, strong) NavigationViewController *settingController;

@end

@interface ScrollViewRoot : UIScrollView

@property (nonatomic, weak) RootViewController *root;

@end