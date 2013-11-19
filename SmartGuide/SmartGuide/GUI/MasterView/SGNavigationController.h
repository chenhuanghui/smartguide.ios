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

@class SGLeftViewController, SGRightViewController;

@interface SGNavigationController : UINavigationController<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
{
    void(^_onPushedViewController)(UIViewController* vc);
    CATransition*(^_animationPopViewController)(UIViewController* vc);
    
    NSMutableArray *_controllers;
    
    CGPoint _panStartPoint;
    UITapGestureRecognizer *_tapSlideGes;
    UIPanGestureRecognizer *_panSlideGes;
}

-(SGNavigationController*) initWithViewControllers:(NSArray*) controllers;

-(void) setRootViewController:(UIViewController*) viewController animate:(bool) animate;
-(void) showLeftSlideViewController:(UIViewController*) viewController animate:(bool) animated;
-(void) removeLeftSlideViewController;
-(void) setAnimationPopViewController:(CATransition*(^)(UIViewController* vc)) animationPush;

@property (nonatomic, strong, readonly) SGLeftViewController *leftSlideController;
@property (nonatomic, strong, readonly) SGRightViewController *rightSlideController;
@property (nonatomic, weak, readonly) UIViewController *previousViewController;
@property (nonatomic, assign) bool isAllowDragBackPreviouseView;

@end

@interface SGLeftViewController : SGViewController

@end

@interface SGRightViewController : SGViewController

@end