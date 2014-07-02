//
//  SGViewController+PresentViewController.m
//  Infory
//
//  Created by XXX on 7/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController+PresentViewController.h"
#import <objc/runtime.h>

static char presentSGViewControlelrKey;
static char presentingSGViewControlelrKey;

@implementation UIViewController(PresentViewController)

-(SGViewController *)presentSGViewControlelr
{
    return objc_getAssociatedObject(self, &presentSGViewControlelrKey);
}

-(void)setPresentSGViewControlelr:(SGViewController *)presentSGViewControlelr
{
    objc_setAssociatedObject(self, &presentSGViewControlelrKey, presentSGViewControlelr, OBJC_ASSOCIATION_ASSIGN);
}

-(UIViewController *)presentingSGViewController
{
    return objc_getAssociatedObject(self, &presentingSGViewControlelrKey);
}

-(void)setPresentingSGViewController:(UIViewController *)presentingSGViewController_
{
    objc_setAssociatedObject(self, &presentingSGViewControlelrKey, presentingSGViewController_, OBJC_ASSOCIATION_ASSIGN);
}

-(void)presentSGViewController:(UIViewController *)viewControllerToPresent animate:(bool)animated completion:(void (^)(void))completion
{
    if(animated)
    {
        [self presentSGViewController:viewControllerToPresent animation:^BasicAnimation *{
            BasicAnimation *animation=[BasicAnimation animationWithKeyPath:@"position"];
            
            CGPoint pnt=viewControllerToPresent.view.layer.position;
            animation.fromValue=[NSValue valueWithCGPoint:CGPointMake(viewControllerToPresent.view.layer.position.x, viewControllerToPresent.view.layer.position.y-viewControllerToPresent.view.l_v_h)];
            animation.toValue=[NSValue valueWithCGPoint:pnt];
            animation.fillMode=kCAFillModeForwards;
            animation.removedOnCompletion=true;
            animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            return animation;
        } completion:completion];
    }
    else
        [self presentSGViewController:viewControllerToPresent animation:nil completion:completion];
}

-(void)presentSGViewController:(SGViewController *)viewControllerToPresent completion:(void (^)(void))completion
{
    [self presentSGViewController:viewControllerToPresent animate:true completion:completion];
}

-(float)alphaForPresentView
{
    return 0.7f;
}

-(void)presentSGViewController:(UIViewController *)viewControllerToPresent animation:(BasicAnimation* (^)())animation completion:(void (^)())completion
{
    self.presentSGViewControlelr=viewControllerToPresent;
    viewControllerToPresent.presentingSGViewController=self;
    
    [self addChildViewController:viewControllerToPresent];
    
    [viewControllerToPresent view];
    [viewControllerToPresent l_v_setS:self.l_v_s];
    
    if(animation)
    {
        self.view.userInteractionEnabled=false;
        [self.view alphaViewWithColor:[UIColor blackColor]];
        self.view.alphaView.alpha=0;
        [self.view addSubview:viewControllerToPresent.view];
        [viewControllerToPresent viewWillAppear:true];
        
        BasicAnimation *animate=animation();
        animate.duration=DURATION_PRESENT_VIEW_CONTROLLER;
        
        [animate addToLayer:viewControllerToPresent.view.layer onStart:^(BasicAnimation * bsAnimation) {
            
            [UIView animateWithDuration:DURATION_PRESENT_VIEW_CONTROLLER animations:^{
                self.view.alphaView.alpha=self.alphaForPresentView;
            }];
        } onStop:^(BasicAnimation *bsAnimation, bool isFinished) {
            [viewControllerToPresent viewDidAppear:true];
            self.view.userInteractionEnabled=true;
            if(completion)
                completion();
        }];
    }
    else
    {
        [self.view alphaViewWithColor:[UIColor blackColor]];
        self.view.alphaView.alpha=1;
        
        [viewControllerToPresent viewWillAppear:false];
        [self.view addSubview:viewControllerToPresent.view];
        [viewControllerToPresent viewDidAppear:false];
        
        if(completion)
            completion();
    }
}

-(void)dismissSGViewControllerAnimation:(BasicAnimation *(^)())animation completion:(void (^)())completion
{
    if(!self.presentSGViewControlelr)
        return;
    
    __block void(^_completion)()=nil;
    
    if(completion)
        _completion=[completion copy];
    
    [self.presentSGViewControlelr viewWillDisappear:true];
    
    if(animation)
    {
        self.view.userInteractionEnabled=false;
        BasicAnimation *animate=animation();
        
        [animate addToLayer:self.presentSGViewControlelr.view.layer onStart:^(BasicAnimation *bsAnimation) {
            [UIView animateWithDuration:DURATION_PRESENT_VIEW_CONTROLLER animations:^{
                self.view.alphaView.alpha=0;
            }];
            
            [self.presentSGViewControlelr.view.layer setValue:bsAnimation.toValue forKeyPath:bsAnimation.keyPath];
            
        } onStop:^(BasicAnimation *bsAnimation, bool isFinished) {
            
            [self.view removeAlphaView];
            
            self.presentSGViewControlelr.presentingSGViewController=nil;
            [self.presentSGViewControlelr viewDidDisappear:true];
            [self.presentSGViewControlelr.view removeFromSuperview];
            [self.presentSGViewControlelr removeFromParentViewController];
            self.presentSGViewControlelr=nil;
            self.view.userInteractionEnabled=true;
            
            if(_completion)
            {
                _completion();
                _completion=nil;
            }
            
            [self presentSGViewControllerFinished];
        }];
    }
    else
    {
        [self.view removeAlphaView];
        self.presentSGViewControlelr.presentingSGViewController=nil;
        [self.presentSGViewControlelr viewDidDisappear:true];
        [self.presentSGViewControlelr.view removeFromSuperview];
        [self.presentSGViewControlelr removeFromParentViewController];
        self.presentSGViewControlelr=nil;
        
        if(_completion)
        {
            _completion();
            _completion=nil;
        }
        
        [self presentSGViewControllerFinished];
    }
    
}

-(void)dismissSGViewControllerAnimated:(bool)animate completion:(void (^)(void))completion
{
    if(animate)
    {
        [self dismissSGViewControllerAnimation:^BasicAnimation *{
            BasicAnimation *animation=[BasicAnimation animationWithKeyPath:@"position"];
            animation.fromValue=[NSValue valueWithCGPoint:self.presentSGViewControlelr.view.layer.position];
            animation.toValue=[NSValue valueWithCGPoint:CGPointMake(self.presentSGViewControlelr.view.layer.position.x, self.presentSGViewControlelr.view.layer.position.y-self.presentSGViewControlelr.view.l_v_h)];
            animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            animation.fillMode=kCAFillModeForwards;
            animation.removedOnCompletion=true;
            
            return animation;
        } completion:completion];
    }
}

-(void)dismissSGViewControllerCompletion:(void (^)(void))completion
{
    [self dismissSGViewControllerAnimated:true completion:completion];
}

-(void)presentSGViewControllerFinished
{
    
}

@end