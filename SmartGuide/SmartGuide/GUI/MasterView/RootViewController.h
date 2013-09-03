//
//  RootViewController.h
//  SmartGuide
//
//  Created by XXX on 7/27/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "PKRevealController.h"
#import "NavigationBarView.h"
#import "FilterViewController.h"
#import "DirectionObjectViewController.h"
#import "Constant.h"
#import "SearchViewController.h"

@class BannerAdsViewController,SlideQRCodeViewController,SettingViewController,LoginViewController,FrontViewController,DirectionObjectViewController,ShopDetailViewController,CatalogueListViewController,UserCollectionViewController;

@class QRCode;

@interface RootViewController : UIViewController<UIGestureRecognizerDelegate,NavigationBarDelegate,FilterDelegate,DirectionObjectDelegate,SearchViewDelegate,NavigationViewControllerDelegate,UISearchBarDelegate>
{
    bool _isShowedSetting;
    bool _isShowedQRSlide;
    bool _isShowedMap;
    bool _isShowedFilter;
    bool _isShowedDetailFromMap;
    bool _isShowedUserCollection;
    bool _isShowedDetailFromCollection;
    
    bool _isRootViewShowed;
    
    bool _isAnmationForSearch;
    int _lastIDCity;
}

+(void) startWithWindow:(UIWindow*) window;
+(RootViewController*) shareInstance;
-(RootViewController*) initWithWindow:(UIWindow*) window;

-(void) showLoadingScreen;
-(void) removeLoadingScreen;
-(void) setNeedRemoveLoadingScreen;

-(void) showQRSlide;
-(void) hideQRSlide;
-(bool) isShowedQRSlide;
-(void) showQRSlide:(bool) animated onCompleted:(void(^)(BOOL finished)) onCompleted;
-(void) hideQRSlide:(bool) animated onCompleted:(void(^)(BOOL finished)) onCompleted;

-(void) showMap;
-(void) hideMap;
-(void) hideMap:(bool) animate;
-(bool) isShowedMap;
-(void) showShopDetailFromMap;

-(void) showFilter;
-(void) hideFilter;
-(bool) isShowedFilter;

-(void) showUserCollection;
-(void) hideUserCollection;
-(bool) isShowedUserCollection;

-(void) showShopDetailFromUserCollection:(Shop*) shop;
-(void) showShopDetailFromUserCollection;//support qr code
-(void) hideShopDetailFromUserCollection;
-(bool) isShowedShopDetailFromUserCollection;

-(void) showSetting:(void(^)(BOOL finished)) onCompleted;
-(void) hideSetting:(void(^)(BOOL finished)) onCompleted;
-(bool) isShowedSetting;

-(void) showLogin;
-(void) showMainWithPreviousViewController:(UIViewController*) previous;

-(void) showWarningNotificationWithIcon:(UIImage *)icon content:(NSString *)content identity:(NSObject*)tag closedWhenTouch:(bool)closedWhenTouch;
-(void) hideNotificationWithIdentity:(NSObject*) tag;

-(bool) isShowedShopDetailFromMap;

//Su dung cho comment trong 1 shop detail
-(void) moveMyCommentToRootView:(UIView*) tableComment;
-(UIView*) giveARootView;
-(void) removeRootView:(UIView*) rootView;

-(void) restoreGesturePrevious;
-(float) heightAds_QR;

@property (nonatomic, readonly) BannerAdsViewController *bannerAds;
@property (nonatomic, readonly) SlideQRCodeViewController *slideQRCode;
@property (nonatomic, readonly) SettingViewController *settingViewController;
@property (nonatomic, readonly) FrontViewController *frontViewController;
@property (nonatomic, readonly) NavigationBarView *navigationBarView;
@property (nonatomic, readonly) FilterViewController *filter;
@property (nonatomic, readonly) UserCollectionViewController *userCollection;
@property (nonatomic, readonly) UIWindow *window;
@property (nonatomic, readonly) NSMutableArray *notifications;
@property (nonatomic, strong) DirectionObjectViewController *directionObject;
@property (nonatomic, strong) ShopDetailViewController *shopDetail;//được khởi tạo background khi Catalogue load
@property (nonatomic, readonly) SearchViewController *searchViewController;

@property (nonatomic, readonly) UIPanGestureRecognizer *panPrevious;
@property (nonatomic, readonly) UITapGestureRecognizer *tapSetting;
@property (nonatomic, readonly) UIPanGestureRecognizer *panSetting;

@end