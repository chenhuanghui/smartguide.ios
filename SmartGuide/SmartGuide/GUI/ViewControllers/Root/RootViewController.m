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
#import "NotificationManager.h"
#import "UserNotificationViewController.h"
#import "UserNotificationDetailViewController.h"
#import "QRCodeViewController.h"
#import "RemoteNotificationView.h"

@interface RootViewController ()<NavigationControllerDelegate,UIScrollViewDelegate,HomeControllerDelegate,UserPromotionDelegate,SGUserSettingControllerDelegate,WebViewDelegate,ShopUserDelegate,UIGestureRecognizerDelegate,RemoteNotificationDelegate>

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
    
    NSMutableArray *array=[NSMutableArray array];
    
    HomeViewController *home=[HomeViewController new];
    home.delegate=self;
    
    [array addObject:home];
    
    if([NotificationManager shareInstance].launchNotification)
    {
        if([NotificationManager shareInstance].launchNotification.idNotification)
        {
            [array addObject:[UserNotificationViewController new]];
            [array addObject:[[UserNotificationDetailViewController alloc] initWithIDNotification:[NotificationManager shareInstance].launchNotification.idNotification.integerValue]];
        }
        
        [NotificationManager shareInstance].launchNotification=nil;
    }
    
    if(array.count==1)
        self.contentNavigation=[[SGNavigationController alloc] initWithRootViewController:home];
    else
        self.contentNavigation=[[SGNavigationController alloc] initWithViewControllers:array];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
#if !DEBUG
    btnMakeNotification.hidden=true;
#endif
    
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
    
    [[NotificationManager shareInstance] requestNotificationCheck];
}

-(NSArray *)registerNotifications
{
    return @[NOTIFICATION_RECEIVED_REMOTE_NOTIFICATION];
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:NOTIFICATION_RECEIVED_REMOTE_NOTIFICATION])
    {
        for(SGViewController *vc in self.contentNavigation.viewControllers)
        {
            if([vc respondsToSelector:@selector(receiveRemoteNotification:)])
                [vc receiveRemoteNotification:notification.object];
        }
        
        [self showNotificationInfo:notification.object];
    }
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
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [scrollContent setContentOffset:CGPointZero animated:true];
        scrollContent.userInteractionEnabled=false;
    });
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
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _isAnimatingSetting=scrollContent.l_co_x!=320;
        [scrollContent setContentOffset:CGPointMake(320, 0) animated:true];
        scrollContent.userInteractionEnabled=scrollContent.l_co_x==320;
    });
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
    
    UserSettingViewController *vc=[self userSettingController];
    vc.isNavigationButton=true;
    
    [self.contentNavigation setRootViewController:vc animate:false];
}

#pragma mark UserSettingController

-(void)userSettingControllerFinished:(UserSettingViewController *)controller
{
    if(self.contentNavigation.viewControllers.count==1)
    {
        [self hideSettingController];
        
        [self.contentNavigation setRootViewController:[self homeController] animate:false];
    }
    else
    {
        [self.contentNavigation popViewControllerAnimated:true];
    }
}

-(void)userSettingControllerTouchedBack:(UserSettingViewController *)controller
{
    if(self.contentNavigation.viewControllers.count==1)
        [self showSettingController];
    else
        [self.contentNavigation popViewControllerAnimated:true];
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
    
    if(self.contentNavigation.presentSGViewControlelr)
    {
        if([self.contentNavigation.presentSGViewControlelr isKindOfClass:[ShopUserViewController class]])
        {
            __block ShopUserViewController *_vc=vc;
            [self.contentNavigation dismissSGViewControllerCompletion:^{
                [self presentShopUser:_vc];
                _vc=nil;
            }];
        }
        
        return;
    }
    
    [self.contentNavigation presentSGViewController:vc completion:nil];
}

-(void) dismissShopUser
{
    [self.contentNavigation dismissSGViewControllerCompletion:nil];
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

-(void)showUserPromotion
{
    [self.contentNavigation pushViewController:[self userPromotionController] animated:true];
}

-(void)showUserSetting
{
    [self.contentNavigation pushViewController:[self userSettingController] animated:true];
}

-(void)showShopListWithKeywordsSearch:(NSString *)keywords
{
    SearchViewController *vc=[[SearchViewController alloc] initWithKeywordSearch:keywords];
    [self showSearchController:vc];
}

-(void)showShopListWithKeywordsShopList:(NSString *)keywords
{
    SearchViewController *vc=[[SearchViewController alloc] initWithKeywordShopList:keywords];
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
    if(!url || url.description.length==0)
        return;
    
    WebViewController *vc=[[WebViewController alloc] initWithURL:url];
    vc.delegate=self;
    
    [[GUIManager shareInstance] presentSGViewController:vc completion:nil];
}

-(void)removeUserNotification:(UserNotification *)obj
{
    if(remoteNotiView.userNotification==obj)
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoHideNotificationInfo) object:nil];
        [remoteNotiView hide];
    }
    else if([[NotificationManager shareInstance].notifications containsObject:obj])
    {
        [[NotificationManager shareInstance].notifications removeObject:obj];
    }
}

