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

@property (nonatomic, assign) CGPoint panPreviousStartPoint;
@property (nonatomic, weak) UIPanGestureRecognizer *panSlide;
@property (nonatomic, weak) UITapGestureRecognizer *tapSlide;
@property (nonatomic, assign) CGPoint panSlideStartPoint;

@end

@implementation SGNavigationController
@synthesize leftSlideController,rightSlideController,previousViewController;
@synthesize isAllowDragBackPreviouseView;
@synthesize panPrevious,panPreviousStartPoint;
@synthesize panSlide,tapSlide,panSlideStartPoint;
@synthesize lblTitle;

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

-(void)setRootViewController:(UIViewController *)viewController animate:(bool)animate
{
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

-(void)makeRootViewController:(UIViewController *)viewController
{
    
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(_onPushedViewController)
    {
        __weak UIViewController *weakController=viewController;
        
        _onPushedViewController(weakController);
        _onPushedViewController=nil;
    }
}

-(void)dealloc
{
    DEALLOC_LOG
    
    _prepareViewController=nil;
}

-(BOOL)prefersStatusBarHidden
{
    return true;
}

-(void)showRightSlideViewController:(UIViewController *)viewController animate:(bool)animated
{
    if(self.rightSlideController)
        return;
    
    [viewController view];
    
    previousViewController=self.visibleViewController;
    
    if(!self.rightSlideController)
    {
        SGRightViewController *vc=[[SGRightViewController alloc] init];
        vc.view.frame=CGRectMake(self.l_v_w, self.l_v_y, self.l_v_w, self.l_v_h);
        
        rightSlideController=vc;
        
        [self addChildViewController:vc];
        [self.view addSubview:vc.view];
    }
    
    [rightSlideController addChildViewController:viewController];
    [rightSlideController.view addSubview:viewController.view];
    
    [self.view makeAlphaViewBelowView:rightSlideController.view];
    
    if(animated)
    {
        [UIView animateWithDuration:DURATION_DEFAULT animations:^{
            [previousViewController.view l_c_setX:-self.l_v_w/2];
            [rightSlideController.view l_c_setX:self.l_v_w/2];
        } completion:^(BOOL finished) {
            
        }];
    }
    else
    {
        [previousViewController.view l_c_setX:-self.l_v_w/2];
        [rightSlideController.view l_c_setX:self.l_v_w/2];
    }
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightTapGes:)];
    tap.delegate=self;
    
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(rightPanGes:)];
    pan.delegate=self;
    
    [pan requireGestureRecognizerToFail:tap];
    
    panSlide=pan;
    tapSlide=tap;
    
    [self.view addGestureRecognizer:tap];
    [self.view addGestureRecognizer:pan];
}

-(void) rightTapGes:(UITapGestureRecognizer*) tap
{
    [self moveToVisibleView];
}

-(void) rightPanGes:(UIPanGestureRecognizer*) pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            panSlideStartPoint=[pan locationInView:pan.view];
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            float velocity=[pan velocityInView:pan.view].x;
            
            if(velocity>0 && velocity>VELOCITY_SLIDE)
                return;
            
            CGPoint pnt=[pan locationInView:pan.view];
            float deltaX=pnt.x-panSlideStartPoint.x;
            panSlideStartPoint=pnt;
            
            if(self.rightSlideController.l_v_x+deltaX<0)
            {
                [self.rightSlideController l_v_setX:0];
                [self.previousViewController l_v_setX:-self.l_v_w/2];
            }
            else
            {
                [self.rightSlideController l_c_addX:deltaX];
                [self.previousViewController l_c_addX:deltaX];
            }
        }
            break;
            
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        {
            if(self.viewControllers.count<=1)
                return;
            
            float velocity=[pan velocityInView:pan.view].x;
            
            if(velocity>0 && velocity>VELOCITY_SLIDE)
                [self moveToVisibleView];
            else
            {
                if(self.rightSlideController.l_v_x<self.l_v_w/4)
                    [self moveToRightSlide];
                else
                    [self moveToVisibleView];
            }
        }
            break;
            
        default:
            break;
    }
}

