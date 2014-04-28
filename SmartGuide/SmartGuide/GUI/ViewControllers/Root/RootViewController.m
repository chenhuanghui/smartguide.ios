//
//  SGRootViewController.m
//  SmartGuide
//
//  Created by MacMini on 09/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "RootViewController.h"
#import "NavigationViewController.h"
#import "KeyboardUtility.h"
#import "GUIManager.h"
#import "HomeViewController.h"
#import "UserUploadAvatarManager.h"
#import "UserUploadGalleryManager.h"
#import "WebViewController.h"
#import "ShopUserViewController.h"
#import "UserPromotionViewController.h"
#import "UserSettingViewController.h"
#import "SearchShopViewController.h"

@interface RootViewController ()<NavigationControllerDelegate,UIScrollViewDelegate,HomeControllerDelegate,UserPromotionDelegate,SGUserSettingControllerDelegate,WebViewDelegate,ShopUserDelegate,UIGestureRecognizerDelegate>

@end

@implementation RootViewController
@synthesize containFrame,contentFrame;

-(RootViewController *)init
{
    self=[super initWithNibName:@"RootViewController" bundle:nil];
    
    return self;
}

-(void)loadView
{
    [super loadView];
    
    HomeViewController *home=[HomeViewController new];
    home.delegate=self;
    
    self.contentNavigation=[[SGNavigationController alloc] initWithRootViewController:home];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.contentNavigation.view.autoresizingMask=UIViewAutoresizingAll();
    [self.contentView addSubview:self.contentNavigation.view];
    [self.contentNavigation.view l_v_setS:self.contentView.l_v_s];
    
    self.containView.layer.masksToBounds=true;
    self.contentView.layer.masksToBounds=true;
    
    self.settingController=[NavigationViewController new];
    self.settingController.delegate=self;
    
    [leftView addSubview:self.settingController.view];
    
    scrollContent.contentSize=CGSizeMake(640, UIScreenSize().height);
    [scrollContent l_co_setX:320];
    
    [scrollContent.panGestureRecognizer addTarget:self action:@selector(panGes:)];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired=1;
    tap.numberOfTouchesRequired=1;
    tap.cancelsTouchesInView=false;
    scrollContent.panGestureRecognizer.cancelsTouchesInView=false;
    
    tap.delegate=self;
    
    [scrollContent.panGestureRecognizer requireGestureRecognizerToFail:tap];
    [self.view addGestureRecognizer:tap];
    
    tapGes=tap;
}

-(void) panGes:(UIPanGestureRecognizer*) pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            [self.settingController loadData];
            break;
            
        default:
            break;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if([KeyboardUtility shareInstance].isKeyboardVisible)
        [self.view endEditing:true];
    
    float settingWidth=274.f;
    float x=320.f-scrollView.l_co_x;

    [leftView l_v_setX:scrollView.l_co_x-settingWidth/2+(320-scrollView.l_co_x)/2];
    
    if(x<settingWidth/3)
        leftView.alpha=0.3f;
    else
        leftView.alpha=MAX(0.3f,(x-settingWidth/3)/(settingWidth-settingWidth/3));
    
    [self endScroll];
}

-(void)showSettingController
{
    [self.settingController loadData];
    
    _isAnimatingSetting=true;
    [scrollContent setContentOffset:CGPointZero animated:true];
    scrollContent.userInteractionEnabled=false;
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if(_isAnimatingSetting)
    {
        scrollContent.userInteractionEnabled=true;
        _isAnimatingSetting=false;
    }
}

-(void) hideSettingController
{
    _isAnimatingSetting=true;
    [scrollContent setContentOffset:CGPointMake(320, 0) animated:true];
    scrollContent.userInteractionEnabled=false;
}

-(void) endScroll
{
    if(scrollContent.l_co_x<320)
    {
        self.contentView.userInteractionEnabled=false;
        leftView.userInteractionEnabled=true;
    }
    else
    {
        self.contentView.userInteractionEnabled=true;
        leftView.userInteractionEnabled=false;
    }
}

-(void)storeRect
{
    containFrame=self.containView.frame;
    contentFrame=self.contentView.frame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)moveToTopView:(SGViewController *)displayView
{
    self.topView.alpha=0;
    self.topView.hidden=false;
    
    [self.topView l_v_setO:displayView.l_v_o];
    
    [displayView l_v_setO:CGPointZero];
    [self.topView l_v_setS:displayView.l_v_s];
    
    [self addChildViewController:displayView];
    [self.topView addSubview:displayView.view];
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        self.topView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)removeTopView:(SGViewController *)displayView
{
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        self.topView.alpha=0;
    } completion:^(BOOL finished) {
        
        [displayView.view removeFromSuperview];
        [displayView removeFromParentViewController];
        
        self.topView.hidden=true;
    }];
}

