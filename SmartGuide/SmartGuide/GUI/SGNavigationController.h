//
//  SGNavigationViewController.h
//  SmartGuide
//
//  Created by MacMini on 28/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "Utility.h"
#import "SGViewController.h"
#import "AlphaView.h"

CATransition* transitionPushFromBottomWithDuration(float duration);
CATransition* transitionPushFromTopWithDuration(float duration);
CATransition* transitionPushFromLeftWithDuration(float duration);
CATransition* transitionPushFromRightWithDuration(float duration);

CATransition* transitionPushFromBottom();
CATransition* transitionPushFromTop();
CATransition* transitionPushFromLeft();
CATransition* transitionPushFromRight();

@protocol SGNavigationControllerDelegate <UINavigationControllerDelegate>

@end

@interface SGNavigationController : UINavigationController<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
{
    void(^_onPushedViewController)(UIViewController* vc);
    void(^_onPoppedViewController)(UIViewController* vc);

    NSMutableArray *_controllers;
    
    SGViewController *_prepareViewController;
    bool _didLoadPrepareViewController;
    bool _didCallPushPrepareViewController;
}

-(SGNavigationController*) initWithViewControllers:(NSArray*) controllers;

-(void) makePushViewController:(UIViewController*)viewController animate:(bool) animate;
-(void) pushViewController:(UIViewController *)viewController withTransition:(CATransition*) transition;
-(void) pushViewController:(SGViewController*) viewController andPopWithTransition:(CATransition*) transition;
-(void) pushViewController:(SGViewController*) viewController onCompleted:(void(^)()) completed;
-(UIViewController *)popSGViewControllerWithTransition:(CATransition*) transition;
-(UIViewController *)popViewControllerAnimated:(BOOL)animated onCompleted:(void(^)()) completed;

-(void) preparePushController:(SGViewController*) viewController;
-(void) pushViewControllerPrepared;

-(void) setRootViewController:(UIViewController*) viewController animate:(bool) animate;
-(void) setRootViewController:(UIViewController*) viewController animate:(bool) animate onCompleted:(void(^)()) onCompleted;
-(void) setRootViewControllers:(NSArray *)viewControllers animate:(bool)animate;
-(void) makeRootViewController:(UIViewController*) viewController;
-(void) removeViewController:(UIViewController*) viewController;

@property (nonatomic, weak) id<SGNavigationControllerDelegate> navigationDelegate;

@end