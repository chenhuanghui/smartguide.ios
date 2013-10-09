//
//  GUIManager.h
//  SmartGuide
//
//  Created by XXX on 7/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constant.h"
#import "NavigationViewController.h"
#import <MapKit/MapKit.h>
#import "PKRevealController.h"

@class BannerAds,PageControl,BottomBar,BannerBlock,CatalogueBlockViewController,DirectionObjectViewController,Group;
@class BannerAdsViewController,SlideQRCodeViewController,FilterViewController;

@interface GUIManager : NSObject<NavigationViewControllerDelegate,UIGestureRecognizerDelegate>
{
    CGPoint initialTouchMainLocation;
    CGPoint previousTouchMainLocation;
    CGPoint initialTouchSlideLocation;
    CGPoint previousTouchSlideLocation;
    bool _firstShowCatalogueBlock;
    bool _isShowedSliderQR;
    bool _isShowedCatalogueBlock;
    bool _isShowedFilter;
    bool _isShowedMap;
}

+(GUIManager*) shareInstance;

-(void) setBottomBarTitles:(NSArray*) titles;

-(void) startupWithWindow:(UIWindow*) window;
-(void) showWarningNotificationWithIcon:(UIImage *)icon content:(NSString *)content identity:(NSObject*)tag closedWhenTouch:(bool)closedWhenTouch;
-(void) hideNotificationWithIdentity:(NSObject*) tag;

-(void) showSetting;
-(void) hideSetting;
-(void) autoShowHideSetting;
-(bool) isShowingSetting;

-(bool) isShowingBottomBar;
-(bool) isShowingBannerAds;

-(void) backToPreviousTitle;
-(void) setNavigationTitle:(NSString*) naviTitle;

-(void) showCatalogueBlock:(bool) animated;
-(void) hideCatalogueBlock:(bool) animated;
-(bool) isShowedCatalogueBlock;

-(void)showFilter;
-(void)hideFilter;
-(bool) isShowedFilter;

-(void) showShopInGroup:(Group*) group;

-(float) navigationHeight;
-(CGSize) bottomBlockSize;

-(void) showMap;
-(void) hideMap;
-(bool) isShowedMap;

@property (nonatomic, assign) UIWindow *window;
@property (nonatomic, strong) NavigationViewController *mainNavigationController;
@property (nonatomic, strong) PKRevealController *pkRevealController;
@property (nonatomic, strong) BannerBlock *bannerBlock;
@property (nonatomic, strong) BottomBar *bottomBar;
@property (nonatomic, readonly) NSMutableArray *notifications;
@property (nonatomic, strong) CatalogueBlockViewController *catalogueBlock;
@property (nonatomic, strong) DirectionObjectViewController *directionShop;
@property (nonatomic, strong) BannerAdsViewController *bannerAds;
@property (nonatomic, strong) SlideQRCodeViewController *slideQRCode;
@property (nonatomic, strong) FilterViewController *filter;

@end