-(void)dealloc
{
    self.contentNavigation=nil;
}

#pragma mark HomeViewController delegate

-(void)homeControllerFinishedLoad:(HomeViewController *)controller
{
    [self startUpload];
}

-(void)homeControllerTouchedHome1:(HomeViewController *)contorller home1:(UserHome1 *)home1
{
    SearchViewController *vc=[[SearchViewController alloc] initWithIDShops:home1.shopList];
    
    [self showSearchController:vc];
}

-(void)homeControllerTouchedNavigation:(HomeViewController *)controller
{
    [self showSettingController];
}

-(void)homeControllerTouchedPlacelist:(HomeViewController *)controller home3:(UserHome3 *)home3
{
    SearchViewController *vc=[[SearchViewController alloc] initWithPlace:home3.place];
    
    [self showSearchController:vc];
}

-(void)homeControllerTouchedTextField:(HomeViewController *)controller
{
    SearchViewController *vc=[SearchViewController new];
    
    [self showSearchController:vc];
}

-(void)homeControllerTouchedHome8:(HomeViewController *)controller home8:(UserHome8 *)home8
{
    [self presentShopUserWithHome8:home8];
}

-(void)homeControllerTouchedStore:(HomeViewController *)controller store:(StoreShop *)store
{
    
}

-(void)homeControllerTouchedIDShop:(HomeViewController *)controller idShop:(int)idShop
{
    [self presentShopUserWithIDShop:idShop];
}

-(void)shopUserRequestScanCode:(ShopUserViewController *)controller
{
    
}

#pragma mark SearchViewController

#pragma mark SettingViewController

-(void)navigationTouchedHome:(NavigationViewController *)controller
{
    [self hideSettingController];
    
    if([self.contentNavigation.visibleViewController isKindOfClass:[HomeViewController class]])
        return;
    
    [self.contentNavigation setRootViewController:[self homeController] animate:false];
}

-(void)navigationTouchedTutorial:(NavigationViewController *)controller
{
    [[GUIManager shareInstance] presentSGViewController:[self tutorialController] completion:nil];
}

-(void)navigationTouchedPromotion:(NavigationViewController *)controller
{
    [self hideSettingController];
    
    if([self.contentNavigation.visibleViewController isKindOfClass:[UserPromotionViewController class]])
        return;
    
    [self.contentNavigation setRootViewController:[self userPromotionController] animate:false];
}

-(void)navigationTouchedStore:(NavigationViewController *)controller
{

}

-(void)navigationTouchedUserSetting:(NavigationViewController *)controller
{
    [self hideSettingController];
    
    if([self.contentNavigation.visibleViewController isKindOfClass:[UserSettingViewController class]])
        return;
    
    [self.contentNavigation setRootViewController:[self userSettingController] animate:false];
}

#pragma mark UserSettingController

-(void)userSettingControllerFinished:(UserSettingViewController *)controller
{
    [self hideSettingController];
    
    [self.contentNavigation setRootViewController:[self homeController] animate:false];
}

-(void)userSettingControllerTouchedSetting:(UserSettingViewController *)controller
{
    [self showSettingController];
}

#pragma mark UserPromotionController

-(void)userPromotionTouchedIDShops:(UserPromotionViewController *)controller idShops:(NSString *)idShops
{
    SearchViewController *vc=[[SearchViewController alloc] initWithIDShops:idShops];
    [self showSearchController:vc];
}

-(void)userPromotionTouchedNavigation:(UserPromotionViewController *)controller
{
    [self showSettingController];
}

-(void)userPromotionTouchedTextField:(UserPromotionViewController *)controller
{
    SearchViewController *vc=[SearchViewController new];
    [self showSearchController:vc];
}

#pragma mark TutorialViewController

-(void)webviewTouchedBack:(WebViewController *)controller
{
    [[GUIManager shareInstance].rootNavigation dismissSGViewControllerCompletion:^{
        [[GUIManager shareInstance].rootNavigation.view makeAlphaViewBelowView:[GUIManager shareInstance].rootNavigation.leftSlideController.view];
    }];
}

#pragma mark ShopUserViewController

-(void)shopUserFinished:(ShopUserViewController *)controller
{
    [self dismissShopUser];
}

#pragma RootViewController handle

-(void) showSearchController:(SearchViewController*) controller
{
    controller.delegate=self;
    
    [self.contentNavigation pushViewController:controller animated:true];
}

-(void) startUpload
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[UserUploadGalleryManager shareInstance] startUploads];
        [[UserUploadAvatarManager shareInstance] startUploads];
    });
}