-(void)processUserNotification:(UserNotification *)obj
{
    switch (obj.enumActionType) {
        case USER_NOTIFICATION_ACTION_TYPE_CONTENT:
        {
            UserNotificationViewController *vc=[[UserNotificationViewController alloc] init];
            vc.delegate=self;
            
            [self.contentNavigation pushViewController:vc animated:true];
        }
            break;
            
        case USER_NOTIFICATION_ACTION_TYPE_LOGIN:
            [[GUIManager shareInstance] showLoginControll:^(bool isLogin) {
                
            }];
            break;
            
        case USER_NOTIFICATION_ACTION_TYPE_POPUP_URL:
            [self showWebviewWithURL:URL(obj.url)];
            break;
            
        case USER_NOTIFICATION_ACTION_TYPE_SCAN_CODE:
        {
            [self showQRCodeWithContorller:self inView:self.view withAnimationType:QRCODE_ANIMATION_TOP_BOT screenCode:@""];
        }
            break;
            
        case USER_NOTIFICATION_ACTION_TYPE_SHOP_LIST:
            if(obj.idPlacelist)
                [self showShopListWithIDPlace:obj.idPlacelist.integerValue];
            else if(obj.keywords.length>0)
                [self showShopListWithKeywordsShopList:obj.keywords];
            else if(obj.idShops.length>0)
                [self showShopListWithIDShops:obj.idShops];
            break;
            
        case USER_NOTIFICATION_ACTION_TYPE_SHOP_USER:
            [self presentShopUserWithIDShop:obj.idShop.integerValue];
            break;
            
        case USER_NOTIFICATION_ACTION_TYPE_USER_PROMOTION:
            break;
            
        case USER_NOTIFICATION_ACTION_TYPE_USER_SETTING:
            [self showUserSetting];
            break;
    }
}

-(void) autoHideNotificationInfo
{
    [remoteNotiView hide];
}

-(void)remoteNotificationDidHide:(RemoteNotificationView *)remoteView
{
    [[NotificationManager shareInstance].notifications removeObject:remoteView.userNotification];
    [remoteNotiView removeFromSuperview];
    remoteNotiView=nil;
    
    if([NotificationManager shareInstance].notifications.count>0)
    {
        [self showNotificationInfo:[NotificationManager shareInstance].notifications[0]];
    }
}

-(void)presentSGViewControllerFinished
{
    if([NotificationManager shareInstance].notifications.count>0)
    {
        [self showNotificationInfo:[NotificationManager shareInstance].notifications[0]];
    }
}

-(bool) isShowingNotification
{
    return remoteNotiView!=nil;
}

-(void)showNotificationInfo:(UserNotification*) obj
{
    // Check đang hiển thị notification hoặc popup
    if([self isShowingNotification] || self.presentSGViewControlelr)
        return;
    
    [self displayNotification:obj];
}

-(void) displayNotification:(UserNotification*) obj
{
    RemoteNotificationView *notiView =[RemoteNotificationView new];
    notiView.hidden=true;
    notiView.delegate=self;
    
    [self.contentView addSubview:notiView];
    
    remoteNotiView=notiView;
    [remoteNotiView setUserNotification:obj];
    [remoteNotiView show];
}

-(void)remoteNotificationViewTouched:(RemoteNotificationView *)remoteView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoHideNotificationInfo) object:nil];
    
    if(self.contentNavigation.presentSGViewControlelr)
    {
        [self.contentNavigation dismissSGViewControllerCompletion:^{
            [self remoteNotificationViewTouched:remoteView];
        }];
        
        return;
    }
    
    __strong UserNotification *obj=remoteView.userNotification;
    [self autoHideNotificationInfo];
    
    for(SGViewController *vc in self.contentNavigation.viewControllers)
    {
        if([vc respondsToSelector:@selector(processRemoteNotification:)])
            [vc processRemoteNotification:obj];
    }
    
    bool hasNotiController=false;
    bool hasNotiContentController=false;
    UserNotificationViewController *notiController=nil;
    UserNotificationDetailViewController *notiDetailController=nil;
    for(int i=0;i<self.contentNavigation.viewControllers.count;i++)
    {
        UIViewController *vc=self.contentNavigation.viewControllers[i];
        
        if([vc isKindOfClass:[UserNotificationViewController class]])
        {
            hasNotiController=true;
            notiController=(UserNotificationViewController*) vc;
        }
        else if([vc isKindOfClass:[UserNotificationDetailViewController class]])
        {
            hasNotiContentController=true;
            notiDetailController=(UserNotificationDetailViewController*)vc;
        }
        
        if(hasNotiController && hasNotiContentController)
            break;
    }
    
    if(!hasNotiController)
    {
        UserNotificationViewController *vc=[UserNotificationViewController new];
        vc.delegate=self;
        
        [self.contentNavigation pushViewController:vc animated:true];
    }
    else
    {
        if(hasNotiContentController && remoteView.userNotification.idNotification)
            [self.contentNavigation popToViewController:notiDetailController animated:true];
        else
            [self.contentNavigation popToViewController:notiController animated:true];
    }
    
    obj=nil;
}

-(void)remoteNotificationDidShow:(RemoteNotificationView *)remoteView
{
    if(remoteView.userNotification.timer.integerValue>0)
        [self performSelector:@selector(autoHideNotificationInfo) withObject:nil afterDelay:remoteView.userNotification.timer.integerValue];
}

- (IBAction)btnMakeNotificationTouchUpInside:(id)sender {
#if DEBUG
    
    NSDictionary *dict=[[NotificationManager shareInstance] makeNotification:_loopMakeNotification];
    
    [[NotificationManager shareInstance] receiveRemoteNotification:dict];
    
    _loopMakeNotification++;
    
    if(_loopMakeNotification==7)
        _loopMakeNotification=0;
    
#endif
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