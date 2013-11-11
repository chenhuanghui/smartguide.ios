//
//  ViewController.m
//  SmartGuide
//
//  Created by XXX on 7/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ViewController.h"
#import "Utility.h"
#import "LoginViewController.h"
#import "ActivityIndicator.h"
#import "CatalogueBlockViewController.h"
#import "NavigationTitleView.h"
#import "CatalogueListViewController.h"
#import "SlideQRCodeViewController.h"
#import "BannerAdsViewController.h"
#import "FilterViewController.h"
#import "RootViewController.h"
#import "NavigationTitleView.h"
#import "FrontViewController.h"

@interface NavigationBarView(SupportViewController)

-(void) backToPreviousTitle;
-(void) setNavigationTitle:(NSString*) title;

-(void) setLeftIcon:(NSArray*) icons;
-(void) setRightIcon:(NSArray*) icons;
-(void) setDisableRighIcon:(NSArray*) icons;

@end

@interface ViewController ()
{
    UIBarButtonItem *settingItem;
    UIBarButtonItem *searchItem;
    UIBarButtonItem *avatarItem;
    UIBarButtonItem *locationItem;
    UIBarButtonItem *catalogueItem;
    UIBarButtonItem *filterItem;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *registerNotification=[self registerNotification];
    
    if(registerNotification)
    {
        for(NSString* str in registerNotification)
        {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:str object:nil];
        }
    }
}

-(void)receiveNotification:(NSNotification *)notification
{
    NSLog(@"receiveNotification %@",notification);
}

-(void)dismissModalViewControllerAnimated:(BOOL)animated
{
    [self unregisterNotification];
    
    [super dismissModalViewControllerAnimated:animated];
}

-(void)unregisterNotification
{
    NSArray *registerNotification=[self registerNotification];
    
    if(registerNotification)
        for(NSString *str in registerNotification)
        {
            [[NSNotificationCenter defaultCenter] removeObserver:self name:str object:nil];
        }
}

-(void)willPopViewController
{
    [self unregisterNotification];
}

-(NSArray *)leftNavigationItems
{
    return @[@(ITEM_SETTING),@(ITEM_SEARCH)];
}

-(NSArray *)rightNavigationItems
{
    return @[@(ITEM_MAP),@(ITEM_COLLECTION),@(ITEM_FILTER)];
}

-(void)navigationBarUserCollection:(UIButton *)sender
{
    NSLog(@"%@",CLASS_NAME);
    [[self frontViewController] navigationBarUserCollection:sender];
}

-(void)navigationBarCatalogue:(UIButton *)sender
{
    NSLog(@"%@",CLASS_NAME);
    [[self frontViewController] navigationBarCatalogue:sender];
}

-(void)navigationBarFilter:(UIButton *)sender
{
    NSLog(@"%@",CLASS_NAME);
    [[self frontViewController] navigationBarFilter:sender];
}

-(void)navigationBarList:(UIButton *)sender
{
    NSLog(@"%@",CLASS_NAME);
    [[self frontViewController] navigationBarList:sender];
}

-(void)navigationBarMap:(UIButton *)sender
{
    NSLog(@"%@",CLASS_NAME);
    [[self frontViewController] navigationBarMap:sender];
}

-(void)navigationBarSearch:(UIButton *)sender
{
    NSLog(@"%@",CLASS_NAME);
    [[self frontViewController] navigationBarSearch:sender];
}

-(void)navigationBarSetting:(UIButton *)sender
{
    NSLog(@"%@",CLASS_NAME);
    [[self frontViewController] navigationBarSetting:sender];
}

-(bool)allowBannerAds
{
    return true;
}