-(void)presentSGViewController:(SGViewController *)viewController
{
    if(self.contentNavigation.presentSGViewControlelr)
        return;
    
    [self.contentNavigation presentSGViewController:viewController completion:nil];
}

-(void) dismissSGPresentedViewController:(void (^)())onCompleted
{
    [self.contentNavigation dismissSGViewControllerCompletion:onCompleted];
}

-(void) presentShopUserWithShopUser:(Shop *)shop
{
    ShopUserViewController *vc=[[ShopUserViewController alloc] initWithShopUser:shop];
    
    [self presentShopUser:vc];
}

-(void) presentShopUserWithShopList:(ShopList *)shopList
{
    ShopUserViewController *shopUser=[[ShopUserViewController alloc] initWithShopUser:shopList.shop];
    
    [self presentShopUser:shopUser];
}

-(void)presentShopUserWithHome8:(UserHome8 *)home8
{
    ShopUserViewController *vc=[[ShopUserViewController alloc] initWithShopUser:home8.shop];

    [self presentShopUser:vc];
}

-(void)presentShopUserWithIDShop:(int)idShop
{
    ShopUserViewController *vc=[[ShopUserViewController alloc] initWithIDShop:idShop];

    [self presentShopUser:vc];
}

-(void) presentShopUser:(ShopUserViewController*) vc
{
    vc.delegate=self;
    
    if(self.presentSGViewControlelr)
    {
        if([self.presentSGViewControlelr isKindOfClass:[ShopUserViewController class]])
        {
            __block ShopUserViewController *_vc=vc;
            [self dismissSGViewControllerCompletion:^{
                [self presentShopUser:_vc];
                _vc=nil;
            }];
        }
        
        return;
    }
    
    [self presentSGViewController:vc completion:nil];
}

-(void) dismissShopUser
{
    [self dismissSGViewControllerCompletion:nil];
}

-(HomeViewController*) homeController
{
    HomeViewController *vc=[HomeViewController new];
    vc.delegate=self;
    
    return vc;
}

-(TutorialViewController*) tutorialController
{
    TutorialViewController *vc=[TutorialViewController new];
    vc.delegate=self;
    
    return vc;
}

-(UserPromotionViewController*) userPromotionController
{
    UserPromotionViewController *vc=[UserPromotionViewController new];
    vc.delegate=self;
    
    return vc;
}

-(UserSettingViewController*) userSettingController
{
    UserSettingViewController *vc=[UserSettingViewController new];
    vc.delegate=self;
    
    return vc;
}

#pragma mark UIGestureDelegate

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if(gestureRecognizer==tapGes)
    {
        if(scrollContent.currentPage==0)
        {
            CGPoint pnt=[tapGes locationInView:self.view];
            
            return pnt.x>274.f;
        }
        
        return false;
    }

    return true;
}

-(void) tap:(UITapGestureRecognizer*) tap
{
    [self hideSettingController];
}

-(void)showShopListWithIDPlace:(int)idPlacelist
{
    SearchViewController *vc=[[SearchViewController alloc] initWithIDPlace:idPlacelist];
    [self showSearchController:vc];
}

-(void)showShopListWithIDShops:(NSString *)idShops
{
    SearchViewController *vc=[[SearchViewController alloc] initWithIDShops:idShops];
    [self showSearchController:vc];
}

-(void)showShopListWithKeywords:(NSString *)keywords
{
    SearchViewController *vc=[[SearchViewController alloc] initWithKeyword:keywords];
    [self showSearchController:vc];
}

-(void)showTutorial
{
    TutorialViewController *vc=[TutorialViewController new];
    vc.delegate=self;
    [[GUIManager shareInstance] presentSGViewController:vc completion:nil];
}

-(void)showTerms
{
    TermsViewController *vc=[TermsViewController new];
    vc.delegate=self;
    
    [[GUIManager shareInstance] presentSGViewController:vc completion:nil];
}

-(void)showWebviewWithURL:(NSURL *)url
{
    WebViewController *vc=[[WebViewController alloc] initWithURL:url];
    vc.delegate=self;
    
    [[GUIManager shareInstance] presentSGViewController:vc completion:nil];
}

@end

@interface ScrollViewRoot()<UIGestureRecognizerDelegate>

@end

@implementation ScrollViewRoot

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.panGestureRecognizer.delegate=self;
}

-(void)setContentOffset:(CGPoint)contentOffset
{
    if(contentOffset.x<320.f-274)
        contentOffset.x=320.f-274;
    
    [super setContentOffset:contentOffset];
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if(gestureRecognizer==self.panGestureRecognizer)
    {
        if(self.currentPage==1)
        {
            CGPoint pnt=[self.panGestureRecognizer locationInView:self];
            pnt.x-=320;
            
            return pnt.x<80;
        }
    }
    
    return true;
}

@end