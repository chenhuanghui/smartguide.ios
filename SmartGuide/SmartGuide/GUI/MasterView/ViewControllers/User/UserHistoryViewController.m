//
//  UserHistoryViewController.m
//  SmartGuide
//
//  Created by MacMini on 07/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "UserHistoryViewController.h"

@interface UserHistoryViewController ()

@end

@implementation UserHistoryViewController

- (id)init
{
    self = [super initWithNibName:@"UserHistoryViewController" bundle:nil];
    if (self) {
        // Custom initialization
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
    return @"History";
}

@end