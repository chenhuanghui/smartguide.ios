//
//  SGNavigationViewController.m
//  SmartGuide
//
//  Created by MacMini on 28/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGNavigationController.h"
#import "SGViewController.h"

#define SLIDE_POSITION_X 274.f

CATransition* transitionPushFromBottomWithDuration(float duration)
{
    CATransition* transition = [CATransition animation];
    transition.duration = duration;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromBottom; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    
    return transition;
}

CATransition* transitionPushFromTopWithDuration(float duration)
{
    CATransition* transition = [CATransition animation];
    transition.duration = duration;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromTop; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    
    return transition;
}

CATransition* transitionPushFromLeftWithDuration(float duration)
{
    CATransition* transition = [CATransition animation];
    transition.duration = duration;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromLeft; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    
    return transition;

}

CATransition* transitionPushFromRightWithDuration(float duration)
{
    CATransition* transition = [CATransition animation];
    transition.duration = duration;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromRight; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    
    return transition;
}

CATransition* transitionPushFromBottom()
{
    return transitionPushFromBottomWithDuration(DURATION_NAVIGATION_PUSH);
}

CATransition* transitionPushFromTop()
{
    return transitionPushFromTopWithDuration(DURATION_NAVIGATION_PUSH);
}

CATransition* transitionPushFromLeft()
{
    return transitionPushFromLeftWithDuration(DURATION_NAVIGATION_PUSH);
}

CATransition* transitionPushFromRight()
{
    return transitionPushFromRightWithDuration(DURATION_NAVIGATION_PUSH);
}

@interface SGNavigationController ()

@end

@implementation SGNavigationController

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
    
    self.delegate=self;
    
    while (_controllers.count>0) {
        [self pushViewController:_controllers[0] animated:false];
        [_controllers removeObjectAtIndex:0];
    }
    
    _controllers=nil;
}

-(void) removeViewController:(UIViewController*) viewController
{
    if(!viewController || ![self.viewControllers containsObject:viewController])
        return;
    
    if(viewController==self.visibleViewController)
    {
        [self popViewControllerAnimated:false];
    }
    else
    {
        NSMutableArray *array=[self.viewControllers mutableCopy];
        [array removeObject:viewController];
        
        self.viewControllers=array;
    }
}

-(void)setRootViewController:(UIViewController *)viewController animate:(bool)animate onCompleted:(void (^)())onCompleted
{
    __block __weak SGNavigationController *weakSelf=self;
    _onPushedViewController=nil;
    _onPushedViewController=^(UIViewController*vc)
    {
        while (weakSelf.viewControllers.count>1 && weakSelf.viewControllers[0]!=viewController) {
            [[weakSelf.viewControllers[0] view] removeFromSuperview];
            [weakSelf.viewControllers[0] removeFromParentViewController];
        }
        
        if(onCompleted)
        {
            onCompleted();
        }
    };
    
    [self pushViewController:viewController animated:animate];
}

-(void)setRootViewController:(UIViewController *)viewController animate:(bool)animate
{
    [self setRootViewController:viewController animate:animate onCompleted:nil];
}

-(void)setRootViewControllers:(NSArray *)viewControllers animate:(bool)animate
{
    if(viewControllers.count==0)
        return;
    else if(viewControllers.count==1)
    {
        [self setRootViewController:viewControllers[0] animate:animate];
        return;
    }
    
    UIViewController *controller=[viewControllers lastObject];
    
    __block __weak SGNavigationController *weakSelf=self;
    _onPushedViewController=nil;
    _onPushedViewController=^(UIViewController*vc)
    {
        while (weakSelf.viewControllers.count>1 && weakSelf.viewControllers[0]!=controller) {
            [[weakSelf.viewControllers[0] view] removeFromSuperview];
            [weakSelf.viewControllers[0] removeFromParentViewController];
        }
        
        weakSelf.viewControllers=viewControllers;
    };
    
    [self pushViewController:controller animated:animate];
}

-(void)makeRootViewController:(UIViewController *)viewController
{
    
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if([self.navigationDelegate respondsToSelector:@selector(navigationController:willShowViewController:animated:)])
        [self.navigationDelegate navigationController:navigationController willShowViewController:viewController animated:animated];
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(_onPushedViewController)
    {
        __weak UIViewController *weakController=viewController;
        
        _onPushedViewController(weakController);
        _onPushedViewController=nil;
    }
    
    if(_onPoppedViewController)
    {
        __weak UIViewController *wController=viewController;
        _onPoppedViewController(wController);
        _onPoppedViewController=nil;
    }
    
    if([self.navigationDelegate respondsToSelector:@selector(navigationController:didShowViewController:animated:)])
        [self.navigationDelegate navigationController:self didShowViewController:viewController animated:animated];
}

