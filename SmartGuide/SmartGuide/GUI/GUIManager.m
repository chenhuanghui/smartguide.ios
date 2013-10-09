//
//  GUIManager.m
//  SmartGuide
//
//  Created by XXX on 7/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "GUIManager.h"
#import "LoginViewController.h"
#import "CatalogueBlockViewController.h"
#import "NavigationViewController.h"
#import "BannerAds.h"
#import "PageControl.h"
#import "Utility.h"
#import "NotificationViewController.h"
#import "SettingViewController.h"
#import "DataManager.h"
#import "DirectionObjectViewController.h"
#import "CatalogueListViewController.h"
#import "FacebookMiningViewController.h"
#import "BannerAdsViewController.h"
#import "SlideQRCodeViewController.h"
#import "FilterViewController.h"
#import "RootViewController.h"

@interface GUIManager()

@property (nonatomic, strong) UIPanGestureRecognizer* panMainGesture;
@property (nonatomic, strong) UIPanGestureRecognizer* panSlideGesture;
@property (nonatomic, readonly) RootViewController *rootViewController;

@end

static GUIManager *_guiManager=nil;
@implementation GUIManager
@synthesize window,mainNavigationController;
@synthesize bottomBar;
@synthesize notifications;
@synthesize pkRevealController;
@synthesize catalogueBlock;
@synthesize directionShop;
@synthesize bannerAds;
@synthesize slideQRCode;
@synthesize panSlideGesture,panMainGesture;
@synthesize filter;
@synthesize rootViewController;

+(GUIManager *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _guiManager=[[GUIManager alloc] init];
    });
    
    return _guiManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        notifications=[[NSMutableArray alloc] init];
//        [self registerNotification];
    }
    return self;
}

-(void) registerNotification
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogin:) name:NOTIFICATION_LOGIN object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogout:) name:NOTIFICATION_LOGOUT object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(announcementHided:) name:NOTIFICATION_ANNOUNCEMENT_HIDED object:nil];
    });
}

-(void)startupWithWindow:(UIWindow *)_window
{
    self.window=_window;
    self.window.backgroundColor = COLOR_BACKGROUND_APP;
    
    [[UIApplication sharedApplication] setStatusBarHidden:false];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
    rootViewController=[[RootViewController alloc] init];
    
    self.window.rootViewController=rootViewController;
    
    [self.window makeKeyAndVisible];
    
    [rootViewController showLogin];
}

-(void) initLogin
{
    self.mainNavigationController.view.backgroundColor=[UIColor whiteColor];
    
    LoginViewController *login = [[LoginViewController alloc] init];
    if(!self.mainNavigationController)
    {
        self.mainNavigationController=[[NavigationViewController alloc] initWithRootViewController:login];
        self.mainNavigationController.delegate=self;
        self.mainNavigationController.view.backgroundColor=COLOR_BACKGROUND_APP;
    }
    else
    {
        [self.mainNavigationController pushViewController:login animated:true];
        self.mainNavigationController.viewControllers=@[login];
    }
    
    if(!self.pkRevealController)
    {
        self.pkRevealController=[PKRevealController revealControllerWithFrontViewController:self.mainNavigationController leftViewController:nil options:nil];
        self.pkRevealController.recognizesPanningOnFrontView=false;
//        self.pkRevealController.delegate=self;
        self.window.rootViewController=self.pkRevealController;
        [self.window makeKeyAndVisible];
    }
}

