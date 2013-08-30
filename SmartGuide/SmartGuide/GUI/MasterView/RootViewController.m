//
//  RootViewController.m
//  SmartGuide
//
//  Created by XXX on 7/27/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "RootViewController.h"
#import "BannerAdsViewController.h"
#import "SlideQRCodeViewController.h"
#import "SettingViewController.h"
#import "LoginViewController.h"
#import "FrontViewController.h"
#import "NavigationBarView.h"
#import "DirectionObjectViewController.h"
#import "AlphaView.h"
#import "NotificationViewController.h"
#import "FacebookMiningViewController.h"
#import "LocationManager.h"
#import "Flags.h"
#import "ShopDetailViewController.h"
#import "TokenManager.h"
#import "UserCollectionViewController.h"
#import "LoadingScreenViewController.h"

static RootViewController *_rootViewController;
@interface RootViewController ()

@property (nonatomic, readonly) UIPanGestureRecognizer *panSlide;
@property (nonatomic, readonly) CGPoint initialTouchSlide;
@property (nonatomic, readonly) CGPoint previousTouchSlide;
@property (nonatomic, readonly) CGPoint initialTouchPrevious;
@property (nonatomic, readonly) CGPoint previousTouchPrevious;
@property (nonatomic, readonly) CGPoint initialTouchSetting;
@property (nonatomic, readonly) CGPoint previousTouchSetting;
@property (nonatomic, strong) LoadingScreenViewController *loadingScreen;

@end

@implementation RootViewController
@synthesize bannerAds,slideQRCode,settingViewController,frontViewController,navigationBarView,searchViewController;
@synthesize panSlide,initialTouchSlide,previousTouchSlide,panPrevious,initialTouchPrevious,previousTouchPrevious,userCollection;
@synthesize directionObject;
@synthesize filter;
@synthesize tapSetting,panSetting,initialTouchSetting,previousTouchSetting;
@synthesize window;
@synthesize notifications;
@synthesize shopDetail;
@synthesize loadingScreen;

+(void)startWithWindow:(UIWindow *)window
{
    RootViewController *root=[[RootViewController alloc] initWithWindow:window];
    
    [root settting];
    
    window.rootViewController=root;
    [window makeKeyAndVisible];
    
    [DataManager shareInstance].currentUser=[User userWithIDUser:[Flags lastIDUser]];
    
    [root createLoading];
    
    //Lần đầu đăng nhập, database model đổi->drop database(remove token)
    if([DataManager shareInstance].currentUser==nil)
    {
        [root showLogin];
    }
    else
    {
        if(![DataManager shareInstance].currentUser.isConnectedFacebook.boolValue)
        {
            [root showFacebookMiningWithPreviousViewController:nil];
        }
        else
        {
            [root showMainWithPreviousViewController:nil];
        }
    }
    
    [root showLoadingScreen];
}

-(void) createLoading
{
    self.loadingScreen=[[LoadingScreenViewController alloc] init];
}

-(void)showLoadingScreen
{
    CGPoint pnt=self.view.center;
    pnt.x+=self.view.frame.size.width;
    self.view.center=pnt;
    
    [self.loadingScreen view];
    self.loadingScreen.view.frame=self.window.frame;
    
    [self.window addSubview:self.loadingScreen.view];
    pnt=self.loadingScreen. view.center;
    pnt.y+=20;
    self.loadingScreen.view.center=pnt;
}

-(void)removeLoadingScreen
{
    if(!self.loadingScreen)
        return;
    
    [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
        self.view.center=CGPOINT_PHONE(CGPointMake(160, 250), CGPointMake(160, 260+(548-480)/2));
        self.loadingScreen.view.center=CGPointMake(-self.loadingScreen.view.frame.size.width/2, self.loadingScreen.view.center.y);
    } completion:^(BOOL finished) {
        [self.loadingScreen.view removeFromSuperview];
        self.loadingScreen=nil;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOADING_SCREEN_FINISHED object:nil];
    }];
}

-(void)setNeedRemoveLoadingScreen
{
    if(self.loadingScreen)
    {
        if([self.loadingScreen isAnimationFinished])
            [self removeLoadingScreen];
        else
            self.loadingScreen.isNeedRemove=true;
    }
}

-(RootViewController *)initWithWindow:(UIWindow *)_window
{
    self=[RootViewController shareInstance];
    
    window=_window;
    
    return self;
}

+(RootViewController *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _rootViewController=[[RootViewController alloc] init];
    });
    
    return _rootViewController;
}

- (id)init
{
    self = [super init];
    if (self) {
        notifications=[[NSMutableArray alloc] init];
    }
    return self;
}

-(void) settting
{
    self.window.backgroundColor=COLOR_BACKGROUND_APP;
    [[UIApplication sharedApplication] setStatusBarHidden:false];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void) showLogin
{
    LoginViewController *loginViewController=[[LoginViewController alloc] init];
    
    [self addChildViewController:loginViewController];
    
    [self.view addSubview:loginViewController.view];
    
    __block __weak id notification=[[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_LOGIN object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        
        if([DataManager shareInstance].currentUser.isConnectedFacebook.boolValue)
            [self showMainWithPreviousViewController:loginViewController];
        else
        {
            [self showFacebookMiningWithPreviousViewController:loginViewController];
        }
        
        [[NSNotificationCenter defaultCenter] removeObserver:notification];
        notification=nil;
    }];
}

-(void) showFacebookMiningWithPreviousViewController:(UIViewController*) previous
{
    FacebookMiningViewController *face=[[FacebookMiningViewController alloc] init];
    
    [self addChildViewController:face];
    [self.view addSubview:face.view];
    
    if(previous)
    {
        [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
            CGPoint pnt=previous.view.center;
            pnt.x=-previous.view.frame.size.width;
            previous.view.center=pnt;
            
            pnt=face.view.center;
            pnt.x=[UIScreen mainScreen].bounds.size.width/2;
            face.view.center=pnt;
            
            previous.view.alpha=0;
        } completion:^(BOOL finished) {
            [previous removeFromParentViewController];
            [previous.view removeFromSuperview];
        }];
    }
    else
    {
        CGPoint pnt=face.view.center;
        pnt.x=[UIScreen mainScreen].bounds.size.width/2;
        face.view.center=pnt;
    }
    __block __weak id notiFace=[[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_FACEBOOK_UPLOAD_PROFILE_FINISHED object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        
        [self showMainWithPreviousViewController:face];
        
        [[NSNotificationCenter defaultCenter] removeObserver:notiFace];
        notiFace=nil;
    }];
}