-(void)dealloc
{
    DLOG_DEBUG(@"dealloc %@",CLASS_NAME);
    
    _prepareViewController=nil;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
}

-(void)pushViewController:(SGViewController *)viewController onCompleted:(void (^)())completed
{
    _onPushedViewController=nil;
    
    __block void(^_completed)() = [completed copy];

    double delayInSeconds = DURATION_NAVIGATION_PUSH;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        _completed();
    });
    
    [self pushViewController:viewController animated:true];
}

-(void)pushViewController:(UIViewController *)viewController withTransition:(CATransition *)transition
{
    [self.view.layer addAnimation:transition forKey:nil];
    [self pushViewController:viewController animated:false];
}

-(void)pushViewController:(SGViewController *)viewController andPopWithTransition:(CATransition *)transition
{
    __block __weak SGNavigationController *weakSelf=self;
    _onPushedViewController=nil;
    _onPushedViewController=^(UIViewController*vc)
    {
        if(weakSelf.viewControllers.count>1)
        {
            int index=[weakSelf.viewControllers indexOfObject:vc];
            
            if(index!=NSNotFound && index>0)
            {
                NSMutableArray *array=[weakSelf.viewControllers mutableCopy];
                [array removeObjectAtIndex:index-1];
                weakSelf.viewControllers=array;
            }
        }
    };
    
    [self.view.layer addAnimation:transition forKey:nil];
    [self pushViewController:viewController animated:false];
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated onCompleted:(void (^)())completed
{
    if(completed)
        _onPoppedViewController=[completed copy];
    
    for(SGViewController *vc in self.viewControllers)
    {
        if([vc isKindOfClass:[SGViewController class]])
            [vc navigationController:self willPopController:(SGViewController*)self.visibleViewController];
    }
    
    return [super popViewControllerAnimated:animated];
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    for(SGViewController *vc in self.viewControllers)
    {
        if([vc isKindOfClass:[SGViewController class]])
        [vc navigationController:self willPopController:(SGViewController*)self.visibleViewController];
    }
    
    if(animated)
    {
        [self.view.layer addAnimation:transitionPushFromLeft() forKey:nil];
        return [super popViewControllerAnimated:false];
    }
    
    return [super popViewControllerAnimated:animated];
}

-(UIViewController *)popSGViewControllerWithTransition:(CATransition *)transition
{
    [self.view.layer addAnimation:transition forKey:nil];
    
    return [self popViewControllerAnimated:false];
}

-(NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    return [super popToRootViewControllerAnimated:animated];
}

-(void)makePushViewController:(UIViewController *)viewController animate:(bool)animate
{
    if(self.visibleViewController==viewController)
        return;
    
    NSMutableArray *array=[self.viewControllers mutableCopy];
    [array removeObject:viewController];
    
    self.viewControllers=array;
    
    [self pushViewController:viewController animated:animate];
}

-(void)setDelegate:(id<UINavigationControllerDelegate>)delegate
{
    NSAssert(delegate==self, @"SGNavigation set delegate must be owner");
    
    [super setDelegate:delegate];
}

-(void)preparePushController:(SGViewController *)viewController
{
    _didLoadPrepareViewController=false;
    _didCallPushPrepareViewController=false;
    
    _prepareViewController=viewController;
    dispatch_async(dispatch_get_main_queue(), ^{
        [_prepareViewController view];
        _didLoadPrepareViewController=true;
        
        [self callPushPreparedViewController];
    });
}

-(void)pushViewControllerPrepared
{
    _didCallPushPrepareViewController=true;
    
    [self callPushPreparedViewController];
}

-(void) callPushPreparedViewController
{
    if(_didCallPushPrepareViewController && _didLoadPrepareViewController)
    {
        if(_prepareViewController)
            [self pushViewController:_prepareViewController animated:true];
        
        _prepareViewController=nil;
        
        _didCallPushPrepareViewController=false;
        _didLoadPrepareViewController=false;
    }
}

-(BOOL)prefersStatusBarHidden
{
    return false;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

@end