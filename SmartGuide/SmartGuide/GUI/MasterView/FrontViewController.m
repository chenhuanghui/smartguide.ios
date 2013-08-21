//
//  FrontViewController.m
//  SmartGuide
//
//  Created by XXX on 7/27/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "FrontViewController.h"
#import "BannerAdsViewController.h"
#import "SlideQRCodeViewController.h"
#import "CatalogueListViewController.h"
#import "RootViewController.h"
#import "ShopDetailViewController.h"
#import "AlphaView.h"

@interface FrontViewController ()

@property (nonatomic, assign) CGPoint initialTouchPan;
@property (nonatomic, assign) CGPoint previousTouchPan;

@end

@implementation FrontViewController
@synthesize catalogueBlock,catalogueList;
@synthesize initialTouchPan,previousTouchPan;
@synthesize isPushingViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavigationBarHidden:true];
    
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=COLOR_BACKGROUND_APP;
    
    _isShowedCatalogueBlock=true;
    
    self.catalogueBlock=[[CatalogueBlockViewController alloc] init];
    catalogueBlock.delegate=self;
    
    [self addChildViewController:self.catalogueBlock];
    [self.view addSubview:self.catalogueBlock.view];
    
    self.catalogueList=[[CatalogueListViewController alloc] init];
    [self pushViewController:self.catalogueList animated:false];
    
    [self.catalogueBlock configMenu];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(ViewController *)currentVisibleViewController
{
    if([self isShowedCatalogueBlock])
        return self.catalogueBlock;
    
    return (ViewController*)self.visibleViewController;
}

-(bool)handlePanGestureShouldBegin:(UIPanGestureRecognizer *)panGesture
{
    if(self.isPushingViewController)
        return false;
    
    if([self isShowedCatalogueBlock])
        return false;
    
    if(_isDraggingCatalogueBlock)
        return true;
    
    if([[self visibleViewController] respondsToSelector:@selector(allowDragPreviousView:)])
        return [[self currentVisibleViewController] allowDragPreviousView:panGesture];
    
    return true;
}

-(bool)handlePanGesture:(UIPanGestureRecognizer *)panGesture
{
    if([self.visibleViewController isKindOfClass:[ShopDetailViewController class]])
    {
        [self processSlidePreviousView:panGesture];
        return true;
    }
    else if([self.visibleViewController isKindOfClass:[CatalogueListViewController class]])
    {
        [self processSlideCatalogueBlock:panGesture];
        return true;
    }
    
    return false;
}

-(void) processSlideCatalogueBlock:(UIPanGestureRecognizer*) pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            _isDraggingCatalogueBlock=true;
            
            initialTouchPan=[pan locationInView:self.view.window];
            previousTouchPan=initialTouchPan;
            
            AlphaView *alphaView=(AlphaView*)[self.catalogueBlock.view alphaView];
            if(!alphaView)
            {
                alphaView=[self.catalogueBlock.view makeAlphaView];
                alphaView.backgroundColor=COLOR_BACKGROUND_APP_ALPHA(1);
            }
            
            alphaView=[self.visibleViewController.view alphaView];
            if(!alphaView)
            {
                alphaView=[self.visibleViewController.view makeAlphaView];
                alphaView.backgroundColor=COLOR_BACKGROUND_APP_ALPHA(0);
            }
            
            if(!self.catalogueBlock.view.superview)
                [self.view addSubview:self.catalogueBlock.view];
            
            self.catalogueBlock.view.center=CGPointMake([self center].x-self.view.frame.size.width, [self center].y);
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGPoint currentLocation=[pan locationInView:self.view.window];
            
            float delta=currentLocation.x-previousTouchPan.x;
            previousTouchPan=currentLocation;
            
            if(self.visibleViewController.view.center.x+delta<[UIScreen mainScreen].bounds.size.width/2)
                return;
            
            AlphaView *alphaView=[self.catalogueBlock.view alphaView];
            alphaView.backgroundColor=COLOR_BACKGROUND_APP_ALPHA(fabsf(self.catalogueBlock.view.frame.origin.x/320));
            
            alphaView=[self.visibleViewController.view alphaView];
            alphaView.backgroundColor=COLOR_BACKGROUND_APP_ALPHA(fabsf(self.visibleViewController.view.frame.origin.x/320));
            
            CGPoint pnt =self.catalogueBlock.view.center;
            pnt.x+=delta;
            self.catalogueBlock.view.center=pnt;
            
            pnt=self.visibleViewController.view.center;
            pnt.x+=delta;
            self.visibleViewController.view.center=pnt;
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        {
            _isDraggingCatalogueBlock=false;
            
            float velocity=[pan velocityInView:self.view.window].x;
            
            if(velocity>0 && velocity>800)
            {
                pan.enabled=false;
                
                [self showCatalogueBlock:true onCompleted:^(BOOL finished) {
                    pan.enabled=true;
                }];
            }
            else
            {
                if(velocity<0 && self.catalogueList.view.frame.origin.x==0)
                    return;
                
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
            pan.enabled=true;
            break;
    }
}