-(void)showLeftSlideViewController:(UIViewController<LeftControllerCallback> *)viewController animate:(bool)animated
{
    if(self.leftSlideController)
        return;
    
    [viewController view];
    
    previousViewController=self.visibleViewController;
    
    if(!self.leftSlideController)
    {
        SGLeftViewController *vc=[[SGLeftViewController alloc] init];
        vc.view.frame=CGRectMake(-SLIDE_POSITION_X, self.l_v_y, SLIDE_POSITION_X, self.l_v_h);
        
        vc.view.layer.masksToBounds=true;
        
        leftSlideController=vc;
        
        [self addChildViewController:vc];
        [self.view addSubview:vc.view];
    }
    
    leftSlideController.childController=viewController;
    [leftSlideController addChildViewController:viewController];
    [leftSlideController.view addSubview:viewController.view];
    
    [self.view makeAlphaViewBelowView:leftSlideController.view];
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        [leftSlideController l_c_addX:SLIDE_POSITION_X];
        [previousViewController l_c_addX:SLIDE_POSITION_X];
    }];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftTapGes:)];
    tap.delegate=self;
    
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(leftPanGes:)];
    pan.delegate=self;
    
    //    [pan requireGestureRecognizerToFail:tap];
    
    //    panSlide=pan;
    tapSlide=tap;
    
    [self.view addGestureRecognizer:tap];
    //    [self.view addGestureRecognizer:pan];
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if(gestureRecognizer==tapSlide)
    {
        if(self.leftSlideController)
        {
            CGPoint pnt=[tapSlide locationInView:self.view];
            return CGRectContainsPoint(CGRectMake(SLIDE_POSITION_X, 0, self.l_v_w-SLIDE_POSITION_X, self.l_v_h), pnt);
        }
        
        return true;
    }
    else if(gestureRecognizer==panSlide)
    {
        CGPoint pnt=[panSlide velocityInView:self.view];
        
        if(fabsf(pnt.x)>fabsf(pnt.y))
        {
            float velocity=pnt.x;
            
            if(self.leftSlideController)
            {
                if(velocity<0 && velocity<VELOCITY_SLIDE)
                {
                    [self moveToVisibleView];
                    return false;
                }
            }
            else if(self.rightSlideController)
            {
                if(velocity>0 && velocity>VELOCITY_SLIDE)
                {
                    [self moveToVisibleView];
                    return false;
                }
            }
            
            return true;
        }
        
        return false;
    }
    else if(gestureRecognizer==self.panPrevious)
    {
        if(self.leftSlideController || self.rightSlideController)
            return false;
        
        if(self.viewControllers.count<=1)
            return false;
        
        CGPoint pnt=[self.panPrevious velocityInView:self.view];
        
        float velocity=pnt.x;
        
        if(fabsf(pnt.x)>fabsf(pnt.y))
        {
            if(velocity>0 && velocity>VELOCITY_SLIDE)
            {
                [self moveToPreviousViewController];
                return false;
            }
            
            return true;
        }
        
        return false;
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
            panSlideStartPoint=[pan locationInView:pan.view];
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            float velocity=[pan velocityInView:pan.view].x;
            
            if(velocity<0 && velocity<-VELOCITY_SLIDE)
                return;
            
            CGPoint pnt=[pan locationInView:pan.view];
            float deltaX=pnt.x-panSlideStartPoint.x;
            panSlideStartPoint=pnt;
            
            if(self.leftSlideController.l_v_x+deltaX>0)
            {
                [self.leftSlideController l_v_setX:0];
                [self.previousViewController l_v_setX:SLIDE_POSITION_X];
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
            if(self.viewControllers.count<=1)
                return;
            
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
        [self.leftSlideController l_v_setX:0];
        [self.previousViewController l_v_setX:SLIDE_POSITION_X];
    } completion:^(BOOL finished) {
    }];
}
-(void) moveToRightSlide
{
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        [self.rightSlideController l_c_setX:self.l_v_w/2];
        [self.previousViewController l_c_setX:-self.l_v_w/2];
    }];
}

