//
//  TransportViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "TransportViewController.h"

@interface TransportViewController ()

@end

@implementation TransportViewController
@synthesize navi;

-(TransportViewController *)initWithNavigation:(SGNavigationController *)_navi
{
    self=[super init];
    
    navi=_navi;
    
    [self addChildViewController:navi];
    [self.view addSubview:navi.view];
    
    return self;
}

-(void)dealloc
{
    [navi removeFromParentViewController];
    [navi.view removeFromSuperview];
    navi=nil;
}

-(void)loadView
{
    [super loadView];
    
    self.view.autoresizesSubviews=false;
}

@end
