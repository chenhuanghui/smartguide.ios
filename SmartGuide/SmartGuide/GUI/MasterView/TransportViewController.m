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

-(TransportViewController *)initWithNavigation:(UINavigationController *)_navi
{
    self=[super init];
    
    navi=_navi;
    
    [self addChildViewController:navi];
    [self.view addSubview:navi.view];
    
    return self;
}

-(NSString *)title
{
    return self.navi.visibleViewController.title;
}

-(void)dealloc
{
    navi=nil;
    NSLog(@"dealloc %@",CLASS_NAME);
}

@end
