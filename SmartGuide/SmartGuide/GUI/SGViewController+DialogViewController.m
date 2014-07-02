//
//  SGViewController+DialogViewController.m
//  Infory
//
//  Created by XXX on 7/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController+DialogViewController.h"
#import <objc/runtime.h>

static char DialogControllerCharKey;

@implementation UIViewController(DialogViewController)

-(SGViewController *)dialogController
{
    return objc_getAssociatedObject(self, &DialogControllerCharKey);
}

-(void)setDialogController:(SGViewController *)dialogController
{
    objc_setAssociatedObject(self, &DialogControllerCharKey, dialogController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)showDialogController:(SGViewController *)dialogController withAnimation:(BasicAnimation *)animation onCompleted:(void (^)(SGViewController *))completed
{
    self.dialogController=dialogController;
    
    [dialogController view];
    [dialogController l_v_setS:self.view.l_v_s];
    
    if(animation)
    {
        self.view.userInteractionEnabled=false;
        [self.view addSubview:dialogController.view];
        [dialogController viewWillAppear:true];
        
        [animation addToLayer:dialogController.view.layer onStart:^(BasicAnimation* bsAnimation)
         {
             [dialogController.view.layer setValue:bsAnimation.toValue forKeyPath:bsAnimation.keyPath];
         } onStop:^(BasicAnimation *bsAnimation, bool isFinished) {
            [dialogController viewDidAppear:true];
            self.view.userInteractionEnabled=true;
            
            if(completed)
                completed(dialogController);
        }];
    }
    else
    {
        [dialogController viewWillAppear:false];
        [self.view addSubview:dialogController.view];
        [dialogController viewDidAppear:false];
        
        if(completed)
            completed(dialogController);
    }
}

-(void)closeDialogControllerWithAnimation:(BasicAnimation *)animation onCompleted:(void (^)(SGViewController *))completed
{
    if(self.dialogController==nil)
        return;
    
    if(animation)
    {
        self.view.userInteractionEnabled=false;
        self.dialogController.view.userInteractionEnabled=false;
        [self.dialogController viewWillDisappear:true];
        
        [animation addToLayer:self.dialogController.view.layer onStart:^(BasicAnimation* bsAnimation)
         {
             [self.dialogController.view.layer setValue:bsAnimation.toValue forKeyPath:bsAnimation.keyPath];
         } onStop:^(BasicAnimation *bsAnimation, bool isFinished) {
            self.view.userInteractionEnabled=true;
            [self.dialogController viewDidDisappear:true];
            [self.dialogController.view removeFromSuperview];
            self.dialogController=nil;
        }];
    }
    else
    {
        [self.dialogController viewWillDisappear:false];
        [self.dialogController.view removeFromSuperview];
        [self.dialogController viewDidDisappear:false];
        self.dialogController=nil;
    }
}

-(BasicAnimation*)dialogControllerDefaultAnimationShow
{
    BasicAnimation *animation=[BasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue=@(0);
    animation.toValue=@(1);
    animation.fillMode=kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.removedOnCompletion=true;
    
    return animation;
}

-(BasicAnimation*)dialogControllerDefaultAnimationClose
{
    BasicAnimation *animation=[BasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue=@(1);
    animation.toValue=@(0);
    animation.fillMode=kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.removedOnCompletion=true;
    
    return animation;
}

@end