-(void) initMain
{
    [self.mainNavigationController.visibleViewController.navigationController popViewControllerAnimated:false];
    
    if(!self.catalogueBlock)
    {
        self.catalogueBlock=[[CatalogueBlockViewController alloc] init];
        
        [[self catalogueBlock] view];
        CGRect rect=self.catalogueBlock.view.frame;
        rect.origin.y=44;
        rect.origin.x=rect.size.width;
        self.catalogueBlock.view.frame=rect;
        self.catalogueBlock.view.layer.masksToBounds=true;
        
        [self.mainNavigationController.view addSubview:self.catalogueBlock.view];
        
        [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
            CGRect rectAnim=self.catalogueBlock.view.frame;
            rectAnim.origin.x=0;
            
            self.catalogueBlock.view.frame=rectAnim;
        }];
    }
    
    self.directionShop=[[DirectionObjectViewController alloc] initDirectionObject];
    
    if(!self.bannerAds)
    {
        self.bannerAds=[[BannerAdsViewController alloc] init];
        [self.window addSubview:self.bannerAds.view];
        
        [self.bannerAds view];
        CGRect rect=self.bannerAds.view.frame;
        rect.origin.x=rect.size.width;
        rect.origin.y=self.mainNavigationController.view.frame.size.height-rect.size.height-[SlideQRCodeViewController size].height;
        self.bannerAds.view.frame=rect;
        
        [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
            CGRect rectAnim=self.bannerAds.view.frame;
            rectAnim.origin.x=0;
            
            self.bannerAds.view.frame=rectAnim;
        }];
    }
    
    if(!self.slideQRCode)
    {
        self.slideQRCode=[[SlideQRCodeViewController alloc] init];
        [self.slideQRCode view];
        
        [self.window addSubview:self.slideQRCode.view];
        
        CGRect rect=self.slideQRCode.view.frame;
        rect.origin.y=[self slidePositionY];
        rect.origin.x=rect.size.width;
        self.slideQRCode.view.frame=rect;
        
        [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
            CGRect rectAnim=self.slideQRCode.view.frame;
            rectAnim.origin.x=0;
            
            self.slideQRCode.view.frame=rectAnim;
        }];
    }
    
    if(!self.filter)
    {
        self.filter=[[FilterViewController alloc] init];
        CGRect rect=CGRectZero;
        rect.size=[FilterViewController size];
        [self.filter view];
    }
    
    CatalogueListViewController *cataList=[[CatalogueListViewController alloc] initWithGroup:nil city:nil];
    [self.mainNavigationController pushViewController:cataList animated:true];
    self.mainNavigationController.viewControllers=@[cataList];
    
    [self.pkRevealController setLeftViewController:[[SettingViewController alloc] init]];
    
    self.panMainGesture=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(mainNavigationControllerPan:)];
    self.panMainGesture.delegate=self;
    
    [self.mainNavigationController.view addGestureRecognizer:self.panMainGesture];
    
    self.panSlideGesture=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(mainNavigationControllerPanSlide:)];
    self.panSlideGesture.delegate=self;
    
    [self.slideQRCode.view addGestureRecognizer:self.panSlideGesture];
    
    [self showCatalogueBlock:false];
    
    _firstShowCatalogueBlock=true;
}

-(float) slidePositionY
{
    return [UIScreen mainScreen].bounds.size.height-[SlideQRCodeViewController size].height;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if(gestureRecognizer==self.panMainGesture)
    {
        if(_firstShowCatalogueBlock)
            return false;
        
        if([self isShowedFilter])
            return false;
        
        CGPoint pnt=[gestureRecognizer locationInView:self.mainNavigationController.view];
        CGRect dragRect=CGRectZero;
        dragRect.origin.y=[self navigationHeight];
        dragRect.size.width=[UIScreen mainScreen].bounds.size.width;
        dragRect.size.height=[UIScreen mainScreen].bounds.size.height-dragRect.origin.y-[self bottomBlockSize].height;
        
        if(!CGRectContainsPoint(dragRect, pnt))
            return false;
        
        if([self isShowedCatalogueBlock])
        {
            return false;
            CGPoint translation = [self.panMainGesture translationInView:self.mainNavigationController.view];
            
            if(translation.x<0)
                return (fabs(translation.x) >= fabs(translation.y));
        }
        else
        {
            CGPoint translation = [self.panMainGesture translationInView:self.mainNavigationController.view];
            
            if(translation.x>0)
                return (fabs(translation.x) >= fabs(translation.y));
        }
        
        return false;
    }
    else if(gestureRecognizer==self.panSlideGesture)
    {
        bool allowGes=false;
        if(![self isShowingSlideQRCode])
        {
            CGPoint translation = [self.panSlideGesture translationInView:self.slideQRCode.view];
            
            if(translation.y<0)
                allowGes=(fabs(translation.y) >= fabs(translation.x));
        }
        else
        {
            CGPoint translation = [self.panSlideGesture translationInView:self.slideQRCode.view];
            
            if(translation.y>0)
            {
                allowGes=(fabs(translation.y) >= fabs(translation.x));
            }
            
            if(allowGes)
            {
                [self.slideQRCode.view removeFromSuperview];
                [self.window addSubview:self.slideQRCode.view];
            }
            
            return allowGes;
        }
    }
    
    return true;
}

