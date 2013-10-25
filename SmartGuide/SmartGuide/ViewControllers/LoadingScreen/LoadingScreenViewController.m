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

- (id)init
{
    self = [super initWithNibName:NIB_PHONE(@"LoadingScreenViewController") bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    return;
    if(IS_IPHONE_4)
    {
        if(!IS_RETINA)
            imgvDefault.frame=CGRectMake(0, 0, 320, 460);
    }
    isAnimationFinished=false;
    
    double delayInSeconds = 0.5f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        isAnimationFinished=true;
        
        if(self.isNeedRemove)
        {
            [[RootViewController shareInstance] removeLoadingScreen];
        }
        else
            [self.view showLoadingWithTitle:nil];
    });
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
