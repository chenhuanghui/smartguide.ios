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
    [navi removeFromParentViewController];
    [navi.view removeFromSuperview];
    navi=nil;
    NSLog(@"dealloc %@",CLASS_NAME);
}

-(void)loadView
{
    [super loadView];
    
    self.view.autoresizesSubviews=false;
}

-(BOOL)isKindOfClass:(Class)aClass
{
    bool isTrue=[super isKindOfClass:aClass];
    
    if(!isTrue && aClass!=[UINavigationController class])
        isTrue=[self.navi isKindOfClass:aClass];
    
    return isTrue;
}

@end