-(ViewController*) previousViewController
{
    if(self.viewControllers.count<=1)
        return nil;
    
    return [self.viewControllers objectAtIndex:self.viewControllers.count-2];
}

-(void) processSlidePreviousView:(UIPanGestureRecognizer*) pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            initialTouchPan=[pan locationInView:self.view.window];
            previousTouchPan=initialTouchPan;
            
            [self.view addSubview:[self previousViewController].view];
            
            [self.previousViewController.view alphaViewWithColor:COLOR_BACKGROUND_APP_ALPHA(1)];
            [self.visibleViewController.view alphaViewWithColor:COLOR_BACKGROUND_APP_ALPHA(0)];
            
            CGRect rect=self.previousViewController.view.frame;
            rect.origin.x=-rect.size.width;
            self.previousViewController.view.frame=rect;
            self.previousViewController.view.hidden=false;
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGPoint currentLocation=[pan locationInView:self.view.window];
            
            float delta=currentLocation.x-previousTouchPan.x;
            previousTouchPan=currentLocation;
            
            if(self.visibleViewController.view.center.x+delta<[UIScreen mainScreen].bounds.size.width/2)
                return;
            
            CGPoint pnt =self.previousViewController.view.center;
            pnt.x+=delta;
            self.previousViewController.view.center=pnt;
            
            pnt=self.visibleViewController.view.center;
            pnt.x+=delta;
            self.visibleViewController.view.center=pnt;
            
            UIView *alphaView=[self.previousViewController.view alphaView];
            alphaView.backgroundColor=COLOR_BACKGROUND_APP_ALPHA(fabsf(self.previousViewController.view.frame.origin.x/320));
            
            alphaView=[self.visibleViewController.view alphaView];
            alphaView.backgroundColor=COLOR_BACKGROUND_APP_ALPHA(fabsf(self.visibleViewController.view.frame.origin.x/320));
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        {
            float velocity=[pan velocityInView:self.view.window].x;
            
            if(velocity>0 && velocity>800)
            {
                pan.enabled=false;
                [self showPreviousViewController:^(BOOL finished) {
                    pan.enabled=true;
                }];
            }
            else
            {
                if(self.previousViewController.view.center.x>[UIScreen mainScreen].bounds.size.width/6)
                {
                    pan.enabled=false;
                    [self showPreviousViewController:^(BOOL finished) {
                        pan.enabled=true;
                    }];
                }
                else
                {
                    pan.enabled=false;
                    [self hidePreviouViewController:^(BOOL finished) {
                        pan.enabled=true;
                    }];
                }
            }
        }
            break;
            
        default:
            pan.enabled=true;
            break;
    }
}

-(void) gesturePanCatalogue:(UIPanGestureRecognizer*) pan
{
    if([self.visibleViewController isKindOfClass:[ShopDetailViewController class]])
    {
        [self processSlidePreviousView:pan];
    }
    else
    {
        [self processSlideCatalogueBlock:pan];
    }
}

-(void)catalogueBlockDidSelectedGroup:(Group *)group
{
    [self.view showLoadingWithTitle:nil];
    
    //catalogueListLoadShopFinished handle delegate
    [catalogueList switchToModeList];
    catalogueList.delegate=self;
    [catalogueList loadGroup:group city:[DataManager shareInstance].currentCity];
}

-(void)catalogueBlockUpdated
{
    [catalogueList loadGroup:[Group groupAll] city:[DataManager shareInstance].currentCity];
}