-(bool) isShowingSlideQRCode
{
    return self.slideQRCode.view.frame.origin.y==0;
}

-(CGSize)bottomBlockSize
{
    float height=[SlideQRCodeViewController size].height;
    
    if([self isBannerAdsVisible])
        height+=[BannerAdsViewController size].height;
    
    return CGSizeMake(320, height);
}

-(bool) isBannerAdsVisible
{
    return !self.bannerAds.view.hidden;
}

-(void) backToPreviousTitle
{
    [self.rootViewController backToPreviousTitle];
}
-(void) setNavigationTitle:(NSString*) naviTitle
{
    [self.rootViewController setNavigationTitle:naviTitle];
}

-(void)showMap
{
    _isShowedMap=true;
    
    [self.bannerAds addMap:self.directionShop];
//    [self.bannerAds showMap];
}

-(void)hideMap
{
    _isShowedMap=false;
    [self.bannerAds hideMap];
}

-(bool)isShowedMap
{
    return _isShowedMap;
}

-(void) mainNavigationControllerPanSlide:(UIPanGestureRecognizer*) pan
{
    CGRect rect;
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            initialTouchSlideLocation=[pan locationInView:self.window];
            previousTouchSlideLocation=initialTouchSlideLocation;
            
            [bannerAds.view removeFromSuperview];
            [self.mainNavigationController.view addSubview:bannerAds.view];
            
            rect=self.mainNavigationController.view.frame;
            
            UIView *containtView=[self.mainNavigationController.view viewWithTag:123];
            if(!containtView)
                containtView=[[UIView alloc] initWithFrame:rect];
            
            containtView.backgroundColor=[UIColor clearColor];
            containtView.tag=123;
            
            [self.mainNavigationController.view addSubview:containtView];
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGPoint currentLocation=[pan locationInView:self.window];
            
            float delta=currentLocation.y-previousTouchSlideLocation.y;
            previousTouchSlideLocation=currentLocation;
            
            UIView *containtView=[self.mainNavigationController.view viewWithTag:123];
            
            float alpha=([UIScreen mainScreen].bounds.size.height/2-self.mainNavigationController.view.center.y)/[UIScreen mainScreen].bounds.size.height;
            alpha+=0.3f;
            
            containtView.backgroundColor=COLOR_BACKGROUND_APP_ALPHA(alpha);
            
            rect=self.mainNavigationController.view.frame;
            rect.origin.y+=delta;
            
            self.mainNavigationController.view.frame=rect;
            
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
            
            if(_isShowedSliderQR)
            {
                if(velocity>0 && velocity>800)
                {
                    pan.enabled=false;
                    
                    [self hideSlideQR:true onCompleted:^(BOOL finished) {
                        pan.enabled=true;
                    }];
                }
                else
                {
                    if(self.slideQRCode.view.frame.origin.y>[UIScreen mainScreen].bounds.size.height/2)
                    {
                        pan.enabled=false;
                        [self hideSlideQR:true onCompleted:^(BOOL finished) {
                            pan.enabled=true;
                            [[self.mainNavigationController.view viewWithTag:123] removeFromSuperview];
                        }];
                    }
                    else
                    {
                        pan.enabled=false;
                        
                        [self showSlideQR:true onCompleted:^(BOOL finished) {
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
                    
                    [self showSlideQR:true onCompleted:^(BOOL finished) {
                        pan.enabled=true;
                    }];
                }
                else
                {
                    if(self.slideQRCode.view.frame.origin.y<[UIScreen mainScreen].bounds.size.height-[UIScreen mainScreen].bounds.size.height/3)
                    {
                        pan.enabled=false;
                        [self showSlideQR:true onCompleted:^(BOOL finished) {
                            pan.enabled=true;
                        }];
                    }
                    else
                    {
                        pan.enabled=false;
                        
                        [self hideSlideQR:true onCompleted:^(BOOL finished) {
                            pan.enabled=true;
                        }];
                    }
                }
            }
        }
            break;
            
        default:
            self.panSlideGesture.enabled=true;
            break;
    }
    
}

-(void) mainNavigationControllerPan:(UIPanGestureRecognizer*) pan
{
    CGRect rect;
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            initialTouchMainLocation=[pan locationInView:self.window];
            previousTouchMainLocation=initialTouchMainLocation;
            
            if([self isShowedCatalogueBlock])
                return;
            
            float naviHeight=[self.mainNavigationController isNavigationBarHidden]?0:44;
            
            [self.catalogueBlock removeFromParentViewController];
            [self.catalogueBlock.view removeFromSuperview];
            
            [self.mainNavigationController.view addSubview:self.catalogueBlock.view];
            
            rect=self.catalogueBlock.view.frame;
            rect.origin.y=naviHeight;
            rect.origin.x=-rect.size.width;
            
            self.catalogueBlock.view.frame=rect;
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGPoint currentLocation=[pan locationInView:self.window];
            
            float delta=currentLocation.x-previousTouchMainLocation.x;
            previousTouchMainLocation=currentLocation;
            
            rect=self.mainNavigationController.visibleViewController.view.frame;
            rect.origin.x+=delta;
            
            self.mainNavigationController.visibleViewController.view.frame=rect;
            
            rect=self.catalogueBlock.view.frame;
            rect.origin.x+=delta;
            
            self.catalogueBlock.view.frame=rect;
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
                
                [self showCatalogueBlock:true onCompleted:^(BOOL finished) {
                    pan.enabled=true;
                }];
            }
            else
            {
                if(self.catalogueBlock.view.center.x>[UIScreen mainScreen].bounds.size.width/6)
                {
                    pan.enabled=false;
                    [self showCatalogueBlock:true onCompleted:^(BOOL finished) {
                        pan.enabled=true;
                    }];
                }
                else
                {
                    pan.enabled=false;
                    
                    [self hideCatalogueBlock:true onCompleted:^(BOOL finished) {
                        pan.enabled=true;
                    }];
                }
            }
        }
            break;
            
        default:
            self.panMainGesture.enabled=true;
            break;
    }
}

