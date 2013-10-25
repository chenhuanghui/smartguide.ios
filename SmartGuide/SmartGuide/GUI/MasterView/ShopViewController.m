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
@synthesize previousController;

-(id)init
{
    ShopCategoriesViewController *vc=[[ShopCategoriesViewController alloc] init];
    vc.delegate=self;
    
    self=[super initWithRootViewController:vc];
    self.delegate=self;
    [self setNavigationBarHidden:true];
    
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIPanGestureRecognizer *panGes=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    panGes.delegate=self;
    
    [self.view addGestureRecognizer:panGes];
}

-(void) panGesture:(UIPanGestureRecognizer*) ges
{
    if([self.visibleViewController isKindOfClass:[ShopCategoriesViewController class]])
    {
        return;
    }
    
    switch (ges.state) {
            
        case UIGestureRecognizerStateBegan:
            _startDragPoint=[ges locationInView:ges.view];
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGPoint pnt=[ges locationInView:ges.view];
            float deltaX=pnt.x-_startDragPoint.x;
            _startDragPoint=pnt;
            previousController.view.center=CGPointMake(previousController.view.center.x+deltaX, previousController.view.center.y);
            self.visibleViewController.view.center=CGPointMake(self.visibleViewController.view.center.x+deltaX, self.visibleViewController.view.center.y);
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        {
            float velocity=[ges velocityInView:ges.view].x;
            
            NSLog(@"velocity %f",velocity);
            
            if(velocity>0 && velocity>VELOCITY_SLIDE)
            {
                [self moveToPreviousViewController];
            }
            else
            {
                [self moveToVisibleViewController];
            }
        }
            break;
            
        default:
            break;
    }
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
    
    NSLog(@"idx %i",idx);
    
    previousController=self.viewControllers[idx];
    
    if(previousController!=self.visibleViewController)
    {
        previousController.view.center=CGPointMake(-self.view.frame.size.width/2, previousController.view.center.y);
        [self.view addSubview:previousController.view];
    }
    
    NSLog(@"previousController %@",previousController);
}

@end
