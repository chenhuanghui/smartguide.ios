//
//  SGViewController+PresentViewController.h
//  Infory
//
//  Created by XXX on 7/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"

@interface UIViewController(PresentViewController)

@property (nonatomic, readwrite, weak) UIViewController *presentSGViewControlelr;
@property (nonatomic, readwrite, weak) UIViewController *presentingSGViewController;

-(void)presentSGViewController:(UIViewController *)viewControllerToPresent completion:(void (^)(void))completion;
-(void)presentSGViewController:(UIViewController *)viewControllerToPresent animate:(bool) animated completion:(void (^)(void))completion;
-(void)presentSGViewController:(UIViewController *)viewControllerToPresent animation:(BasicAnimation*(^)()) animation completion:(void(^)()) completion;

-(void)dismissSGViewControllerCompletion:(void (^)(void))completion;
-(void)dismissSGViewControllerAnimated:(bool) animate completion:(void (^)(void))completion;
-(void)dismissSGViewControllerAnimation:(BasicAnimation*(^)()) animation completion:(void(^)()) completion;
-(void) presentSGViewControllerFinished;
-(float) alphaForPresentView;

@end