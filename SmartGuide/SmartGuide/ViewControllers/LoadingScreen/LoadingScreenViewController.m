//
//  LoadingScreenViewController.m
//  SmartGuide
//
//  Created by XXX on 8/23/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "LoadingScreenViewController.h"
#import "NSBKeyframeAnimation.h"
#import <QuartzCore/QuartzCore.h>
#import "RootViewController.h"

@interface LoadingScreenViewController ()

@end

@implementation LoadingScreenViewController
@synthesize isAnimationFinished,isNeedRemove;

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
    // Do any additional setup after loading the view from its nib.
    
    isAnimationFinished=false;
    
    double delayInSeconds = 2.5f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        isAnimationFinished=true;
        
        if(self.isNeedRemove)
        {
            [[RootViewController shareInstance] removeLoadingScreen];
        }
    });
    
    return;
    CGRect rect=logo.frame;
    rect.origin.y=self.view.frame.size.height+rect.size.height;
    logo.frame=rect;
    
    rect=smartguide.frame;
    rect.origin.y=self.view.frame.size.height+rect.size.height;
    smartguide.frame=rect;
    
    rect=km.frame;
    rect.origin.y=self.view.frame.size.height+rect.size.height;
    km.frame=rect;
    
    [UIView animateWithDuration:1 animations:^{
        logo.frame=CGRectMake(106, 142, 114, 100);
    } completion:nil];
    
    [UIView animateWithDuration:1 delay:0.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        smartguide.frame=CGRectMake(115, 255, 95, 24);
    } completion:nil];
    
    [UIView animateWithDuration:1 delay:1.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        km.frame=CGRectMake(53, 285, 221, 21);
    } completion:^(BOOL finished) {
        isAnimationFinished=true;
        
        if(self.isNeedRemove)
        {
            [[RootViewController shareInstance] removeLoadingScreen];
        }
    }];
    
    return;
    float height=self.view.frame.size.height;
    
    NSBKeyframeAnimation *animation=[NSBKeyframeAnimation animationWithKeyPath:@"position.y" duration:1 startValue:height endValue:(142) function:NSBKeyframeAnimationFunctionEaseInOutQuad];
    
    [logo.layer setValue:@(height-142-100) forKeyPath:@"position.y"];
    [logo.layer addAnimation:animation forKey:@"position.y"];
    
    animation=[NSBKeyframeAnimation animationWithKeyPath:@"position.y" duration:1 startValue:0 endValue:-(height-255) function:NSBKeyframeAnimationFunctionEaseInOutQuad];
    
    [smartguide.layer setValue:@(height-255-24) forKeyPath:@"position.y"];
    [smartguide.layer addAnimation:animation forKey:@"position.y"];
    
    animation=[NSBKeyframeAnimation animationWithKeyPath:@"position.y" duration:1 startValue:height endValue:height-285-21 function:NSBKeyframeAnimationFunctionEaseInOutQuad];
    
    [km.layer setValue:@(height-285-21) forKeyPath:@"position.y"];
    [km.layer addAnimation:animation forKey:@"position.y"];
}

- (void)viewDidUnload {
    logo = nil;
    smartguide = nil;
    km = nil;
    [super viewDidUnload];
}
@end
