//
//  SGRootViewController.m
//  SmartGuide
//
//  Created by MacMini on 09/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGRootViewController.h"

@interface SGRootViewController ()

@end

@implementation SGRootViewController
@synthesize containFrame,contentFrame;

- (id)initWithDelegate:(id<SGViewControllerDelegate>)_delegate
{
    self = [super initWithNibName:@"SGRootViewController" bundle:nil];
    if (self) {
        self.delegate=_delegate;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    containFrame=self.containView.frame;
    contentFrame=self.contentView.frame;
    
    self.containView.layer.masksToBounds=true;
    self.contentView.layer.masksToBounds=true;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)moveToTopView:(SGViewController *)displayView
{
    self.topView.alpha=0;
    self.topView.hidden=false;
    
    [self.topView l_v_setO:displayView.l_v_o];
    
    [displayView l_v_setO:CGPointZero];
    [self.topView l_v_setS:displayView.l_v_s];
    
    [self addChildViewController:displayView];
    [self.topView addSubview:displayView.view];
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        self.topView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)removeTopView:(SGViewController *)displayView
{
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        self.topView.alpha=0;
    } completion:^(BOOL finished) {
        
        [displayView.view removeFromSuperview];
        [displayView removeFromParentViewController];
        
        self.topView.hidden=true;
    }];
}

@end