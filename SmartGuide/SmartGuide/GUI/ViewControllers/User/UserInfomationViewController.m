//
//  UserInfomationViewController.m
//  SmartGuide
//
//  Created by MacMini on 07/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "UserInfomationViewController.h"

@interface UserInfomationViewController ()

@end

@implementation UserInfomationViewController

- (id)init
{
    self = [super initWithNibName:@"UserInfomationViewController" bundle:nil];
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
    return @"Infomation";
}

@end