-(bool)isShowingBannerAds
{
    return true;
    //    return self.bannerBlock.superview!=nil;
}

-(bool)isShowingBottomBar
{
    return true;
    //    return self.bottomBar.superview!=nil;
}

-(void) showSlideQR:(bool) animated onCompleted:(void(^)(BOOL finished)) onCompleted
{
    NSLog(@"showSlideQR");
    
    _isShowedSliderQR=true;
    
    if(animated)
    {
        [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect rect=self.slideQRCode.view.frame;
            rect.origin.y=0;
            self.slideQRCode.view.frame=rect;
            
            rect=self.mainNavigationController.view.frame;
            rect.origin.y=-rect.size.height+[SlideQRCodeViewController size].height;
            self.mainNavigationController.view.frame=rect;
            
            [self.mainNavigationController.view viewWithTag:123].backgroundColor=[UIColor colorWithRed:24.f/255 green:31.f/255 blue:42.f/255 alpha:1];
            
        } completion:^(BOOL finished) {
            
            [self.slideQRCode showCamera];
            
            if(onCompleted)
                onCompleted(finished);
        }];
    }
    else
    {
        CGRect rect=self.slideQRCode.view.frame;
        rect.origin.y=0;
        self.slideQRCode.view.frame=rect;
        
        rect=self.mainNavigationController.view.frame;
        rect.origin.y=-rect.size.height+[SlideQRCodeViewController size].height;
        self.mainNavigationController.view.frame=rect;
    }
}