-(void) moveToVisibleView
{
    if([self.leftSlideController.childController respondsToSelector:@selector(hideLeftSlideController:withPreviousController:callbackCompleted:)])
    {
        [[self leftSlideController].childController hideLeftSlideController:self.leftSlideController withPreviousController:previousViewController callbackCompleted:^{
            if(self.leftSlideController)
            {
                [panSlide removeTarget:self action:@selector(leftPanGes:)];
                [tapSlide removeTarget:self action:@selector(leftTapGes:)];
                
                [self.leftSlideController removeFromParentViewController];
                [self.leftSlideController.view removeFromSuperview];
            }
            
            if(self.rightSlideController)
            {
                [panSlide removeTarget:self action:@selector(rightPanGes:)];
                [tapSlide removeTarget:self action:@selector(rightTapGes:)];
                
                [self.rightSlideController removeFromParentViewController];
                [self.rightSlideController.view removeFromSuperview];
            }
            
            [self.view removeAlphaView];
            
            panSlideStartPoint=CGPointZero;
            
            [self.view removeGestureRecognizer:panSlide];
            panSlide=nil;
            
            [self.view removeGestureRecognizer:tapSlide];
            tapSlide=nil;
            
            leftSlideController=nil;
            rightSlideController=nil;
        }];
        
        return;
    }
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        [self.leftSlideController l_c_setX:-self.l_v_w/2];
        [self.rightSlideController l_c_setX:self.l_v_w*1.5f];
        [self.previousViewController l_c_setX:self.l_v_w/2];
    } completion:^(BOOL finished) {
        
        if(self.leftSlideController)
        {
            [panSlide removeTarget:self action:@selector(leftPanGes:)];
            [tapSlide removeTarget:self action:@selector(leftTapGes:)];
            
            [self.leftSlideController removeFromParentViewController];
            [self.leftSlideController.view removeFromSuperview];
        }
        
        if(self.rightSlideController)
        {
            [panSlide removeTarget:self action:@selector(rightPanGes:)];
            [tapSlide removeTarget:self action:@selector(rightTapGes:)];
            
            [self.rightSlideController removeFromParentViewController];
            [self.rightSlideController.view removeFromSuperview];
        }
        
        [self.view removeAlphaView];
        
        panSlideStartPoint=CGPointZero;
        
        [self.view removeGestureRecognizer:panSlide];
        panSlide=nil;
        
        [self.view removeGestureRecognizer:tapSlide];
        tapSlide=nil;
        
        leftSlideController=nil;
        rightSlideController=nil;
    }];
}

-(void)removeRightSlideViewController:(UIViewController *)viewController
{
    if(self.rightSlideController)
    {
        [UIView animateWithDuration:DURATION_DEFAULT animations:^{
            [self.previousViewController l_c_setX:self.l_v_w/2];
            [self.rightSlideController l_c_setX:self.l_v_w*1.5f];
        } completion:^(BOOL finished) {
            [self.rightSlideController removeFromParentViewController];
            [self.rightSlideController.view removeFromSuperview];
            
            [self.view removeAlphaView];
            
            panSlideStartPoint=CGPointZero;
            
            [panSlide removeTarget:self action:@selector(rightPanGes:)];
            [self.view removeGestureRecognizer:panSlide];
            panSlide=nil;
            
            [tapSlide removeTarget:self action:@selector(rightTapGes:)];
            [self.view removeGestureRecognizer:tapSlide];
            tapSlide=nil;
            
            rightSlideController=nil;
        }];
    }
}

-(void)removeLeftSlideViewController
{
    if(self.leftSlideController)
    {
        [UIView animateWithDuration:DURATION_SHOW_SETTING+0.01f animations:^{
            [self.previousViewController l_c_setX:self.l_v_w/2];
        }];
        
        [UIView animateWithDuration:DURATION_SHOW_SETTING-0.01f animations:^{
            [self.leftSlideController l_c_setX:-self.l_v_w/2];
        } completion:^(BOOL finished) {
            [self.leftSlideController removeFromParentViewController];
            [self.leftSlideController.view removeFromSuperview];
            
            [self.view removeAlphaView];
            
            panSlideStartPoint=CGPointZero;
            [panSlide removeTarget:self action:@selector(leftPanGes:)];
            [self.view removeGestureRecognizer:panSlide];
            panSlide=nil;
            
            [tapSlide removeTarget:self action:@selector(leftTapGes:)];
            [self.view removeGestureRecognizer:tapSlide];
            tapSlide=nil;
            
            leftSlideController=nil;
        }];
    }
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.wantsFullScreenLayout=true;
    
    if(animated)
    {
        [self.view.layer addAnimation:transitionPushFromRight() forKey:nil];
        [super pushViewController:viewController animated:false];
        return;
    }
    
    [super pushViewController:viewController animated:animated];
}

