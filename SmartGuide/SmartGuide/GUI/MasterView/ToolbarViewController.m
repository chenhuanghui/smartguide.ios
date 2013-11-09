//
//  ToolbarViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ToolbarViewController.h"

@interface ToolbarViewController ()

@end

@implementation ToolbarViewController
@synthesize delegate;

- (id)init
{
    self = [super initWithNibName:@"ToolbarViewController"bundle:nil];
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

- (IBAction)btnSettingTouchUpInside:(id)sender {
    [self.delegate toolbarSetting];
}

- (IBAction)btnUserCollectionTouchUpInside:(id)sender {
    [self.delegate toolbarUserCollection];
}

- (IBAction)btnUserLoginTouchUpInside:(id)sender {
    [self.delegate toolbarUserLogin];
}

- (IBAction)btnMapTouchUpInside:(id)sender {
}

@end