-(bool)allowBottomBar
{
    return true;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark ActivityIndicator

-(ActivityIndicator*)showIndicatoWithTitle:(NSString *)indicatorTitle
{
    NSString *msg=@"";
    if(indicatorTitle.length>0)
        msg=[@"  " stringByAppendingString:[NSString stringWithStringDefault:indicatorTitle]];
    
    ActivityIndicator *indicator=(ActivityIndicator*)[self.view viewWithTag:3333];
    
    if(!indicator)
    {
        indicator=[[ActivityIndicator alloc] initWithTitle:msg];
        indicator.tag=3333;
    }
    else
        [indicator setTitle:msg];
    
    CGRect rect=self.view.frame;
    rect.origin=CGPointZero;
    [indicator setFrame:rect];
    
    [self.view addSubview:indicator];
    
    return indicator;
}

-(ActivityIndicator*)showIndicatoWithTitle:(NSString *)indicatorTitle countdown:(int)countdown
{
    [self showIndicatoWithTitle:indicatorTitle];
    
    ActivityIndicator *indicator=(ActivityIndicator*)[self.view.subviews lastObject];
    indicator.delegate=self;
    indicator.countdown=countdown;
    
    return indicator;
}

-(void)activityIndicatorCountdownEnded:(ActivityIndicator *)activityIndicator
{
    
}

-(void)removeIndicator
{
    while ((ActivityIndicator*)[self.view viewWithTag:3333])
    {
        [[self.view viewWithTag:3333] removeFromSuperview];
    }
}

-(bool)isModal
{
    BOOL isModal = ((self.parentViewController && self.parentViewController.modalViewController == self) ||
                    //or if I have a navigation controller, check if its parent modal view controller is self navigation controller
                    ( self.navigationController && self.navigationController.parentViewController && self.navigationController.parentViewController.modalViewController == self.navigationController) ||
                    //or if the parent of my UITabBarController is also a UITabBarController class, then there is no way to do that, except by using a modal presentation
                    [[[self tabBarController] parentViewController] isKindOfClass:[UITabBarController class]]);
    
    //iOS 5+
    if (!isModal && [self respondsToSelector:@selector(presentingViewController)]) {
        
        isModal = ((self.presentingViewController && self.presentingViewController.modalViewController == self) ||
                   //or if I have a navigation controller, check if its parent modal view controller is self navigation controller
                   (self.navigationController && self.navigationController.presentingViewController && self.navigationController.presentingViewController.modalViewController == self.navigationController) ||
                   //or if the parent of my UITabBarController is also a UITabBarController class, then there is no way to do that, except by using a modal presentation
                   [[[self tabBarController] presentingViewController] isKindOfClass:[UITabBarController class]]);
    }
    
    return isModal;
}

-(void)viewDidUnload
{
    NSLog(@"%@ viewDidUnload",NSStringFromClass([self class]));
    
    [super viewDidUnload];
}

-(NSArray *)registerNotification
{
    return nil;
}

-(FrontViewController *)frontViewController
{
    return [RootViewController shareInstance].frontViewController;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return toInterfaceOrientation==UIInterfaceOrientationPortrait || toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationPortrait|UIInterfaceOrientationPortraitUpsideDown;;
}

-(BOOL)shouldAutorotate
{
    return true;
}

-(bool)allowDragPreviousView:(UIPanGestureRecognizer *)pan
{
    return true;
}

-(NSArray *)disableRightNavigationItems
{
    return [NSArray array];
}

-(void)configMenu
{
    [RootViewController shareInstance].navigationBarView.delegate=self;
    [[RootViewController shareInstance].navigationBarView setNavigationTitle:self.title];
    [[RootViewController shareInstance].navigationBarView setRightIcon:self.rightNavigationItems];
    [[RootViewController shareInstance].navigationBarView setDisableRighIcon:self.disableRightNavigationItems];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(UIRectEdge)edgesForExtendedLayout
{
    return UIRectEdgeNone;
}

-(BOOL)extendedLayoutIncludesOpaqueBars
{
    return false;
}

-(BOOL)automaticallyAdjustsScrollViewInsets
{
    return true;
}

-(BOOL)wantsFullScreenLayout
{
    return true;
}

@end