-(void) showMainWithPreviousViewController:(UIViewController*) previous
{
    CGRect rect=CGRectZero;
    float naviHeight=[NavigationBarView height];
    
    
    if(!self.navigationBarView)
    {
        navigationBarView=[[NavigationBarView alloc] init];
        navigationBarView.delegate=self;
    }
    
    frontViewController=[[FrontViewController alloc] init];
    
    [self addChildViewController:frontViewController];
    [self.view addSubview:frontViewController.view];
    
    [frontViewController view];
    rect=self.view.frame;
    rect.origin.x=320;
    rect.origin.y=naviHeight;
    rect.size.height=rect.size.height-[self heightAds_QR];
    frontViewController.view.frame=rect;
    
    rect.origin=CGPointZero;
    [frontViewController setFrame:rect];
    
    if(!self.bannerAds)
    {
        bannerAds=[[BannerAdsViewController alloc] init];
        
        [self addChildViewController:bannerAds];
        [self.view addSubview:bannerAds.view];
    }
    
    rect=bannerAds.view.frame;
    rect.origin.x=320;
    rect.origin.y=self.view.frame.size.height-[BannerAdsViewController size].height-naviHeight+24.5f;
    bannerAds.view.frame=rect;
    
    if(!self.filter)
    {
        filter=[[FilterViewController alloc] init];
        
        [self addChildViewController:filter];
        [self.view addSubview:filter.view];
        
        filter.view.hidden=true;
    }
    
    if(!self.userCollection)
    {
        userCollection=[[UserCollectionViewController alloc] init];
        
        [self addChildViewController:userCollection];
        [self.view addSubview:userCollection.view];
        
        userCollection.view.hidden=true;
    }
    
    [self.view addSubview:navigationBarView];
    
    rect.origin=CGPointMake(320, 0);
    rect.size=CGSizeMake(self.view.frame.size.width, naviHeight);
    navigationBarView.frame=rect;
    
    if(!self.slideQRCode)
    {
        slideQRCode=[[SlideQRCodeViewController alloc] init];
        
        [self addChildViewController:slideQRCode];
        [self.view addSubview:slideQRCode.view];
        
        panSlide=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panSlide:)];
        panSlide.delegate=self;
        
        [[slideQRCode view] addGestureRecognizer:panSlide];
    }
    
    rect=slideQRCode.view.frame;
    rect.origin.x=320;
    rect.origin.y=[UIScreen mainScreen].bounds.size.height-[SlideQRCodeViewController size].height-25;
    slideQRCode.view.frame=rect;
    
    if(previous)
    {
        [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
            
            CGRect rectAnim=previous.view.frame;
            rectAnim.origin.x=-rectAnim.size.width;
            previous.view.frame=rectAnim;
            
            rectAnim=frontViewController.view.frame;
            rectAnim.origin.x=0;
            frontViewController.view.frame=rectAnim;
            
            rectAnim=navigationBarView.frame;
            rectAnim.origin.x=0;
            navigationBarView.frame=rectAnim;
            
            rectAnim=bannerAds.view.frame;
            rectAnim.origin.x=0;
            bannerAds.view.frame=rectAnim;
            
            rectAnim=slideQRCode.view.frame;
            rectAnim.origin.x=0;
            slideQRCode.view.frame=rectAnim;
            
            previous.view.alpha=0;
        } completion:^(BOOL finished) {
            
            [previous removeFromParentViewController];
            [previous.view removeFromSuperview];
            
            settingViewController=[[SettingViewController alloc] init];
            [self.window insertSubview:settingViewController.view atIndex:0];
            CGRect rect=self.settingViewController.view.frame;
            rect.origin.x=-20;
            rect.origin.y=20;
            settingViewController.view.frame=rect;
            settingViewController.view.hidden=true;
        }];
    }
    else
    {
        CGRect rectAnim=frontViewController.view.frame;
        rectAnim.origin.x=0;
        frontViewController.view.frame=rectAnim;
        
        rectAnim=navigationBarView.frame;
        rectAnim.origin.x=0;
        navigationBarView.frame=rectAnim;
        
        rectAnim=bannerAds.view.frame;
        rectAnim.origin.x=0;
        bannerAds.view.frame=rectAnim;
        
        rectAnim=slideQRCode.view.frame;
        rectAnim.origin.x=0;
        slideQRCode.view.frame=rectAnim;
        
        settingViewController=[[SettingViewController alloc] init];
        [self.window insertSubview:settingViewController.view atIndex:0];
        settingViewController.view.frame=CGRectMake(-20, 20, settingViewController.view.frame.size.width, settingViewController.view.frame.size.height);
        settingViewController.view.hidden=true;
    }
    
    panPrevious=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPrevious:)];
    panPrevious.delegate=self;

    [panPrevious requireGestureRecognizerToFail:panSlide];
    
    [self.window addGestureRecognizer:panPrevious];
}

-(void) tapSetting:(UITapGestureRecognizer*) tap
{
    switch (tap.state) {
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        {
            CGRect rect=self.settingViewController.view.frame;
            rect.origin=CGPointZero;
            CGPoint pnt=[tap locationInView:self.settingViewController.view];
            if(!CGRectContainsPoint(rect, pnt))
                [self hideSetting:nil];
        }
            break;
            
        default:
            break;
    }
}

