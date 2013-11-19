//
//  SGUserSettingViewController.m
//  SmartGuide
//
//  Created by MacMini on 19/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGUserSettingViewController.h"

@interface SGUserSettingViewController ()

@end

@implementation SGUserSettingViewController
@synthesize delegate;

- (id)init
{
    self = [super initWithNibName:@"SGUserSettingViewController" bundle:nil];
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

- (IBAction)close:(id)sender {
    [self.delegate userSettingControllerTouchedClose:self];
}

@end
