//
//  SGNavigationViewController.m
//  SmartGuide
//
//  Created by MacMini on 28/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGNavigationController.h"

#define SLIDE_POSITION_X 245.f

@interface SGNavigationController ()

@end

@implementation SGNavigationController
@synthesize leftSlideController,rightSlideController,previousViewController;

-(SGNavigationController *)initWithViewControllers:(NSArray *)controllers
{
    self=[super init];
    
    _controllers=[controllers mutableCopy];
    
    return self;
}

-(void)loadView
{
    [self setNavigationBarHidden:true];
    
    [super loadView];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    while (_controllers.count>0) {
        [self pushViewController:_controllers[0] animated:false];
        [_controllers removeObjectAtIndex:0];
    }
    
    _controllers=nil;
}

-(void)setRootViewController:(UIViewController *)viewController animate:(bool)animate
{
    self.delegate=self;
    
    __block __weak SGNavigationController *weakSelf=self;
    _onPushedViewController=nil;
    _onPushedViewController=^(UIViewController*vc)
    {
        while (weakSelf.viewControllers.count>1 && weakSelf.viewControllers[0]!=viewController) {
            [[weakSelf.viewControllers[0] view] removeFromSuperview];
            [weakSelf.viewControllers[0] removeFromParentViewController];
        }
    };
    
    [self pushViewController:viewController animated:animate];
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if(animated)
    {
        if(_animationPopViewController)
        {
            CATransition *transition=_animationPopViewController(self.visibleViewController);
            
            if(transition)
            {
                [self.view.layer addAnimation:transition forKey:nil];
            }
        }
    }
    
    UIViewController *vc=[super popViewControllerAnimated:animated];
    
    _animationPopViewController=nil;
    
    return vc;
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(_onPushedViewController)
    {
        _onPushedViewController(viewController);
        _onPushedViewController=nil;
    }
}

CALL_DEALLOC_LOG

-(BOOL)prefersStatusBarHidden
{
    return true;
}

-(void)setAnimationPopViewController:(CATransition *(^)(UIViewController *))animationPop
{
    _animationPopViewController=nil;
    
    if(animationPop)
        _animationPopViewController=[animationPop copy];
}

-(void)showLeftSlideViewController:(UIViewController *)viewController animate:(bool)animated
{
    if(self.leftSlideController)
        return;
    
    [viewController view];
    
    previousViewController=self.visibleViewController;
    
    if(!self.leftSlideController)
    {
        leftSlideController=[[UIViewController alloc] init];
        leftSlideController.view.center=CGPointMake(-self.view.frame.size.width/2, self.view.frame.size.height/2);
        
        [self addChildViewController:leftSlideController];
        [self.view addSubview:leftSlideController.view];
    }
    
    [leftSlideController addChildViewController:viewController];
    [leftSlideController.view addSubview:viewController.view];
    
    [UIView animateWithDuration:DURATION_SHOW_SETTING+0.01 animations:^{
        previousViewController.view.center=CGPointMake(previousViewController.view.center.x+SLIDE_POSITION_X, self.view.frame.size.height/2);
    }];
    
    [UIView animateWithDuration:DURATION_SHOW_SETTING animations:^{
        leftSlideController.view.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    } completion:^(BOOL finished) {
        
    }];
    
    _tapSlideGes=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftTapGes:)];
    _tapSlideGes.delegate=self;
    
    _panSlideGes=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(leftPanGes:)];
    _panSlideGes.delegate=self;
    
    [_panSlideGes requireGestureRecognizerToFail:_tapSlideGes];
    
    [self.view addGestureRecognizer:_tapSlideGes];
    [self.view addGestureRecognizer:_panSlideGes];
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if(gestureRecognizer==_tapSlideGes)
    {
        CGPoint pnt=[_tapSlideGes locationInView:self.view];
        return CGRectContainsPoint(CGRectMake(SLIDE_POSITION_X, 0, self.l_v_w-SLIDE_POSITION_X, self.l_v_h), pnt);
    }
    else if(gestureRecognizer==_panSlideGes)
    {
        CGPoint pnt=[_panSlideGes velocityInView:self.view];
        return fabsf(pnt.x)>fabsf(pnt.y);
    }
    
    return true;
}

-(void) leftTapGes:(UITapGestureRecognizer*) tap
{
    [self moveToVisibleView];
}

-(void) leftPanGes:(UIPanGestureRecognizer*) pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            _panStartPoint=[pan locationInView:pan.view];
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            float velocity=[pan velocityInView:pan.view].x;
            
            if(velocity<0 && velocity<-VELOCITY_SLIDE)
                return;
            
            CGPoint pnt=[pan locationInView:pan.view];
            float deltaX=pnt.x-_panStartPoint.x;
            _panStartPoint=pnt;
            
            if(self.leftSlideController.l_c_x+deltaX>self.l_v_w/2)
            {
                [self.leftSlideController l_c_setX:self.l_v_w/2];
                [self.previousViewController l_c_setX:self.l_v_w/2+SLIDE_POSITION_X];
            }
            else
            {
                [self.leftSlideController l_c_addX:deltaX];
                [self.previousViewController l_c_addX:deltaX];
            }
        }
            break;
            
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        {
            float velocity=[pan velocityInView:pan.view].x;
            
            if(velocity<0 && velocity<-VELOCITY_SLIDE)
                [self moveToVisibleView];
            else
            {
                if(self.leftSlideController.l_c_x>self.l_v_w/2+self.l_v_w/4)
                    [self moveToVisibleView];
                else
                    [self moveToLeftSlide];
            }
        }
            break;
            
        default:
            break;
    }
}

-(void) moveToLeftSlide
{
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        [self.leftSlideController l_c_setX:self.l_v_w/2];
        [self.previousViewController l_c_setX:self.l_v_w/2+SLIDE_POSITION_X];
    } completion:^(BOOL finished) {
    }];
}

-(void) moveToVisibleView
{
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        [self.leftSlideController l_c_setX:-self.l_v_w/2];
        [self.previousViewController l_c_setX:self.l_v_w/2];
    } completion:^(BOOL finished) {
        [self.leftSlideController removeFromParentViewController];
        [self.leftSlideController.view removeFromSuperview];
        
        _panStartPoint=CGPointZero;
        [_panSlideGes removeTarget:self action:@selector(leftPanGes:)];
        [self.view removeGestureRecognizer:_panSlideGes];
        _panSlideGes=nil;
        
        [_tapSlideGes removeTarget:self action:@selector(leftTapGes:)];
        [self.view removeGestureRecognizer:_tapSlideGes];
        _tapSlideGes=nil;
        
        leftSlideController=nil;
    }];
}

-(void)removeLeftSlideViewController
{
    if(self.leftSlideController)
    {
        [self moveToVisibleView];
    }
}

@end