-(void) panSetting:(UIPanGestureRecognizer*) pan
{
    switch (pan.state) {
            
        case UIGestureRecognizerStateBegan:
        {
            initialTouchSetting=[pan locationInView:self.window];
            previousTouchSetting=initialTouchSetting;
            
            [self.settingViewController.view alphaViewWithColor:COLOR_BACKGROUND_APP_ALPHA(0)];
            [self.view alphaViewWithColor:COLOR_BACKGROUND_APP_ALPHA(fabsf(self.view.frame.origin.x/SCREEN_WIDTH))];
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGPoint currentLocation=[pan locationInView:self.window];
            float delta=currentLocation.x-previousTouchSetting.x;
            previousTouchSetting=currentLocation;
            
            if(self.view.frame.origin.x+delta>self.settingViewController.view.frame.size.width)
                return;
            
            CGPoint pnt=self.view.center;
            pnt.x+=delta;
            self.view.center=pnt;
            
            [self.settingViewController.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(fabsf(self.settingViewController.view.frame.origin.x/SCREEN_WIDTH));
            [self.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(fabsf(self.view.frame.origin.x/SCREEN_WIDTH));
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        {
            float velocity=[pan velocityInView:self.window].x;
            
            if(velocity<-VELOCITY_SLIDE)
            {
                pan.enabled=false;
                
                [self hideSetting:^(BOOL finished) {
                    pan.enabled=true;
                }];
            }
            else
            {
                if(self.view.frame.origin.x<[UIScreen mainScreen].bounds.size.width/2)
                {
                    pan.enabled=false;
                    [self hideSetting:^(BOOL finished) {
                        pan.enabled=true;
                    }];
                }
                else
                {
                    pan.enabled=false;
                    [self showSetting:^(BOOL finished) {
                        pan.enabled=true;
                    }];
                }
            }
        }
            
        default:
            break;
    }
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if(gestureRecognizer==self.tapSetting)
    {
        if([self.settingViewController isShowOtherView])
            return false;
        CGPoint pnt=[gestureRecognizer locationInView:self.settingViewController.view];
        if(!CGRectContainsPoint(self.settingViewController.view.frame, pnt))
            return true;
        
        return false;
    }
    
    if(gestureRecognizer==self.panSetting)
    {
        if([self.settingViewController isShowOtherView])
            return false;
        
        CGPoint pnt=[self.panSetting translationInView:self.panSetting.view];
        
        if(pnt.x>0)
            return false;
        
        pnt=[self.panSetting locationInView:self.settingViewController.view];
        
        return !CGRectContainsPoint(self.settingViewController.view.frame, pnt);
    }
    
    if(gestureRecognizer==self.panSlide)
    {
        if(self.slideQRCode.isUserScanded)
            return false;
        
        CGPoint pnt=[gestureRecognizer locationInView:self.slideQRCode.view];
        if([self isShowedQRSlide])
        {
            pnt=[self.panSlide translationInView:self.slideQRCode.view];
            
            if(pnt.y<0)
                return false;
            
            return fabsf(pnt.y)>fabsf(pnt.x);
        }
        else
        {
            if(CGRectContainsPoint(self.slideQRCode.btnSlide.frame,pnt))
            {
                pnt=[self.panSlide translationInView:self.slideQRCode.view];
                
                if(pnt.y>0)
                    return false;
                
                return true;
            }
        }
        
        return false;
    }
    
    if(gestureRecognizer==self.panPrevious)
    {
        if(self.frontViewController.isPushingViewController)
            return false;
        
        if([self isShowedSetting])
            return false;
        
        if([self isShowedFilter])
            return false;
        
        if([self isShowedQRSlide])
            return false;
        
        if([self isShowedUserCollection])
            return false;
        
        return [self.frontViewController handlePanGestureShouldBegin:self.panPrevious];
    }
    
    return true;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if(gestureRecognizer==panPrevious || otherGestureRecognizer==panPrevious)
        return false;
    
    return true;
}

-(void)showSetting:(void(^)(BOOL finished)) onCompleted
{
    _isShowedSetting=true;
    
    if(!tapSetting)
    {
        tapSetting=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSetting:)];
        tapSetting.delegate=self;
        [self.window addGestureRecognizer:tapSetting];
    }
    
    if(!panSetting)
    {
        panSetting=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panSetting:)];
        panSetting.delegate=self;
        [panSetting requireGestureRecognizerToFail:tapSetting];
        [self.window addGestureRecognizer:panSetting];
    }
    
    self.view.userInteractionEnabled=false;
    
    [self.view alphaViewWithColor:COLOR_BACKGROUND_APP_ALPHA(0)];
    [self.settingViewController.view alphaViewWithColor:COLOR_BACKGROUND_APP_ALPHA(1)];
    
    self.settingViewController.view.hidden=false;
    
    _lastIDCity=[DataManager shareInstance].currentCity.idCity.integerValue;
    [self.settingViewController loadSetting];
    
    [UIView animateWithDuration:DURATION_SHOW_SETTING delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect rect=self.view.frame;
        rect.origin.x=245;
        self.view.frame=rect;
        [self.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(fabsf(self.view.frame.origin.x/SCREEN_WIDTH));
        
        rect=settingViewController.view.frame;
        rect.origin.x=0;
        settingViewController.view.frame=rect;
        [settingViewController.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(0);
    } completion:^(BOOL finished) {
        [self.settingViewController.view removeAlphaView];
        
        if(onCompleted)
            onCompleted(finished);
        
        [self.settingViewController viewWillAppear:true];
    }];
}

-(void) hideSetting:(void(^)(BOOL finished)) onCompleted
{
    _isShowedSetting=false;
    
    self.view.userInteractionEnabled=true;
    
    [self.settingViewController.view alphaViewWithColor:COLOR_BACKGROUND_APP_ALPHA(0)];
    [self.view alphaViewWithColor:COLOR_BACKGROUND_APP_ALPHA(1)];
    
    [UIView animateWithDuration:DURATION_SHOW_SETTING delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect rect=self.view.frame;
        rect.origin.x=0;
        self.view.frame=rect;
        [self.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(0.f);
        
        rect=settingViewController.view.frame;
        rect.origin.x=-20;
        settingViewController.view.frame=rect;
        
        [settingViewController.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(1);
    } completion:^(BOOL finished) {
        [self.view removeAlphaView];
         [self.settingViewController.view removeAlphaView];
        
        if(self.tapSetting)
        {
            [self.window removeGestureRecognizer:self.tapSetting];
            tapSetting=nil;
        }
        
        self.settingViewController.view.hidden=true;
        
        //oncompleted enable pan
        if(onCompleted)
            onCompleted(finished);
        
        if(self.panSetting)
        {
            [self.window removeGestureRecognizer:self.panSetting];
            panSetting=nil;
        }
        
        //không sử dụng notification vì settingviewcontroller đã xử lý
        //user change city
//        if(_lastIDCity!=[DataManager shareInstance].currentCity.idCity.integerValue)
//        {
//            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_CHANGED_CITY object:nil];
//        }
        
        _lastIDCity=[DataManager shareInstance].currentCity.idCity.integerValue;
    }];
}

-(bool)isShowedSetting
{
    return _isShowedSetting;
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

#pragma mark NavigationView delegate

-(void)navigationBarList:(UIButton *)sender
{
    if([self isShowedMap])
        [self hideMap];
    
    if([self isShowedFilter])
        [self hideFilter];
    
    if([self isShowedUserCollection])
        [self hideUserCollection];
//    if(![self.frontViewController isShowedCatalogueBlock])
//        [self.frontViewController showCatalogueBlock:false];
}

- (void)navigationBarUserCollection:(UIButton *)sender
{
    if(_isShowedDetailFromCollection)
    {
        [self showUserCollectionFromShopDetail:nil];
        return;
    }
    
    if([self isShowedUserCollection])
        [self hideUserCollection];
    else
        [self showUserCollection];
}

-(void)hideUserCollection
{
    [self hideUserCollection:nil];
}

-(void)navigationBarCatalogue:(UIButton *)sender
{
    
}

-(void)navigationBarFilter:(UIButton *)sender
{
    if([self isShowedFilter])
        [self hideFilter];
    else
        [self showFilter];
}

-(void)navigationBarMap:(UIButton *)sender
{
    if([self isShowedMap])
        [self hideMap];
    else
        [self showMap];
}

-(void) showMap
{
    if([self.frontViewController.catalogueList currentShops].count==0)
        return;
    
    _isShowedMap=true;
    
    [bannerAds prepareShowMap];

    [self.directionObject loadWithShops:[self.frontViewController.catalogueList currentShops]];
    
    [self.bannerAds configMenu];
    [UIView animateWithDuration:DURATION_SHOW_MAP animations:^{
        [bannerAds showMap];
    } completion:^(BOOL finished) {
        [bannerAds addMap];
    }];
    
    directionObject.delegate=self;
}

-(void)hideMap:(bool)animate
{
    _isShowedMap=false;
    [bannerAds hideMap:animate];
    directionObject.delegate=nil;
    
    if(animate)
        [[self.frontViewController currentVisibleViewController] configMenu];
}

-(void)hideMap
{
    [self hideMap:true];
}

-(bool)isShowedMap
{
    return _isShowedMap;
}

-(void)navigationBarSearch:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self.navigationBarView setSearchKeyword:[Flags keywordSearch]];
    [self.navigationBarView showSearchWithDelegate:self];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self searchView:searchViewController selectedShop:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [Flurry trackUserSearch:searchBar.text];
    [Flags setKeywordSearch:searchBar.text];
    [searchViewController search:searchBar.text];
}

