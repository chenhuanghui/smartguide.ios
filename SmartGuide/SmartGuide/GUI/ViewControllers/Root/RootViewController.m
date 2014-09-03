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
#import "UserNotificationController.h"
#import "RemoteNotificationView.h"
#import "ShopUserController.h"
#import "TokenManager.h"
#import "ScanCodeController.h"
#import "RevealViewController.h"
#import "TabsController.h"
#import "TabbarButton.h"
#import "TabHomeViewController.h"
#import "TabSearchViewController.h"
#import "TabScanViewController.h"
#import "TabInboxViewController.h"
#import "TabUserViewController.h"
#import "NavigationController.h"

@interface RootViewController ()<NavigationControllerDelegate,UIScrollViewDelegate,HomeControllerDelegate,UserPromotionDelegate,SGUserSettingControllerDelegate,WebViewDelegate,ShopUserControllerDelegate,UIGestureRecognizerDelegate,RemoteNotificationDelegate, ScanCodeControllerDelegate, RevealControllerDelegate, SearchControllerDelegate, TabScanControllerDelegate>
{
    __weak RevealViewController *revealControlelr;
}

@property (nonatomic, strong) TabsController *tabsController;
@property (nonatomic, strong) TabScanViewController *scanController;

@end

@implementation RootViewController

-(RootViewController *)init
{
    self=[super initWithNibName:@"RootViewController" bundle:nil];
    
    return self;
}

-(void)loadView
{
    [super loadView];
    
    self.tabsController=[TabsController new];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    btnTabHome.tabbarButtonType=TABBAR_BUTTON_TYPE_HOME;
    btnTabSearch.tabbarButtonType=TABBAR_BUTTON_TYPE_SEARCH;
    btnTabScan.tabbarButtonType=TABBAR_BUTTON_TYPE_SCAN;
    btnTabInbox.tabbarButtonType=TABBAR_BUTTON_TYPE_INBOX;
    btnTabUser.tabbarButtonType=TABBAR_BUTTON_TYPE_USER;
    
    [_containView addSubview:self.tabsController.view];
}

-(void)viewWillAppearOnce
{
    self.tabsController.view.S=self.containView.S;
}

- (IBAction)btnHomeTouchUpInside:(id)sender {
    [self setSelectedButton:sender];
    
    [_tabsController setSelectedViewController:_tabsController.tabHome];
}

- (IBAction)btnSearchTouchUpInside:(id)sender {
    [self setSelectedButton:sender];
    
    [_tabsController setSelectedViewController:_tabsController.tabSearch];
}

- (IBAction)btnScanTouchUpInside:(id)sender {
    [self setSelectedButton:sender];
    
    self.scanController=[[TabScanViewController alloc] initWithDelegate:self];
    [self.view addSubview:self.scanController.view];
    self.scanController.view.S=self.view.S;
}

-(void)tabScanControllerTouchedClose:(TabScanViewController *)controller
{
    [self.scanController.view removeFromSuperview];
    self.scanController=nil;
}

- (IBAction)btnInboxTouchUpInside:(id)sender {
    [self setSelectedButton:sender];
    
    _tabsController.selectedViewController=_tabsController.tabInbox;
}

- (IBAction)btnUserTouchUpInside:(id)sender {
    [self setSelectedButton:sender];
    
    _tabsController.selectedViewController=_tabsController.tabUser;
}

-(void) setSelectedButton:(UIButton*) btnSelected
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        btnTabHome.selected=btnTabHome==btnSelected;
        btnTabScan.selected=btnTabScan==btnSelected;
        btnTabSearch.selected=btnTabSearch==btnSelected;
        btnTabInbox.selected=btnTabInbox==btnSelected;
        btnTabUser.selected=btnTabUser==btnSelected;
    });
}