-(void)setIsAllowDragBackPreviouseView:(bool)_isAllowDragBackPreviouseView
{
    isAllowDragBackPreviouseView=_isAllowDragBackPreviouseView;
    
    if(self.panPrevious)
    {
        [self.panPrevious removeTarget:self action:@selector(panPrevious:)];
        [self.view removeGestureRecognizer:self.panPrevious];
        self.panPrevious=nil;
        self.panPreviousStartPoint=CGPointZero;
    }
    
    if(isAllowDragBackPreviouseView)
    {
        UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPrevious:)];
        pan.delegate=self;
        
        self.panPrevious=pan;
        
        [self.view addGestureRecognizer:pan];
    }
}

-(void) panPrevious:(UIPanGestureRecognizer*) ges
{
    switch (ges.state) {
        case UIGestureRecognizerStateBegan:
            self.panPreviousStartPoint=[ges locationInView:self.view];
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGPoint pnt=[ges locationInView:self.view];
            float deltaX=pnt.x-self.panPreviousStartPoint.x;
            self.panPreviousStartPoint=pnt;
            
            if(self.viewControllers.count<=1)
                return;
            
            UIViewController *vc1=self.visibleViewController;
            UIViewController *vc2=self.viewControllers[[self.viewControllers indexOfObject:vc1]-1];
            
            if(vc1.view!=self.view)
            {
                [vc1.view removeFromSuperview];
                [self.view addSubview:vc1.view];
            }
            
            if(!vc2.view.superview)
            {
                [vc2 l_c_setX:-self.l_v_w/2];
                [self.view addSubview:vc2.view];
            }
            
            if(vc1.l_v_x+deltaX<0)
            {
                [vc1 l_v_setX:0];
                [vc2 l_c_setX:-self.l_v_w/2];
            }
            else
            {
                [vc1 l_c_addX:deltaX];
                [vc2 l_c_addX:deltaX];
            }
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        {
            float velocity=[ges velocityInView:ges.view].x;
            UIViewController *vc1=self.visibleViewController;
            
            if(velocity>0 && velocity>VELOCITY_SLIDE)
                [self moveToPreviousViewController];
            else
            {
                if(vc1.view.center.x>vc1.view.frame.size.width/2 + vc1.view.frame.size.width/4)
                    [self moveToPreviousViewController];
                else
                    [self previousMoveToVisibleViewController];
            }
            
        }
            break;
            
        default:
            break;
    }
}

-(void) previousMoveToVisibleViewController
{
    UIViewController *vc1=self.visibleViewController;
    UIViewController *vc2=self.viewControllers[[self.viewControllers indexOfObject:vc1]-1];
    
    if(!vc2.view.superview)
    {
        [vc2 l_c_setX:-self.l_v_w/2];
        [self.view addSubview:vc2.view];
    }
    
    [vc1.view removeFromSuperview];
    [self.view addSubview:vc1.view];
    
    [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
        [vc1 l_c_setX:self.l_v_w/2];
        [vc2 l_c_setX:-self.l_v_w/2];
    } completion:^(BOOL finished) {
        [vc2.view removeFromSuperview];
    }];
}

-(void) moveToPreviousViewController
{
    UIViewController *vc1=self.visibleViewController;
    UIViewController *vc2=self.viewControllers[[self.viewControllers indexOfObject:vc1]-1];
    
    if(!vc2.view.superview)
    {
        [vc2 l_c_setX:-self.l_v_w/2];
        [self.view addSubview:vc2.view];
    }
    
    [vc1.view removeFromSuperview];
    [self.view addSubview:vc1.view];
    
    [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
        [vc1 l_c_setX:self.l_v_w*1.5f];
        [vc2 l_c_setX:self.l_v_w/2];
    } completion:^(BOOL finished) {
        [vc1.view removeFromSuperview];
        [self popViewControllerAnimated:false];
    }];
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

-(UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    for(SGViewController *vc in self.viewControllers)
    {
        [vc navigationController:self willPopController:(SGViewController*)self.visibleViewController];
    }
    
    if(animated)
    {
        [self.view.layer addAnimation:transitionPushFromLeft() forKey:nil];
        return [super popViewControllerAnimated:false];
    }
    
    return [super popViewControllerAnimated:animated];
}

-(UIViewController *)popViewControllerWithTransition:(CATransition *)transition
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

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(lblTitle)
        lblTitle.text=viewController.title;
}

-(void)setLblTitle:(UILabel *)_lblTitle
{
    lblTitle=_lblTitle;
    
    if(lblTitle)
        lblTitle.text=self.visibleViewController.title;
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

@end

@implementation SGLeftViewController
@synthesize  childController;

@end

@implementation SGRightViewController
@end