-(void)searchView:(SearchViewController *)searchView selectedShop:(Shop *)shop
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [searchViewController cancelSearch];
    [self.navigationBarView hideSearch];
    
    _isAnmationForSearch=true;
    
    if([self.frontViewController isShowedCatalogueBlock])
        [self.frontViewController hideCatalogueBlock:false];
    
    if([self isShowedFilter])
        [self hideFilter:false completed:nil];
    
    //vi tri shopdetail ko dung khi hide khong animation
    if([self isShowedShopDetailFromMap])
        [self showMapFromShopDetail:false onCompleted:nil];
    
    if([self isShowedMap])
        [self hideMap:false];
    
    if([self isShowedShopDetailFromUserCollection])
        [self showUserCollectionFromShopDetail:false completed:nil];
    
    if([self isShowedUserCollection])
        [self hideUserCollection:false completed:nil];
    
    _isAnmationForSearch=false;
    
    [UIView animateWithDuration:0.3f animations:^{
        searchViewController.view.alpha=0;
    } completion:^(BOOL finished) {
        [searchViewController.view removeFromSuperview];
        [searchViewController removeFromParentViewController];
        searchViewController=nil;
    }];
    
    if(!shop)
        return;
    
    shop.selected=true;
    
    [self.frontViewController.catalogueList handleSearchResult:searchView.searchText result:searchView.result page:searchView.page selectedShop:shop selectedRow:searchView.selectedRow];
    
    if([[self.frontViewController currentVisibleViewController] isKindOfClass:[ShopDetailViewController class]])
    {
        CGRect rect=self.shopDetail.view.frame;
        rect.origin=CGPointZero;
        self.shopDetail.view.frame=rect;
        [self.shopDetail setShop:shop];
    }
    else
    {
        [self.frontViewController.catalogueList pushShopDetailWithShop:shop animated:false];
    }
}

-(void) keyboardWillShow:(NSNotification*) notification
{
    if(searchViewController)
        return;
    
    CGRect rect=CGRectZero;
    rect.origin.y=[NavigationBarView height];
    rect.size.width=self.view.frame.size.width;
    rect.size.height=self.view.frame.size.height-[NavigationBarView height];
    
    searchViewController=[[SearchViewController alloc] init];
    [self addChildViewController:searchViewController];
    [searchViewController view];
    searchViewController.view.frame=rect;
    searchViewController.delegate=self;
    
    if(self.frontViewController.catalogueList.templateSearch)
    {
        [searchViewController handleResult:self.frontViewController.catalogueList.templateSearch.datasource text:self.frontViewController.catalogueList.templateSearch.searchKey page:self.frontViewController.catalogueList.templateSearch.page];
    }
    
    [self.view addSubview:searchViewController.view];
    
    searchViewController.view.alpha=0;
    [UIView animateWithDuration:0.3f	 animations:^{
        searchViewController.view.alpha=1;
        CGRect r=searchViewController.view.frame;
        r.size.height=self.view.frame.size.height-[NavigationBarView height];
        searchViewController.view.frame=r;
    }];
}

-(void) keyboardWillHide:(NSNotification*) notification
{

}

-(void)navigationBarSetting:(UIButton *)sender
{
    if([self isShowedSetting])
        [self hideSetting:nil];
    else
        [self showSetting:nil];
}

