//
//  SGRootViewController.h
//  SmartGuide
//
//  Created by MacMini on 09/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "TextFieldSearch.h"

@class NavigationViewController,ScrollViewRoot,SGNavigationController;

@class NotificationInfo;

@interface RootViewController : SGViewController
{   
    __weak IBOutlet ScrollViewRoot *scrollContent;
    __weak IBOutlet UIView *leftView;
    UITapGestureRecognizer *tapGes;
    bool _isAnimatingSetting;
    __weak IBOutlet UIView *notiView;
    __weak IBOutlet TextFieldSearch *txtNoti;
    __weak IBOutlet UIButton *btnNoti;
    __weak IBOutlet UIButton *btnMakeNotification;
    
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
-(void) showShopListWithKeywordsSearch:(NSString*) keywords;
-(void) showShopListWithKeywordsShopList:(NSString*) keywords;
-(void) showShopListWithIDPlace:(int) idPlacelist;
-(void) showShopListWithIDShops:(NSString*) idShops;
-(void) showUserPromotion;
-(void) showUserSetting;
-(void) showTutorial;
-(void) showTerms;
-(void) showWebviewWithURL:(NSURL*) url;
-(void) processNotificationInfo:(NotificationInfo*) obj;

@property (weak, nonatomic) IBOutlet UIView *containView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, strong) SGNavigationController *contentNavigation;

@property (nonatomic, readonly, assign) CGRect containFrame;
@property (nonatomic, readonly, assign) CGRect contentFrame;
@property (nonatomic, strong) NavigationViewController *settingController;
@property (nonatomic, strong) NotificationInfo* visibleNotificaitonInfo;

@end

@interface ScrollViewRoot : UIScrollView
{
}

@end