-(void) showSlideQR:(bool) animated
{
    [self showSlideQR:animated onCompleted:nil];
}

-(void) hideSlideQR:(bool) animated onCompleted:(void(^)(BOOL finished)) onCompleted
{
    NSLog(@"hideSlideQR");
    _isShowedSliderQR=false;
    
    if(animated)
    {
        [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect rect=self.slideQRCode.view.frame;
            rect.origin.y=[UIScreen mainScreen].bounds.size.height-[SlideQRCodeViewController size].height;
            self.slideQRCode.view.frame=rect;
            
            rect=self.mainNavigationController.view.frame;
            rect.origin.y=0;
            self.mainNavigationController.view.frame=rect;
            
            [self.mainNavigationController.view viewWithTag:123].backgroundColor=[UIColor colorWithRed:24.f/255 green:31.f/255 blue:42.f/255 alpha:0];
        } completion:^(BOOL finished) {
            
            [self.slideQRCode hideCamera];
            [[self.mainNavigationController.view viewWithTag:123] removeFromSuperview];
            
            if(onCompleted)
                onCompleted(finished);
        }];
    }
    else
    {
        CGRect rect=self.slideQRCode.view.frame;
        rect.origin.y=[UIScreen mainScreen].bounds.size.height-[SlideQRCodeViewController size].height;
        self.slideQRCode.view.frame=rect;
        
        rect=self.mainNavigationController.view.frame;
        rect.origin.y=0;
        self.mainNavigationController.view.frame=rect;
        
        [[self.mainNavigationController.view viewWithTag:123] removeFromSuperview];
    }
    
}

-(void) showCatalogueBlock:(bool)animated onCompleted:(void(^)(BOOL finished)) onCompleted
{
    NSLog(@"showCatalogueBlock");
    return;
    _isShowedCatalogueBlock=true;
    
    if(animated)
    {
        [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            CGRect rectAnim=self.catalogueBlock.view.frame;
            rectAnim.origin.x=0;
            
            self.catalogueBlock.view.frame=rectAnim;
            
            rectAnim=self.mainNavigationController.visibleViewController.view.frame;
            rectAnim.origin.x=rectAnim.size.width;
            
            self.mainNavigationController.visibleViewController.view.frame=rectAnim;
        } completion:onCompleted];
    }
    else
    {
        CGRect rectAnim=self.catalogueBlock.view.frame;
        rectAnim.origin.x=0;
        
        self.catalogueBlock.view.frame=rectAnim;
        
        rectAnim=self.mainNavigationController.visibleViewController.view.frame;
        rectAnim.origin.x=rectAnim.size.width;
        
        self.mainNavigationController.visibleViewController.view.frame=rectAnim;
    }
}

-(void) showCatalogueBlock:(bool)animated
{
    [self showCatalogueBlock:animated onCompleted:nil];
}

-(void) hideCatalogueBlock:(bool)animated onCompleted:(void(^)(BOOL finished)) onCompleted
{
    NSLog(@"hideCatalogueBlock");
    
    _isShowedCatalogueBlock=false;
    
    if(animated)
    {
        [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            CGRect rectAnim=self.catalogueBlock.view.frame;
            rectAnim.origin.x=-rectAnim.size.width;
            
            self.catalogueBlock.view.frame=rectAnim;
            
            rectAnim=self.mainNavigationController.visibleViewController.view.frame;
            rectAnim.origin.x=0;
            
            self.mainNavigationController.visibleViewController.view.frame=rectAnim;
        } completion:^(BOOL finished) {
            
            [self.catalogueBlock removeFromParentViewController];
            [self.catalogueBlock.view removeFromSuperview];
            
            if(onCompleted)
                onCompleted(finished);
        }];
    }
    else
    {
        CGRect rectAnim=self.catalogueBlock.view.frame;
        rectAnim.origin.x=-rectAnim.size.width;
        
        self.catalogueBlock.view.frame=rectAnim;
        
        rectAnim=self.mainNavigationController.visibleViewController.view.frame;
        rectAnim.origin.x=0;
        
        self.mainNavigationController.visibleViewController.view.frame=rectAnim;
        
        [self.catalogueBlock removeFromParentViewController];
        [self.catalogueBlock.view removeFromSuperview];
    }
    
    _firstShowCatalogueBlock=false;
}