-(void)catalogueListLoadShopFinished:(CatalogueListViewController *)catalogueListView
{
    catalogueList.delegate=nil;
    [self.view removeLoading];
    
    [self hideCatalogueBlock:true];
}

-(void)setFrame:(CGRect)frame
{
    frame.origin=CGPointZero;
    catalogueBlock.view.frame=frame;
    catalogueList.view.frame=frame;
}

-(void) showPreviousViewController:(void(^)(BOOL finished)) completed
{
    [[self previousViewController] configMenu];
    
    [UIView animateWithDuration:DURATION_SHOW_CATALOGUE animations:^{
        CGRect rect=self.previousViewController.view.frame;
        rect.origin.x=0;
        self.previousViewController.view.frame=rect;
        
        rect=self.visibleViewController.view.frame;
        rect.origin.x=320;
        self.visibleViewController.view.frame=rect;
        [self.previousViewController.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(0);
        [self.visibleViewController.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(1);
    } completion:^(BOOL finished) {
        
        [self.previousViewController.view removeAlphaView];
        [self.visibleViewController.view removeAlphaView];
        [self popViewControllerAnimated:false];
        
        if(completed)
            completed(finished);
        
        [[RootViewController shareInstance].bannerAds animationHideShopDetail];
    }];
}

-(void) hidePreviouViewController:(void(^)(BOOL finished)) completed
{
    [[self currentVisibleViewController] configMenu];
    
    [UIView animateWithDuration:DURATION_SHOW_CATALOGUE animations:^{
        CGRect rect=self.previousViewController.view.frame;
        rect.origin.x=-320;
        self.previousViewController.view.frame=rect;
        
        rect=self.visibleViewController.view.frame;
        rect.origin.x=0;
        self.visibleViewController.view.frame=rect;
        
        [self.previousViewController.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(0);
        [self.visibleViewController.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(0);
    } completion:^(BOOL finished) {
        
        [self.previousViewController.view removeAlphaView];
        [self.previousViewController.view removeFromSuperview];
        [self.visibleViewController.view removeAlphaView];
        
        if(completed)
            completed(finished);
    }];
}

-(bool)isShowedCatalogueBlock
{
    return _isShowedCatalogueBlock;
}

-(bool)isDraggingCatalogueBlock
{
    return _isDraggingCatalogueBlock;
}

-(void)showCatalogueBlock:(bool)animated onCompleted:(void(^)(BOOL finished)) completed
{
    _isShowedCatalogueBlock=true;
    
    if(!self.catalogueBlock.view.superview)
    {
        [self.view addSubview:self.catalogueBlock.view];
        self.catalogueBlock.view.center=CGPointMake([self center].x+self.view.frame.size.width, [self center].y);
    }
    
    if(animated)
    {
        [self.catalogueBlock.view alphaViewWithColor:COLOR_BACKGROUND_APP_ALPHA(1)];
        [self.visibleViewController.view alphaViewWithColor:COLOR_BACKGROUND_APP_ALPHA(0)];
        [self.catalogueBlock configMenu];
        
        [UIView animateWithDuration:DURATION_SHOW_CATALOGUE animations:^{
            self.catalogueBlock.view.center=[self center];
            
            self.visibleViewController.view.center=CGPointMake([self center].x+self.view.frame.size.width, [self center].y);
            
            [self.catalogueBlock.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(0);
            [self.visibleViewController.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(1);
        } completion:^(BOOL finished) {
            
            [self.catalogueBlock.view removeAlphaView];
            [self.visibleViewController.view removeAlphaView];
            
            if(completed)
                completed(finished);
        }];
    }
    else
    {
        CGRect rect=self.catalogueBlock.view.frame;
        rect.origin.x=0;
        self.catalogueBlock.view.frame=rect;
        
        rect=self.visibleViewController.view.frame;
        rect.origin.x=320;
        self.visibleViewController.view.frame=rect;
        
        [self.catalogueBlock.view removeAlphaView];
        [self.visibleViewController.view removeAlphaView];
    }
}

-(void)showCatalogueBlock:(bool)animated
{
    [self showCatalogueBlock:animated onCompleted:nil];
}

-(CGPoint) center
{
    return CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
}

-(void)hideCatalogueBlock:(bool)animated onCompleted:(void(^)(BOOL finished)) completed
{
    _isShowedCatalogueBlock=false;

    if(animated)
    {
        AlphaView *ap=[self.catalogueBlock.view alphaViewWithColor:COLOR_BACKGROUND_APP_ALPHA(0)];
        ap=[self.visibleViewController.view alphaViewWithColor:COLOR_BACKGROUND_APP_ALPHA(1)];
        [(ViewController*)[self visibleViewController] configMenu];

        //Khi lần đầu add vào navigation controller vị trí x ko thể thay đổi->thay đổi khi hide block
        if(self.visibleViewController.view.frame.origin.x==0)
        {
            self.visibleViewController.view.center=CGPointMake([self center].x+self.view.frame.size.width,[self center].y);
        }

        [UIView animateWithDuration:DURATION_SHOW_CATALOGUE animations:^{
            CGPoint pnt=self.catalogueBlock.view.center;
            pnt.x=[self center].x-self.view.frame.size.width;
            self.catalogueBlock.view.center=pnt;
            
            self.catalogueList.view.center=[self center];
            
            [self.catalogueBlock.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(1);
            [self.visibleViewController.view alphaView].backgroundColor=COLOR_BACKGROUND_APP_ALPHA(0);
        } completion:^(BOOL finished) {
            
            [self.catalogueBlock.view removeAlphaView];
            [self.visibleViewController.view removeAlphaView];
            
            [self.catalogueBlock.view removeFromSuperview];

            if(completed)
                completed(finished);
        }];
    }
    else
    {
        CGPoint pnt=self.catalogueBlock.view.center;
        pnt.x=[self center].x-self.view.frame.size.width;
        self.catalogueBlock.view.center=pnt;
        
        self.catalogueList.view.center=[self center];
        
        [self.catalogueBlock.view removeAlphaView];
        [self.visibleViewController.view removeAlphaView];
        
        [self.catalogueBlock.view removeFromSuperview];
    }
}

-(void)hideCatalogueBlock:(bool)animated
{
    [self hideCatalogueBlock:animated onCompleted:nil];
}

-(void)hideCatalogueBlockForUserCollection
{
    _isHideCatalogueBlockForUserCollection=true;
    _isShowedCatalogueBlock=false;
    [self.catalogueBlock.view removeFromSuperview];
}

-(bool)isHidedCatalogBlockForUserCollection
{
    return _isHideCatalogueBlockForUserCollection;
}

-(void)showCatalogueBlockForUserCollection
{
    [self.view addSubview:self.catalogueBlock.view];
    _isShowedCatalogueBlock=true;
    _isHideCatalogueBlockForUserCollection=false;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    ViewController *vc=(ViewController*)viewController;

    //restore frame
    self.view.frame=CGRectMake(0, 37, 320, 337);
    
    if([vc allowBannerAds])
    {
        
    }
    else
    {
        CGRect rect=self.view.frame;
        rect.size.height=337+[BannerAdsViewController size].height;
        self.view.frame=rect;
    }
    
    self.isPushingViewController=animated;
    
    [super pushViewController:viewController animated:animated];
    
    [vc configMenu];
    
    double delayInSeconds = DURATION_NAVIGATION_PUSH+0.5f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        isPushingViewController=false;
    });
}

-(void)navigationBarUserCollection:(UIButton *)sender
{
    [[RootViewController shareInstance] navigationBarUserCollection:sender];
}

-(void)navigationBarCatalogue:(UIButton *)sender
{
    [[RootViewController shareInstance] navigationBarCatalogue:sender];
}

-(void)navigationBarFilter:(UIButton *)sender
{
    [[RootViewController shareInstance] navigationBarFilter:sender];
}

-(void)navigationBarList:(UIButton *)sender
{
    [[RootViewController shareInstance] navigationBarList:sender];
}

-(void)navigationBarMap:(UIButton *)sender
{
    [[RootViewController shareInstance] navigationBarMap:sender];
}

-(void)navigationBarSearch:(UIButton *)sender
{
    [[RootViewController shareInstance] navigationBarSearch:sender];
}

-(void)navigationBarSetting:(UIButton *)sender
{
    [[RootViewController shareInstance] navigationBarSetting:sender];
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    [[self currentVisibleViewController] willPopViewController];
    
    UIViewController *vc= [super popViewControllerAnimated:animated];
    
    return vc;
}

@end
