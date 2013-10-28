//
//  MainViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopViewController.h"

@interface ShopViewController ()

@end

@implementation ShopViewController
@synthesize previousController,shopDelegate;

-(id)init
{
    ShopCatalogViewController *vc=[[ShopCatalogViewController alloc] init];
    vc.delegate=self;
    
    self=[super initWithRootViewController:vc];
    self.delegate=self;
    [self setNavigationBarHidden:true];
    
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavigationBarHidden:true];
}

-(BOOL)gestureRecognizerShouldBegin1:(UIGestureRecognizer *)gestureRecognizer
{
    if(gestureRecognizer==panGes)
    {
        if(self.previousController==self.visibleViewController)
            return false;
        
        float velocity=[panGes velocityInView:panGes.view].x;
        if(self.visibleViewController.view.frame.origin.x==0 && velocity<0)
            return false;
    }
    
    return true;
}

-(void) panGesture:(UIPanGestureRecognizer*) ges
{
    [panHandle handlePanGesture:ges];
}

-(void) moveToVisibleViewController
{
    [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
        self.visibleViewController.view.center=CGPointMake(self.view.frame.size.width/2, self.visibleViewController.view.center.y);
        self.previousController.view.center=CGPointMake(-self.view.frame.size.width/2, previousController.view.center.y);
    } completion:^(BOOL finished) {
    }];
}

-(void) moveToPreviousViewController
{
    [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
        self.previousController.view.center=CGPointMake(self.view.frame.size.width/2, self.previousController.view.center.y);
        self.visibleViewController.view.center=CGPointMake(self.view.frame.size.width*1.5f, self.visibleViewController.view.center.y);
    } completion:^(BOOL finished) {
        [self popViewControllerAnimated:false];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)title
{
    return CLASS_NAME;
}

-(void)shopCategoriesSelectedGroup
{
    ShopListViewController *shopList=[[ShopListViewController alloc] init];
    shopList.delegate=self;

    [self pushViewController:shopList animated:true];
}

-(void)shopListSelectedShop
{
    ShopUserViewController *shopUser=[[ShopUserViewController alloc] init];
    shopUser.delegate=self;
    
    [self.shopDelegate shopViewSelectedShop];
    [self pushViewController:shopUser animated:true];
}

-(void)shopUserFinished
{
    [self popViewControllerAnimated:true];
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    int idx=[self.viewControllers indexOfObject:viewController];
    
    idx--;
    
    if(idx<0)
        idx=0;
    
    previousController=self.viewControllers[idx];
    
    if(previousController!=self.visibleViewController)
    {
        previousController.view.center=CGPointMake(-self.view.frame.size.width/2, previousController.view.center.y);
        [self.view addSubview:previousController.view];
        
        if(panGes)
        {
            [panGes removeTarget:self action:@selector(panGesture:)];
            panGes.delegate=nil;
            [self.view removeGestureRecognizer:panGes];
            panGes=nil;
        }
        
        if(panHandle)
        {
            panHandle.delegate=nil;
            panHandle=nil;
        }
        
        panGes=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
        panGes.delegate=self;
        
        [self.view addGestureRecognizer:panGes];
        
        panHandle=[[PanGestureView alloc] initWithDirection:PanGestureDirectionToLeft withCurrentView:previousController.view withOtherView:viewController.view];
        panHandle.delegate=self;
    }
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    UIViewController *vc=[super popViewControllerAnimated:animated];
    if([vc isKindOfClass:[ShopUserViewController class]])
        [self.shopDelegate shopViewBackToShopListAnimated:animated];
    
    return vc;
}

-(void)dealloc
{
    panGes=nil;
    
    DEALLOC_LOG;
}

-(void)panGestureMovedToView:(UIView *)view
{
    if(view==self.previousController.view)
    {
        [self popViewControllerAnimated:false];
        
        if(panGes)
        {
            [panGes removeTarget:self action:@selector(panGesture:)];
            panGes.delegate=nil;
            [self.view removeGestureRecognizer:panGes];
            panGes=nil;
        }
        
        if(panHandle)
        {
            panHandle.delegate=nil;
            panHandle=nil;
        }
    }
}

@end