-(void) hideCatalogueBlock:(bool)animated
{
    [self hideCatalogueBlock:animated onCompleted:nil];
}

-(bool) isShowedCatalogueBlock
{
    return _isShowedCatalogueBlock;
}

-(void) showBannerAds
{
    //    if(self.mainNavigationController.modalViewController)
    //        [self removeBannerAds];
    //
    //    if(!self.bannerBlock.superview)
    //    {
    //        CGPoint pnt=CGPointZero;
    //        pnt.x=self.bannerBlock.frame.size.width/2;
    //
    //        if(self.mainNavigationController.modalViewController)
    //        {
    //            if([self isShowingBottomBar])
    //                pnt.y=self.bottomBar.center.y-self.bottomBar.frame.size.height/2-self.bannerBlock.frame.size.height/2;
    //            else
    //                pnt.y=self.window.bounds.size.height-self.bottomBar.frame.size.height/2;
    //
    //            self.bannerBlock.center=pnt;
    //            [self.window addSubview:self.bannerBlock];
    //        }
    //        else
    //        {
    //            if([self isShowingBottomBar])
    //                pnt.y=self.bottomBar.center.y-self.bottomBar.frame.size.height/2-self.bannerBlock.frame.size.height/2;
    //            else
    //                pnt.y=self.mainNavigationController.view.bounds.size.height-self.bottomBar.frame.size.height/2;
    //
    //            self.bannerBlock.center=pnt;
    //
    //            [self.mainNavigationController.view addSubview:self.bannerBlock];
    //        }
    //
    //        switch (self.mainNavigationController.naviType) {
    //            case NAVY_POP:
    //                self.bannerBlock.center=CGPointMake(pnt.x-320, pnt.y);
    //                break;
    //
    //            case NAVY_PUSH:
    //                self.bannerBlock.center=CGPointMake(pnt.x+320, pnt.y);
    //                break;
    //        }
    //
    //        if(self.mainNavigationController.modalViewController)
    //            self.bannerBlock.center=CGPointMake(pnt.x, pnt.y+self.bannerBlock.frame.size.height);
    //
    //        [UIView animateWithDuration:0.35f animations:^{
    //            self.bannerBlock.center=pnt;
    //        }];
    //    }
}
-(void) removeBannerAds
{
    //    if(self.bannerBlock.superview)
    //    {
    //        CGPoint pnt=self.bannerBlock.center;
    //
    //        if(self.mainNavigationController.modalViewController)
    //            pnt.y+=self.bannerBlock.frame.size.height;
    //        else
    //            pnt.x-=320;
    //
    //        [UIView animateWithDuration:0.35f animations:^{
    //            self.bannerBlock.center=pnt;
    //        } completion:^(BOOL finished) {
    //            [self.bannerBlock removeFromSuperview];
    //        }];
    //    }
}

-(void) showBottomBar
{
    //    if(self.mainNavigationController.modalViewController)
    //        [self removeBottomBar];
    //
    //    if(!self.bottomBar.superview)
    //    {
    //        CGPoint pnt=CGPointZero;
    //        pnt.x=self.bottomBar.frame.size.width/2;
    //
    //        if(self.mainNavigationController.modalViewController)
    //        {
    //            pnt.y=self.window.bounds.size.height-self.bottomBar.frame.size.height/2;
    //            self.bottomBar.center=pnt;
    //            [self.window addSubview:self.bottomBar];
    //        }
    //        else
    //        {
    //            pnt.y=self.mainNavigationController.view.bounds.size.height-self.bottomBar.frame.size.height/2;
    //            self.bottomBar.center=pnt;
    //            [self.mainNavigationController.view addSubview:self.bottomBar];
    //        }
    //    }
}
-(void) removeBottomBar
{
    //    if(self.bottomBar.superview)
    //        [self.bottomBar removeFromSuperview];
}

