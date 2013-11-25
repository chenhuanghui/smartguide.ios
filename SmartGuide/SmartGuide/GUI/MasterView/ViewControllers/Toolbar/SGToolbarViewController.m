//
//  ToolbarViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGToolbarViewController.h"

@interface SGToolbarViewController ()

@end

@implementation SGToolbarViewController
@synthesize delegate;

- (id)init
{
    self = [super initWithNibName:@"SGToolbarViewController"bundle:nil];
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

- (IBAction)btnMapTouchUpInside:(id)sender {
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate toolbarSetting];
}

@end