-(void)loadView1
{
    [super loadView];
    
    NSMutableArray *array=[NSMutableArray array];
    
    HomeViewController *home=[HomeViewController new];
    home.delegate=self;
    
    [array addObject:home];
    
    if(currentUser().enumDataMode==USER_DATA_FULL)
    {
        if([NotificationManager shareInstance].launchNotification)
        {
            if([NotificationManager shareInstance].launchNotification.idSender)
            {
                UserNotificationController *vc=[[UserNotificationController alloc] initWithIDSender:[NotificationManager shareInstance].launchNotification.idSender];
                [array addObject:vc];
            }
            else
            {
                UserNotificationController *vc=[UserNotificationController new];
                
                [array addObject:vc];
            }
            
            [NotificationManager shareInstance].launchNotification=nil;
        }
    }
    else
    {
        [NotificationManager shareInstance].launchNotification=nil;
    }
    
    if(array.count==1)
        self.contentNavigation=[[SGNavigationController alloc] initWithRootViewController:home];
    else
        self.contentNavigation=[[SGNavigationController alloc] initWithViewControllers:array];
}

- (void)viewDidLoad1
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
#if DEBUG
    [SGData shareInstance].buildMode=@([[NSUserDefaults standardUserDefaults] integerForKey:@"buildMode"]);
    btnBuildMode.hidden=false;
    [btnBuildMode setTitle:([SGData shareInstance].buildMode.boolValue?@"PRO":@"DEV") forState:UIControlStateNormal];
    btnNoti.hidden=false;
#endif
    
    self.containView.layer.masksToBounds=true;
    
    self.settingController=[NavigationViewController new];
    self.settingController.delegate=self;
    
    RevealViewController *rev=[[RevealViewController alloc] initWithFrontController:self.contentNavigation rearController:self.settingController];
    rev.delegate=self;
    
    [self addChildViewController:rev];
    
    revealControlelr=rev;
    
    [[NotificationManager shareInstance] requestNotificationCount];
}

-(void)viewWillAppearOnce1
{
    [self.containView addSubview:revealControlelr.view];
    [revealControlelr.view l_v_setS:self.containView.l_v_s];
    
    [revealControlelr showFrontController:false];
}

-(NSArray *)registerNotifications
{
    return @[NOTIFICATION_RECEIVED_REMOTE_NOTIFICATION,NOTIFICATION_HOME_FINISHED_LOAD];
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:NOTIFICATION_RECEIVED_REMOTE_NOTIFICATION])
    {
        [[NotificationManager shareInstance] requestNotificationCount];
        
        if([notification.object isFromBG].boolValue)
            [self processRemoteNotification:notification.object];
        else
            [self showRemoteNotification:notification.object];
    }
    else if([notification.name isEqualToString:NOTIFICATION_HOME_FINISHED_LOAD])
    {
        [self startUpload];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if([KeyboardUtility shareInstance].isKeyboardVisible)
        [self.view endEditing:true];
}

-(void)showSettingController
{
    [revealControlelr showRearController:true];
}

