//
//  MasterViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ContentViewController.h"
#import "LoadingScreenViewController.h"
#import "DataManager.h"
#import "Flags.h"
#import "TokenManager.h"
#import "ShopViewController.h"
#import "TransportViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

- (id)init
{
    ShopViewController *vc=[[ShopViewController alloc] init];
    TransportViewController *transport=[[TransportViewController alloc] initWithNavigation:vc];
    self = [super initWithRootViewController:transport];
    [self setNavigationBarHidden:true];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)title
{
    return CLASS_NAME;
}

@end