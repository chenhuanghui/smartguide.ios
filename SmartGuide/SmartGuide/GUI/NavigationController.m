//
//  NavigationController.m
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController

-(void)loadView
{
    [super loadView];
    
    self.navigationBarHidden=true;
    
    if([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)])
        self.automaticallyAdjustsScrollViewInsets=false;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)setRootViewController:(UIViewController *)controller
{
    [self pushViewController:controller animated:true completion:^{
        self.viewControllers=@[controller];
    }];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end

@implementation NavigationController(PushBlock)

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)())onCompleted
{
    if(animated)
    {
        [CATransaction begin];
        [CATransaction setCompletionBlock:onCompleted];
    }
    
    [self pushViewController:viewController animated:animated];
    
    if(animated)
    {
        [CATransaction commit];
    }
    else
        onCompleted();
}

@end