-(void) hideSettingController
{
    [revealControlelr showFrontController:true];
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

#pragma mark RevealViewController delegate

-(void)revealControllerWillDisplayRearView:(RevealViewController *)controlelr
{
    [self.settingController loadData];
}

#pragma mark HomeViewController delegate

-(void)homeControllerTouchedHome1:(HomeViewController *)contorller home1:(UserHome1 *)home1
{
    SearchViewController *vc=[[SearchViewController alloc] initWithIDShops:home1.shopList];
    
    [self showSearchController:vc];
}

-(void)homeControllerTouchedNavigation:(HomeViewController *)controller
{
    [self showSettingController];
}

-(void)homeControllerTouched:(HomeViewController *)controller placeList:(Placelist *)placelist
{
    SearchViewController *vc=[[SearchViewController alloc] initWithPlace:placelist];
    
    [self showSearchController:vc];
}

-(void)homeControllerTouchedSearch:(HomeViewController *)controller
{
    SearchViewController *vc=[SearchViewController new];
    
    [self showSearchController:vc];
}

-(void)homeControllerTouched:(HomeViewController *)controller shop:(Shop *) shop
{
    [self presentShopUserWithShop:shop];
}

-(void)homeControllerTouched:(HomeViewController *)controller idShop:(int)idShop
{
    [self presentShopUserWithIDShop:idShop];
}

-(void)homeControllerTouched:(HomeViewController *)controller idPlacelist:(int)idPlacelist
{
    [self showShopListWithIDPlace:idPlacelist];
}

-(void)homeControllerTouched:(HomeViewController *)controller idShops:(NSString *)idShops
{
    [self showShopListWithIDShops:idShops];
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
    [self showTutorial];
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

#pragma mark ShopUserViewController

-(void)shopUserControllerTouchedBack:(ShopUserController *)controller
{
    [self dismissShopUser];
}

#pragma RootViewController handle

-(void) showSearchController:(SearchViewController*) controller
{
    controller.delegate=self;
    
    [self.contentNavigation pushViewController:controller animated:true];
}

-(void)searchControllerTouchedBack:(SearchViewController *)controller
{
    [self.contentNavigation popViewControllerAnimated:true];
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

-(void) presentShopUserWithShop:(Shop *)shop
{
    ShopUserController *vc=[[ShopUserController alloc] initWithShop:shop];
    
    [self presentShopUser:vc];
}

-(void)presentShopUserWithIDShop:(int)idShop
{
    ShopUserController *vc=[[ShopUserController alloc] initWithIDShop:idShop];
    
    [self presentShopUser:vc];
}

-(void) presentShopUser:(ShopUserController*) vc
{
    vc.delegate=self;
    
    [self.contentNavigation pushViewController:vc animated:true];
}

-(void) dismissShopUser
{
    if([self.contentNavigation.visibleViewController isKindOfClass:[ShopUserController class]])
        [self.contentNavigation popViewControllerAnimated:true];
}

-(HomeViewController*) homeController
{
    HomeViewController *vc=[HomeViewController new];
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

-(void)showShopListWithIDBranch:(int)idBranch
{
    SearchViewController *vc=[[SearchViewController alloc] initWithIDBranch:idBranch];
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

-(void)showSearchShopWithKeywordsSearch:(NSString *)keywords
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
    [self showWebViewWithURL:URL(@"http://infory.vn/mobile/guide") onCompleted:nil];
}

-(void)showTerms
{
    [self showWebViewWithURL:URL(@"http://infory.vn/dieu-khoan-nguoi-dung.html") onCompleted:nil];
}

-(void)removeUserNotification:(UserNotification *)obj
{
    //    if(remoteNotiView.userNotification==obj)
    //    {
    //        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoHideNotificationInfo) object:nil];
    //        [remoteNotiView hide];
    //    }
    //    else if([[NotificationManager shareInstance].notifications containsObject:obj])
    //    {
    //        [[NotificationManager shareInstance].notifications removeObject:obj];
    //    }
}

-(void) autoHideNotificationInfo
{
    [remoteNotiView hide];
}

-(void)remoteNotificationDidHide:(RemoteNotificationView *)remoteView
{
    [[NotificationManager shareInstance].remoteNotifications removeObject:remoteView.remoteNotification];
    [remoteNotiView removeFromSuperview];
    remoteNotiView=nil;
    
    if([NotificationManager shareInstance].remoteNotifications.count>0)
    {
        [self showRemoteNotification:[NotificationManager shareInstance].remoteNotifications[0]];
    }
}

-(void)presentSGViewControllerFinished
{
    [self showNextRemoteNotification];
}

-(void)dialogControllerFinished
{
    [self showNextRemoteNotification];
}

-(void) showNextRemoteNotification
{
    if([NotificationManager shareInstance].remoteNotifications.count>0)
    {
        [self showRemoteNotification:[NotificationManager shareInstance].remoteNotifications[0]];
    }
}

-(bool) isShowingNotification
{
    return remoteNotiView!=nil;
}

-(void)showRemoteNotification:(RemoteNotification*) obj
{
    // Check đang hiển thị notification hoặc popup
    if([self isShowingNotification] || self.presentSGViewControlelr || self.dialogController)
        return;
    
    [self displayNotification:obj];
}

-(void) displayNotification:(RemoteNotification*) obj
{
    if(obj.isFromBG.boolValue)
        return;
    
    RemoteNotificationView *notiView =[RemoteNotificationView new];
    notiView.hidden=true;
    notiView.delegate=self;
    
    [self.containView addSubview:notiView];
    
    remoteNotiView=notiView;
    [remoteNotiView setRemoteNotification:obj];
    [remoteNotiView show];
}

-(void)processRemoteNotification:(RemoteNotification *)obj
{
    if(self.contentNavigation.presentSGViewControlelr)
    {
        [self.contentNavigation dismissSGViewControllerCompletion:^{
            [self processRemoteNotification:obj];
        }];
        
        return;
    }
    
    if(!obj.isFromBG.boolValue)
        [self autoHideNotificationInfo];
    
    UserNotificationController *vc=nil;
    
    for(vc in self.contentNavigation.viewControllers)
    {
        if([vc isKindOfClass:[UserNotificationController class]])
            break;
    }
    
    if([vc isKindOfClass:[UserNotificationController class]])
    {
        [self.contentNavigation popToViewController:vc animated:true];
    }
    else
    {
        if(obj.idSender)
            vc=[[UserNotificationController alloc] initWithIDSender:obj.idSender];
        else
            vc=[UserNotificationController new];
        
        [self.contentNavigation pushViewController:vc animated:true];
    }
    
    obj=nil;
}

-(void)remoteNotificationViewTouched:(RemoteNotificationView *)remoteView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoHideNotificationInfo) object:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_TOUCHED_REMOTE_NOTIFICATION object:remoteView.remoteNotification];
}

-(void)remoteNotificationViewTouchedClose:(RemoteNotificationView *)remoteView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoHideNotificationInfo) object:nil];
    [remoteView hide];
}

