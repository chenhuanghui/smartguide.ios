//
//  MasterViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ContentViewController.h"
#import "DataManager.h"
#import "Flags.h"
#import "TokenManager.h"
#import "TransportViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

- (id)init
{
    self=[super init];
    
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