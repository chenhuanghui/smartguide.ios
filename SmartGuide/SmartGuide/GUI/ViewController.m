//
//  ViewController.m
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)])
        self.automaticallyAdjustsScrollViewInsets=false;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(!_viewWillAppear)
    {
        _viewWillAppear=true;
        
        [self viewWillAppearOnce];
    }
}

-(void)viewWillAppearOnce
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end

#import <objc/runtime.h>

static char PresentViewControllerKey;
@implementation ViewController(PresentViewController)

-(UIViewController *)presentViewController
{
    return objc_getAssociatedObject(self, &PresentViewControllerKey);
}

-(void)setPresentViewController:(UIViewController *)presentViewController
{
    objc_setAssociatedObject(self, &PresentViewControllerKey, presentViewController, OBJC_ASSOCIATION_ASSIGN);
}

-(void)presentViewController:(UIViewController *)viewControllerToPresent animation:(BasicAnimation *)animation completion:(void (^)(void))completion
{
    [self addChildViewController:viewControllerToPresent];
    [self.view addSubview:viewControllerToPresent.view];
    
    [animation addToLayer:viewControllerToPresent.view.layer onStart:nil onStop:^(BasicAnimation *bsAnimation, bool isFinished) {
        if(completion)
            completion();
    }];
    
    self.presentViewController=viewControllerToPresent;
}

-(void)dismissViewControllerAnimation:(BasicAnimation *)animation completion:(void (^)(void))completion
{
    if(self.presentViewController)
    {
        [animation addToLayer:self.presentViewController.view.layer onStart:nil onStop:^(BasicAnimation *bsAnimation, bool isFinished) {
            if(completion)
                completion();
            
            [self.presentViewController.view removeFromSuperview];
            [self.presentViewController removeFromParentViewController];
            
            self.presentViewController=nil;
        }];
    }
}

@end