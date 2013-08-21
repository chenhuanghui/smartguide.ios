//
//  NavigationViewController.m
//  SmartGuide
//
//  Created by XXX on 7/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "NavigationViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController
@synthesize delegate;
@synthesize naviType;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)presentModalViewController:(UIViewController *)modalViewController animated:(BOOL)animated
{
    [super presentModalViewController:modalViewController animated:animated];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(navigationController:presentModalViewController:)])
        [self.delegate navigationController:self presentModalViewController:modalViewController];
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    naviType=NAVY_POP;
    UIViewController *vc = self.visibleViewController;
    
    if([vc isKindOfClass:[ViewController class]])
        [((ViewController*)vc) willPopViewController];
    
    return [super popViewControllerAnimated:animated];;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    naviType=NAVY_PUSH;
    [super pushViewController:viewController animated:animated];
}

@end