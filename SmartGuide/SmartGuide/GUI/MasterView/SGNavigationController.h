//
//  SGNavigationViewController.h
//  SmartGuide
//
//  Created by MacMini on 28/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PanDragViewHandle.h"
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

@class SGLeftViewController, SGRightViewController;

@protocol LeftControllerCallback <NSObject>

@optional
-(void) hideLeftSlideController:(SGLeftViewController*) leftSlideController withPreviousController:(UIViewController*) previousController callbackCompleted:(void(^)()) callbackCompleted;

@end

@interface SGNavigationController : UINavigationController<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
{
    void(^_onPushedViewController)(UIViewController* vc);

    NSMutableArray *_controllers;
}

-(SGNavigationController*) initWithViewControllers:(NSArray*) controllers;

-(void) makePushViewController:(UIViewController*)viewController animate:(bool) animate;
-(void) pushViewController:(UIViewController *)viewController withTransition:(CATransition*) transition;
-(void) pushViewController:(SGViewController*) viewController andPopWithTransition:(CATransition*) transition;
-(UIViewController *)popViewControllerWithTransition:(CATransition*) transition;


-(void) setRootViewController:(UIViewController*) viewController animate:(bool) animate;
-(void) makeRootViewController:(UIViewController*) viewController;
-(void) removeViewController:(UIViewController*) viewController;

-(void) showLeftSlideViewController:(UIViewController<LeftControllerCallback>*) viewController animate:(bool) animated;
-(void) removeLeftSlideViewController;
-(void) showRightSlideViewController:(UIViewController*) viewController animate:(bool) animated;
-(void) removeRightSlideViewController:(UIViewController*) viewController;

@property (nonatomic, weak, readonly) SGLeftViewController *leftSlideController;
@property (nonatomic, weak, readonly) SGRightViewController *rightSlideController;
@property (nonatomic, weak, readonly) UIViewController *previousViewController;
@property (nonatomic, assign) bool isAllowDragBackPreviouseView;
@property (nonatomic, weak) UIPanGestureRecognizer *panPrevious;
@property (nonatomic, weak) UILabel *lblTitle;

@end

@interface SGLeftViewController : SGViewController

@property (nonatomic, weak) UIViewController<LeftControllerCallback> *childController;

@end

@interface SGRightViewController : SGViewController

@end