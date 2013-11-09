//
//  SGSettingViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGSettingViewController.h"

@interface SGSettingViewController ()

@end

@implementation SGSettingViewController
@synthesize delegate,slideView;

- (id)init
{
    self = [super initWithNibName:@"SGSettingViewController" bundle:nil];
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

-(void)dealloc
{
    NSLog(@"dealloc %@", CLASS_NAME);
}

- (IBAction)btnUserTouchUpInside:(id)sender {
    [self.delegate settingTouchedUser:self];
}

- (IBAction)btnCatalogTouchUpInside:(id)sender {
    [self.delegate settingTouchedCatalog:self];
}
@end