-(void) viewWillAppear:(ViewController*) viewController
{
    //    if(viewController!=self.mainNavigationController.visibleViewController)
    //        return;
    //
    //    if([viewController isKindOfClass:[SettingViewController class]] || [viewController isKindOfClass:[CatalogueBlockViewController class]])
    //        return;
    //
    //    if([viewController allowBottomBar])
    //        [self showBottomBar];
    //    else
    //        [self removeBottomBar];
    //
    //    if([viewController allowBannerAds])
    //        [self showBannerAds];
    //    else
    //        [self removeBannerAds];
}

-(void) viewWillDisappear:(ViewController*) viewController
{
    //    if(![viewController allowBannerAds])
    //        [self removeBannerAds];
    
    //    if(![viewController allowBottomBar])
    //        [self removeBottomBar];
}

-(void)setBottomBarTitles:(NSArray *)titles
{
    //    [self.bottomBar setTitles:titles];
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
    
    float navigationBarHeight=self.mainNavigationController.visibleViewController.navigationController? 44 : 0;
    float statusBarHeight=[[UIApplication sharedApplication] isStatusBarHidden]?0:20;
    
    CGRect rect=annou.view.frame;
    rect.origin.y=navigationBarHeight+statusBarHeight;
    annou.view.frame=rect;
    
    [self.window addSubview:annou.view];
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

-(void)pkRevealController:(PKRevealController *)pkReveal stateChanged:(PKRevealControllerState)state
{
    if(state==PKRevealControllerFocusesLeftViewController)
        self.pkRevealController.recognizesPanningOnFrontView=true;
    else
        self.pkRevealController.recognizesPanningOnFrontView=false;
}

-(void)showSetting
{
    if(self.pkRevealController)
    {
        if(![self isShowingSetting])
        {
            [self.pkRevealController showViewController:self.pkRevealController.leftViewController animated:true completion:nil];
        }
    }
}

-(void)autoShowHideSetting
{
    if(self.pkRevealController)
    {
        if([self isShowingSetting])
            [self hideSetting];
        else
            [self showSetting];
    }
}

-(void)hideSetting
{
    if(self.pkRevealController)
    {
        if(self.pkRevealController.state==PKRevealControllerFocusesLeftViewController)
            [self.pkRevealController showViewController:self.pkRevealController.frontViewController animated:true completion:nil];
    }
}

-(bool)isShowingSetting
{
    return self.pkRevealController.state==PKRevealControllerFocusesLeftViewController;
}

#pragma mark NOTIFICATIONS
-(void) userLogin:(NSNotification*) notification
{
    if([DataManager shareInstance].currentUser.isConnectedFacebook)
        [self initMain];
    else
        [self initFacebookMining];
}

-(void) initFacebookMining
{
    __block NSNotification *notiFace=[[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_FACEBOOK_MINING_FINISHED object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        
        [self initMain];
        
        [[NSNotificationCenter defaultCenter] removeObserver:notiFace];
    }];
    
    FacebookMiningViewController *face=[[FacebookMiningViewController alloc] init];
    [self.mainNavigationController pushViewController:face animated:true];
}

-(void) userLogout:(NSNotification*) notification
{
    [self hideSetting];
    [DataManager shareInstance].currentUser=nil;
    [self initLogin];
}

-(void)announcementHided:(NSNotification*) notification
{
    NotificationViewController *announcement=(NotificationViewController*) notification.object;
    
    [notifications removeObject:announcement];
    
    if(notifications.count>0)
    {
        NotificationViewController *annou = [notifications objectAtIndex:0];
        
        [self showAnnouncement:annou];
    }
}

-(float)navigationHeight
{
    return [self.mainNavigationController isNavigationBarHidden]?0:44;
}

-(void)showFilter
{
    [self.rootViewController showFilter];
}

-(void)hideFilter
{
    [self.rootViewController hideFilter];
}

-(bool)isShowedFilter
{
    return [self.rootViewController isShowedFilter];
}

-(void)showShopInGroup:(Group *)group
{
    
}

@end