-(void)remoteNotificationDidShow:(RemoteNotificationView *)remoteView
{
    if(remoteView.remoteNotification.timer.integerValue>0)
        [self performSelector:@selector(autoHideNotificationInfo) withObject:nil afterDelay:remoteView.remoteNotification.timer.integerValue];
}

- (IBAction)btnBuildModeTouchUpInside:(id)sender {
#if DEBUG
    [SGData shareInstance].buildMode=@(![SGData shareInstance].buildMode.boolValue);
    [btnBuildMode setTitle:([SGData shareInstance].buildMode.boolValue?@"PRO":@"DEV") forState:UIControlStateNormal];
    [[NSUserDefaults standardUserDefaults] setInteger:[SGData shareInstance].buildMode.integerValue forKey:@"buildMode"];
    [[NSUserDefaults standardUserDefaults] synchronize];
#endif
}

- (IBAction)btnNotiTouchUpInside:(id)sender {
#if DEBUG
    NSDictionary *dict=[[NotificationManager shareInstance] makeNotification:NOTIFICATION_ACTION_TYPE_POPUP_URL];
    [[NotificationManager shareInstance] receiveRemoteNotification:dict];
#endif
}

-(bool)allowDragToNavigation
{
    if([self presentSGViewControlelr])
        return false;
    if([self.contentNavigation presentSGViewControlelr])
        return false;
    if([self.contentNavigation.visibleViewController presentSGViewControlelr])
        return false;
    
    SGViewController *vc=(SGViewController*)self.contentNavigation.visibleViewController;
    
    if([vc isKindOfClass:[SGViewController class]])
    {
        if(![vc allowDragToNavigation])
            return false;
    }
    
    return true;
}

@end