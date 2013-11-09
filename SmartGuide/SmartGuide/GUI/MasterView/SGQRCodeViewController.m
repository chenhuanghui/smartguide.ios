//
//  SGQRCodeViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGQRCodeViewController.h"

@interface SGQRCodeViewController ()

@end

@implementation SGQRCodeViewController
@synthesize delegate;

- (id)init
{
    self = [super initWithNibName:@"SGQRCodeViewController" bundle:nil];
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

- (IBAction)btn:(id)sender {
    [self.delegate SGQRCodeRequestShow];
}

@end
