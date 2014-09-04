//
//  ViewController.h
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingView.h"
#import "BasicAnimation.h"

@protocol ViewControllerDelegate <NSObject>

@end

@interface ViewController : UIViewController<ViewControllerDelegate>
{
    bool _viewWillAppear;
}

-(void) viewWillAppearOnce;

@property (nonatomic, weak) id<ViewControllerDelegate> delegate;

@end

@interface ViewController(PresentViewController)

@property (nonatomic, weak, readwrite) UIViewController *presentViewController;

-(void)presentViewController:(UIViewController *)viewControllerToPresent animation:(BasicAnimation*) animation completion:(void (^)(void))completion;
-(void)dismissViewControllerAnimation:(BasicAnimation*) animation completion:(void (^)(void))completion;

@end