-(void)showUserCollection
{
    if([self isShowedFilter])
    {
        [self hideFilter:^{
            [self showUserCollection];
        }];
        
        return;
    }
    
    _isShowedUserCollection=true;
    
    [self.userCollection loadUserCollection];
    
    CGRect rect=self.userCollection.view.frame;
    rect.size.height=[UIScreen mainScreen].bounds.size.height-[NavigationBarView height]-[SlideQRCodeViewController size].height+20;
    rect.origin.y=-rect.size.height;
    self.userCollection.view.frame=rect;
    
    AlphaView *alphaView=[self.userCollection.view makeAlphaView];
    alphaView.backgroundColor=COLOR_BACKGROUND_APP_ALPHA(1);
    
    alphaView=[self.view makeAlphaViewBelowView:self.userCollection.view];
    alphaView.backgroundColor=COLOR_BACKGROUND_APP_ALPHA(0);
    
    self.userCollection.view.hidden=false;
    
    [self.userCollection configMenu];
    
    [UIView animateWithDuration:DURATION_SHOW_FILTER animations:^{
        CGRect rectAnim=self.userCollection.view.frame;
        rectAnim.origin.y=[NavigationBarView height];
        
        self.userCollection.view.frame=rectAnim;
        
        [self.userCollection.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(0);
        [self.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(1);
    } completion:^(BOOL finished) {
        [self.userCollection.view removeAlphaView];
        [self.view removeAlphaView];
    }];
}

-(void)showFilter
{
    if([self isShowedUserCollection])
    {
        [self hideUserCollection:^{
            [self showFilter];
        }];
        return;
    }
    
    _isShowedFilter=true;
    
    [self.filter loadFilter];
    self.filter.delegate=self;
    
    CGRect rect=self.filter.view.frame;
    rect.origin.y=-rect.size.height-[NavigationBarView height];
    rect.size.height=[UIScreen mainScreen].bounds.size.height-[NavigationBarView height]-[SlideQRCodeViewController size].height+20;
    self.filter.view.frame=rect;
    
    rect.origin=CGPointZero;
    
    [self.filter.view alphaViewWithColor:COLOR_BACKGROUND_APP_ALPHA(1)];
    [self.view alphaViewWithColor:COLOR_BACKGROUND_APP_ALPHA(0) belowView:self.filter.view];
    
    self.filter.view.hidden=false;
    [self.filter configMenu];
    [UIView animateWithDuration:DURATION_SHOW_FILTER animations:^{
        CGRect rectAnim=self.filter.view.frame;
        rectAnim.origin.y=[NavigationBarView height];
        
        self.filter.view.frame=rectAnim;
        
        [self.filter.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(0);
        [self.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(1);
    } completion:^(BOOL finished) {
        [self.filter.view removeAlphaView];
        [self.view removeAlphaView];
    }];
}

-(void)filterDone
{
    [self hideFilter];
}

-(void) hideUserCollection:(bool) animate completed:(void(^)()) onCompleted
{
    _isShowedUserCollection=false;
    
    if(animate)
    {
        [self.view alphaViewWithColor:COLOR_BACKGROUND_APP_ALPHA(1) belowView:self.userCollection.view];
        [self.userCollection.view alphaViewWithColor:COLOR_BACKGROUND_APP_ALPHA(0)];
        [[self.frontViewController currentVisibleViewController] configMenu];
        
        [UIView animateWithDuration:DURATION_SHOW_FILTER animations:^{
            CGRect rect=self.userCollection.view.frame;
            rect.origin.y=-rect.size.height;
            self.userCollection.view.frame=rect;
            [self.userCollection.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(1);
            [self.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(0);
        } completion:^(BOOL finished) {
            [self.userCollection.view removeAlphaView];
            [self.view removeAlphaView];
            
            if(onCompleted)
                onCompleted();
        }];
    }
    else
    {
        CGRect rect=self.userCollection.view.frame;
        rect.origin.y=-rect.size.height;
        self.userCollection.view.frame=rect;
        
        [self.userCollection.view removeAlphaView];
        [self.view removeAlphaView];
    }
}

-(void)hideUserCollection:(void(^)()) onCompleted
{
    [self hideUserCollection:true completed:onCompleted];
}

-(bool)isShowedUserCollection
{
    return _isShowedUserCollection;
}

-(void)hideFilter
{
    [self hideFilter:nil];
}

-(void) hideFilter:(bool) animate completed:(void(^)()) onCompleted
{
    _isShowedFilter=false;
    
    if(animate)
    {
        [self.filter.view alphaViewWithColor:COLOR_BACKGROUND_APP_ALPHA(0)];
        [self.view alphaViewWithColor:COLOR_BACKGROUND_APP_ALPHA(1) belowView:self.filter.view];
        [[self.frontViewController currentVisibleViewController] configMenu];
        
        [UIView animateWithDuration:DURATION_SHOW_FILTER animations:^{
            CGRect rect=self.filter.view.frame;
            rect.origin.y=-rect.size.height;
            self.filter.view.frame=rect;
            [self.filter.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(1);
            [self.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(0);
        } completion:^(BOOL finished) {
            [self.filter.view removeAlphaView];
            [self.view removeAlphaView];
            
            if(onCompleted)
            {
                onCompleted();
            }
        }];
    }
    else
    {
        CGRect rect=self.filter.view.frame;
        rect.origin.y=-rect.size.height;
        self.filter.view.frame=rect;
        
        [self.filter.view removeAlphaView];
        [self.view removeAlphaView];
    }
}

-(void) hideFilter:(void(^)()) onCompleted
{
    [self hideFilter:true completed:onCompleted];
}

-(bool)isShowedFilter
{
    return _isShowedFilter;
}

#pragma mark QRSlide

-(void) panSlide:(UIPanGestureRecognizer*) pan
{
    CGRect rect;
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            initialTouchSlide=[pan locationInView:self.view.window];
            previousTouchSlide=initialTouchSlide;
            
            AlphaView *alphaView=(AlphaView*)[self.view alphaView];
            if(!alphaView)
            {
                rect=self.view.frame;
                rect.origin=CGPointZero;
                alphaView=[[AlphaView alloc] initWithFrame:rect];
                
                if([self isShowedQRSlide])
                    alphaView.backgroundColor=COLOR_BACKGROUND_APP_ALPHA(1);
                else
                    alphaView.backgroundColor=COLOR_BACKGROUND_APP_ALPHA(0);
                
                [self.view insertSubview:alphaView belowSubview:self.slideQRCode.view];
            }
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGPoint currentLocation=[pan locationInView:self.view.window];
            
            float delta=currentLocation.y-previousTouchSlide.y;
            previousTouchSlide=currentLocation;
            
            if(self.slideQRCode.view.frame.origin.y+delta<0)
                return;
            
            AlphaView *containtView=(AlphaView*)[self.view viewWithTag:ALPHA_TAG];
            
            float alpha=([UIScreen mainScreen].bounds.size.height-self.slideQRCode.view.frame.origin.y)/[UIScreen mainScreen].bounds.size.height;
            containtView.backgroundColor=COLOR_BACKGROUND_APP_ALPHA(alpha);
            
            alpha=([UIScreen mainScreen].bounds.size.height-self.slideQRCode.view.frame.origin.y)/[UIScreen mainScreen].bounds.size.height;
            
            rect=self.slideQRCode.view.frame;
            rect.origin.y+=delta;
            
            self.slideQRCode.view.frame=rect;
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        {
            float velocity=[pan velocityInView:pan.view].y;
            
            if(_isShowedQRSlide)
            {
                if(velocity>0 && velocity>800)
                {
                    pan.enabled=false;
                    
                    [self hideQRSlide:true onCompleted:^(BOOL finished) {
                        pan.enabled=true;
                    }];
                }
                else
                {
                    if(self.slideQRCode.view.frame.origin.y>[UIScreen mainScreen].bounds.size.height/2)
                    {
                        pan.enabled=false;
                        [self hideQRSlide:true onCompleted:^(BOOL finished) {
                            pan.enabled=true;
                        }];
                    }
                    else
                    {
                        pan.enabled=false;
                        
                        [self showQRSlide:true onCompleted:^(BOOL finished) {
                            pan.enabled=true;
                        }];
                    }
                    
                }
            }
            else
            {
                if(velocity<0 && velocity<-800)
                {
                    pan.enabled=false;
                    
                    [self showQRSlide:true onCompleted:^(BOOL finished) {
                        pan.enabled=true;
                    }];
                }
                else
                {
                    if(self.slideQRCode.view.frame.origin.y<[UIScreen mainScreen].bounds.size.height-[UIScreen mainScreen].bounds.size.height/3)
                    {
                        pan.enabled=false;
                        [self showQRSlide:true onCompleted:^(BOOL finished) {
                            pan.enabled=true;
                        }];
                    }
                    else
                    {
                        pan.enabled=false;
                        
                        [self hideQRSlide:true onCompleted:^(BOOL finished) {
                            pan.enabled=true;
                        }];
                    }
                }
            }
        }
            break;
            
        default:
            self.panSlide.enabled=true;
            break;
    }
}

-(void) showMapFromShopDetail:(bool) animated onCompleted:(void(^)(BOOL finished)) onCompleted
{
    _isShowedDetailFromMap=false;
    _isShowedMap=true;
    
    if(animated)
    {
        [self.bannerAds.view alphaViewWithColor:COLOR_BACKGROUND_APP_ALPHA(1)];
        [self.frontViewController.view alphaViewWithColor:COLOR_BACKGROUND_APP_ALPHA(0)];
        [self.bannerAds configMenu];
        
        [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
            self.bannerAds.view.center=CGPOINT_PHONE(CGPointMake(160, 243),CGPointMake(160,self.bannerAds.view.center.y));
            self.frontViewController.view.center=CGPOINT_PHONE(CGPointMake(480, 249),CGPointMake(480,self.frontViewController.view.center.y));
            
            [self.bannerAds.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(0);
            [self.frontViewController.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(1);
        } completion:^(BOOL finished) {
            
            [self.bannerAds.view removeAlphaView];
            [self.frontViewController.view removeAlphaView];
            
            [self.frontViewController popViewControllerAnimated:false];
            self.frontViewController.view.center=CGPOINT_PHONE(CGPointMake(160, 249),CGPointMake(160,self.frontViewController.view.center.y));
            
            onCompleted(finished);
        }];
    }
    else
    {
        self.bannerAds.view.center=CGPOINT_PHONE(CGPointMake(160, 243),CGPointMake(160,self.bannerAds.view.center.y));
        self.frontViewController.view.center=CGPOINT_PHONE(CGPointMake(480, 249),CGPointMake(480,self.frontViewController.view.center.y));
        
        [self.bannerAds.view removeAlphaView];
        [self.frontViewController.view removeAlphaView];
        
        //gay ra animtion pop
        //        [self.frontViewController popViewControllerAnimated:false];
        self.frontViewController.view.center=CGPOINT_PHONE(CGPointMake(160, 249),CGPointMake(160,self.frontViewController.view.center.y));
    }
}

-(void) showShopDetailFromMap:(bool) animated onCompleted:(void(^)(BOOL finished)) onCompleted
{
    _isShowedDetailFromMap=true;
    
    [[self.frontViewController currentVisibleViewController] configMenu];
    [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
        self.bannerAds.view.center=CGPOINT_PHONE(CGPointMake(-160, 243),CGPointMake(-160,self.bannerAds.view.center.y));
        self.frontViewController.view.center=CGPOINT_PHONE(CGPointMake(160, 249),CGPointMake(160,self.frontViewController.view.center.y));
        
        [self.bannerAds.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(1);
        [self.frontViewController.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(0);
    } completion:^(BOOL finished) {
        
        [self.frontViewController.view removeAlphaView];
        [self.bannerAds.view removeAlphaView];
        self.bannerAds.view.hidden=true;
        
        onCompleted(finished);
    }];
}

-(void) hideQRSlide:(bool) animated onCompleted:(void(^)(BOOL finished)) onCompleted
{
    NSLog(@"hideQRSlide");
    _isShowedQRSlide=false;
    
    self.slideQRCode.btnSlide.enabled=false;
    
    if(animated)
    {
        [self.view alphaViewWithColor:COLOR_BACKGROUND_APP_ALPHA(1) belowView:self.slideQRCode.view];
        
        [UIView animateWithDuration:DURATION_SHOW_SLIDE_QRCODE delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect rect=self.slideQRCode.view.frame;
            rect.origin.y=[UIScreen mainScreen].bounds.size.height-[SlideQRCodeViewController size].height-25;
            self.slideQRCode.view.frame=rect;
            
//            [self.slideQRCode.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(1);
            [self.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(0);
            
        } completion:^(BOOL finished) {
            
            [self.slideQRCode hideCamera];
            
            [self.view removeAlphaView];
//            [self.slideQRCode.view removeAlphaView];
            
            if(onCompleted)
                onCompleted(finished);
            
            self.slideQRCode.btnSlide.enabled=true;
        }];
    }
}

-(bool)isShowedQRSlide
{
    return _isShowedQRSlide;
}

-(void) showQRSlide:(bool) animated onCompleted:(void(^)(BOOL finished)) onCompleted
{
    NSLog(@"showQRSlide");
    
    _isShowedQRSlide=true;
    
    self.slideQRCode.btnSlide.enabled=false;
    self.slideQRCode.delegate=self.frontViewController.catalogueList;

    if(animated)
    {
        [self.view alphaViewWithColor:COLOR_BACKGROUND_APP_ALPHA(0) belowView:self.slideQRCode.view];
        
        [UIView animateWithDuration:DURATION_SHOW_SLIDE_QRCODE delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect rect=self.slideQRCode.view.frame;
            rect.origin.y=0;
            self.slideQRCode.view.frame=rect;
            
            [self.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(1);
            
        } completion:^(BOOL finished) {
            
            [self.slideQRCode showCamera];
            
            if(onCompleted)
                onCompleted(finished);
            
            self.slideQRCode.btnSlide.enabled=true;
        }];
    }
}

-(void)showQRSlide
{
    [self showQRSlide:true onCompleted:nil];
}

-(void)hideQRSlide
{
    [self hideQRSlide:true onCompleted:nil];
}

#pragma mark Announcement

-(void) showWarningNotificationWithIcon:(UIImage *)icon content:(NSString *)content identity:(NSObject *)tag closedWhenTouch:(bool)closedWhenTouch
{
    NotificationViewController *annou = [[NotificationViewController alloc] initWithType:NOTIFICATION_WARNING withImage:icon withContent:content];
    annou.tag=tag;
    annou.closedWhenTouched=closedWhenTouch;
    
    [notifications addObject:annou];
    
    if(notifications.count==1)
    {
        [self showAnnouncement:annou];
    }
}

-(void) showAnnouncement:(NotificationViewController*) annou
{
    //load view
    [annou view];
    
    float navigationBarHeight=[NavigationBarView height];
    float statusBarHeight=[[UIApplication sharedApplication] isStatusBarHidden]?0:20;
    
    CGRect rect=annou.view.frame;
    rect.origin.y=navigationBarHeight+statusBarHeight;
    annou.view.frame=rect;
    
    [self.view addSubview:annou.view];
}

-(void)hideNotificationWithIdentity:(NSObject *)tag
{
    for(int i=0;i<notifications.count;i++)
    {
        NotificationViewController *annou = [notifications objectAtIndex:i];
        
        if(annou.tag && annou.tag==tag)
        {
            if(i==0)// displayed on screen
                [annou hide];
            else
                [notifications removeObjectAtIndex:i];
        }
    }
}

-(ViewController*) visibleViewController
{
    return (ViewController*) self.frontViewController.visibleViewController;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return toInterfaceOrientation==UIInterfaceOrientationPortrait || toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationPortrait|UIInterfaceOrientationPortraitUpsideDown;
}

-(BOOL)shouldAutorotate
{
    return true;
}

-(void)moveMyCommentToRootView:(UIView *)tableComment
{
    [tableComment removeFromSuperview];
    [self.view insertSubview:tableComment belowSubview:self.slideQRCode.view];
}

-(DirectionObjectViewController *)directionObject
{
    if(!directionObject)
    {
        self.directionObject=[[DirectionObjectViewController alloc] initDirectionObject];
        [directionObject view];
    }
    
    return directionObject;
}

-(UIView *)giveARootView
{
    _isRootViewShowed=true;
    
    UIView *vi=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    vi.backgroundColor=[UIColor clearColor];
    
    [self.view addSubview:vi];
    
    return vi;
}

-(void)removeRootView:(UIView *)rootView
{
    _isRootViewShowed=false;
    
    [rootView removeFromSuperview];
}

-(void) processSlideUserCollection:(UIPanGestureRecognizer*) pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            initialTouchPrevious=[pan locationInView:self.view.window];
            previousTouchPrevious=initialTouchPrevious;
            
            self.userCollection.view.hidden=false;
            AlphaView *alpha=[self.frontViewController.view makeAlphaView];
            alpha.backgroundColor=COLOR_BACKGROUND_APP_ALPHA(0);
            
            alpha=[self.userCollection.view makeAlphaView];
            alpha.backgroundColor=COLOR_BACKGROUND_APP_ALPHA(1);
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGPoint currentLocation=[pan locationInView:self.view.window];
            
            float delta=currentLocation.x-previousTouchPrevious.x;
            previousTouchPrevious=currentLocation;
            
            if(self.frontViewController.view.center.x+delta<160 || _isRootViewShowed)
                return;
            
            if(![[self.frontViewController currentVisibleViewController] allowDragPreviousView:pan])
                return;
            
            
            CGPoint pnt=self.frontViewController.view.center;
            pnt.x+=delta;
            self.frontViewController.view.center=pnt;
            
            pnt=self.userCollection.view.center;
            pnt.x+=delta;
            self.userCollection.view.center=pnt;
            
            float alpha=([UIScreen mainScreen].bounds.size.width-self.frontViewController.view.frame.origin.x)/[UIScreen mainScreen].bounds.size.width;
            
            [self.frontViewController.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(fabsf(1-alpha));
            [self.userCollection.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(alpha);
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        {
            float velocity=[pan velocityInView:pan.view].x;
            
            if(velocity>0 && velocity>800)
            {
                pan.enabled=false;
                
                [self showUserCollectionFromShopDetail:^(BOOL finished) {
                    pan.enabled=true;
                }];
            }
            else
            {
                if(self.userCollection.view.frame.origin.x>[UIScreen mainScreen].bounds.size.width/2)
                {
                    pan.enabled=false;
                    
                    [self showUserCollectionFromShopDetail:^(BOOL finished) {
                        pan.enabled=true;
                    }];
                }
                else
                {
                    pan.enabled=false;
                    
                    [self hideUserCollectionFromShopDetail:^(BOOL finished) {
                        pan.enabled=true;
                    }];
                }
                
            }
        }
            break;
            
        default:
            self.panPrevious.enabled=true;
            break;
    }
}

-(void) processSlidePreviousMap:(UIPanGestureRecognizer*) pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            initialTouchPrevious=[pan locationInView:self.view.window];
            previousTouchPrevious=initialTouchPrevious;
            
            [self.bannerAds addMap];
            
            self.bannerAds.view.hidden=false;
            AlphaView *alpha=(AlphaView*)[self.frontViewController.view viewWithTag:ALPHA_TAG];
            if(!alpha)
            {
                CGRect rect=self.frontViewController.view.frame;
                rect.origin=CGPointZero;
                alpha=[[AlphaView alloc] initWithFrame:rect];
                [self.frontViewController.view addSubview:alpha];
            }
            
            alpha.backgroundColor=COLOR_BACKGROUND_APP_ALPHA(0);
            
            alpha=(AlphaView*)[self.bannerAds.view viewWithTag:ALPHA_TAG];
            if(!alpha)
            {
                CGRect rect=self.bannerAds.view.frame;
                rect.origin=CGPointZero;
                alpha=[[AlphaView alloc] initWithFrame:rect];
                [self.bannerAds.view addSubview:alpha];
            }
            
            alpha.backgroundColor=COLOR_BACKGROUND_APP_ALPHA(1);
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGPoint currentLocation=[pan locationInView:self.view.window];
            
            float delta=currentLocation.x-previousTouchPrevious.x;
            previousTouchPrevious=currentLocation;
            
            if(self.frontViewController.view.center.x+delta<160 || _isRootViewShowed)
                return;
            
            if(![[self.frontViewController currentVisibleViewController] allowDragPreviousView:pan])
                return;
            
            
            CGPoint pnt=self.frontViewController.view.center;
            pnt.x+=delta;
            self.frontViewController.view.center=pnt;
            
            pnt=self.bannerAds.view.center;
            pnt.x+=delta;
            self.bannerAds.view.center=pnt;
            
            float alpha=([UIScreen mainScreen].bounds.size.width-self.frontViewController.view.frame.origin.x)/[UIScreen mainScreen].bounds.size.width;
            [self.frontViewController.view viewWithTag:ALPHA_TAG].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(fabsf(1-alpha));
            [self.bannerAds.view viewWithTag:ALPHA_TAG].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(alpha);
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        {
            float velocity=[pan velocityInView:pan.view].x;
            
            if(velocity>0 && velocity>800)
            {
                pan.enabled=false;
                
                [self showMapFromShopDetail:true onCompleted:^(BOOL finished) {
                    pan.enabled=true;
                }];
            }
            else
            {
                if(self.bannerAds.view.frame.origin.x>[UIScreen mainScreen].bounds.size.width/2)
                {
                    pan.enabled=false;
                    
                    [self showMapFromShopDetail:true onCompleted:^(BOOL finished) {
                        pan.enabled=true;
                    }];
                }
                else
                {
                    pan.enabled=false;
                    
                    [self showShopDetailFromMap:true onCompleted:^(BOOL finished){
                        pan.enabled=true;
                    }];
                }
                
            }
        }
            break;
            
        default:
            self.panPrevious.enabled=true;
            break;
    }
}

-(void) panPrevious:(UIPanGestureRecognizer*) pan
{
    if([self isShowedShopDetailFromMap])
    {
        [self processSlidePreviousMap:pan];
        return;
    }
    
    if([self isShowedShopDetailFromUserCollection])
    {
        [self processSlideUserCollection:pan];
        return;
    }
    
    if([self isShowedMap])
        return;

    [self.frontViewController handlePanGesture:pan];
}

-(void)directionObjectDetail:(Shop *)shop
{
    if(_isShowedDetailFromMap)
        return;
    
    _isShowedDetailFromMap=true;
    _isShowedMap=false;
    
    if([self.frontViewController isShowedCatalogueBlock])
    {
        [self.frontViewController hideCatalogueBlock:false];
    }
    
    self.shopDetail.shoplMode=SHOPDETAIL_FROM_MAP;
    [self.shopDetail removeFromParentViewController];
    [self.shopDetail.view removeFromSuperview];
    [self.shopDetail setShop:shop];
    
    [self.frontViewController pushViewController:self.shopDetail animated:false];
    self.frontViewController.delegate=self;
}

-(bool)isShowedShopDetailFromUserCollection
{
    return _isShowedDetailFromCollection;
}

-(void) showUserCollectionFromShopDetail:(bool) animated completed:(void(^)(BOOL finished)) onCompleted
{
    _isShowedDetailFromCollection=false;
    _isShowedUserCollection=true;
    
    self.userCollection.view.hidden=false;
    
    if(animated)
    {
        AlphaView *av=[self.userCollection.view alphaViewWithColor:COLOR_BACKGROUND_APP_ALPHA(1)];
        av=[self.frontViewController.view alphaViewWithColor:COLOR_BACKGROUND_APP_ALPHA(0)];
        [self.userCollection configMenu];
        
        [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
            
            self.userCollection.view.center=CGPOINT_PHONE(CGPointMake(160, 243), CGPointMake(160, self.userCollection.view.center.y));
            self.frontViewController.view.center=CGPOINT_PHONE(CGPointMake(480, 249),CGPointMake(480,self.frontViewController.view.center.y));
            
            [self.userCollection.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(0);
            [self.frontViewController.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(1);
        } completion:^(BOOL finished) {
            
            [self.userCollection.view removeAlphaView];
            [self.frontViewController.view removeAlphaView];
            self.bannerAds.view.hidden=false;
            
            [self.frontViewController popViewControllerAnimated:false];
            self.frontViewController.view.center=CGPOINT_PHONE(CGPointMake(160, 249),CGPointMake(160,self.frontViewController.view.center.y));
            
            if([self.frontViewController isHidedCatalogBlockForUserCollection])
                [self.frontViewController showCatalogueBlockForUserCollection];
            
            if(onCompleted)
                onCompleted(finished);
        }];
    }
    else
    {
        self.userCollection.view.center=CGPOINT_PHONE(CGPointMake(160, 243),CGPointMake(160,self.userCollection.view.center.y));
        self.frontViewController.view.center=CGPOINT_PHONE(CGPointMake(480, 249),CGPointMake(480,self.frontViewController.view.center.y));
        
        [self.userCollection.view removeAlphaView];
        [self.frontViewController.view removeAlphaView];
        self.bannerAds.view.hidden=false;
        
        [self.frontViewController popViewControllerAnimated:false];
        self.frontViewController.view.center=CGPOINT_PHONE(CGPointMake(160, 249),CGPointMake(160,self.frontViewController.view.center.y));
    }
}

-(void) showUserCollectionFromShopDetail:(void(^)(BOOL finished)) onCompleted
{
    [self showUserCollectionFromShopDetail:true completed:onCompleted];
}

-(void) hideUserCollectionFromShopDetail:(void(^)(BOOL finished)) onCompleted
{
    _isShowedDetailFromCollection=true;
    _isShowedUserCollection=false;
    self.userCollection.view.hidden=false;
    [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
        self.userCollection.view.center=CGPOINT_PHONE(CGPointMake(-160, self.userCollection.view.center.y),CGPointMake(-160,self.userCollection.view.center.y));
        self.frontViewController.view.center=CGPOINT_PHONE(CGPointMake(160, 249),CGPointMake(160,self.frontViewController.view.center.y));
        
        [self.userCollection.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(1);
        [self.frontViewController.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(0);
    } completion:^(BOOL finished) {
        
        [self.userCollection.view removeAlphaView];
        [self.frontViewController.view removeAlphaView];
        
        self.userCollection.view.hidden=true;
        
        onCompleted(finished);
    }];
}

-(void) showShopDetailFromUserCollection:(Shop*) shop;
{
    if(_isShowedDetailFromCollection)
        return;
    
    _isShowedDetailFromCollection=true;
    _isShowedUserCollection=false;

    if([self.frontViewController isShowedCatalogueBlock])
    {
        [self.frontViewController hideCatalogueBlockForUserCollection];
    }
    
    self.bannerAds.view.hidden=true;
    self.shopDetail.view.hidden=false;
    self.shopDetail.shoplMode=SHOPDETAIL_FROM_COLLECTION;
    [self.shopDetail removeFromParentViewController];
    [self.shopDetail.view removeFromSuperview];
    [self.shopDetail setShop:shop];
    
    self.frontViewController.delegate=self;
    [self.frontViewController pushViewController:self.shopDetail animated:false];
}

-(void)hideShopDetailFromUserCollection
{
    _isShowedUserCollection=true;
    _isShowedDetailFromCollection=false;
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if([viewController isKindOfClass:[ShopDetailViewController class]])
    {
        if(_isShowedDetailFromMap)
        {
            self.frontViewController.delegate=nil;
            
            self.frontViewController.view.center=CGPointMake(480, self.frontViewController.view.center.y);
            
            AlphaView *alphaView=[[AlphaView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            alphaView.backgroundColor=COLOR_BACKGROUND_APP_ALPHA(0);
            
            [bannerAds.view addSubview:alphaView];
            
            alphaView=[[AlphaView alloc] initWithFrame:self.frontViewController.view.frame];
            alphaView.backgroundColor=COLOR_BACKGROUND_APP_ALPHA(1);
            
            [self.frontViewController.view addSubview:alphaView];
            
            [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
                CGPoint pnt=bannerAds.view.center;
                pnt.x=-bannerAds.view.frame.size.width/2;
                bannerAds.view.center=pnt;
                
                pnt=self.frontViewController.view.center;
                pnt.x-=self.frontViewController.view.frame.size.width;
                self.frontViewController.view.center=pnt;
                
                [bannerAds.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(1);
                [self.frontViewController.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(0);
            } completion:^(BOOL finished) {
                bannerAds.view.hidden=true;
                [bannerAds removeMap];
                [bannerAds.view removeAlphaView];
                [self.frontViewController.view removeAlphaView];
            }];
        }
        else if(_isShowedDetailFromCollection)
        {
            self.frontViewController.delegate=nil;
            self.frontViewController.view.center=CGPointMake(480, self.frontViewController.view.center.y);
            
            AlphaView *alphaView=[self.userCollection.view makeAlphaView];
            alphaView.backgroundColor=COLOR_BACKGROUND_APP_ALPHA(0);
            
            alphaView=[self.frontViewController.view makeAlphaView];
            alphaView.backgroundColor=COLOR_BACKGROUND_APP_ALPHA(1);
            
            [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
                CGPoint pnt=userCollection.view.center;
                pnt.x=-userCollection.view.frame.size.width/2;
                userCollection.view.center=pnt;
                
                pnt=self.frontViewController.view.center;
                pnt.x-=self.frontViewController.view.frame.size.width;
                self.frontViewController.view.center=pnt;
                
                [userCollection.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(1);
                [self.frontViewController.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(0);
            } completion:^(BOOL finished) {
                userCollection.view.hidden=true;
                [userCollection.view removeAlphaView];
                [self.frontViewController.view removeAlphaView];
            }];
        }
    }
}

-(bool)isShowedShopDetailFromMap
{
    return _isShowedDetailFromMap;
}

-(void)restoreGesturePrevious
{
    [self.panPrevious.view removeGestureRecognizer:self.panPrevious];
    
    [self.window addGestureRecognizer:self.panPrevious];
    self.panPrevious.delegate=self;
}

-(float)heightAds_QR
{
    return 160;
}

@end