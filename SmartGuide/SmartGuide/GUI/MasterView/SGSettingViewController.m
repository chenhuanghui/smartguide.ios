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

- (IBAction)btnUserTouchUpInside:(id)sender {
    [self.delegate settingTouchedUser:self];
}

- (IBAction)btnCatalogTouchUpInside:(id)sender {
    [self.delegate settingTouchedCatalog:self];
}

-(IBAction)btnSetting:(id)sender {
    [self.delegate settingTouchedUserSetting:self];
}

- (IBAction)collection:(id)sender {
    [self.delegate settingTouchedUser:self];
}

- (IBAction)setting:(id)sender {
    [self.delegate settingTouchedUserSetting:self];
}

- (IBAction)block:(id)sender {
    [self.delegate settingTouchedCatalog:self];
}

- (IBAction)notification:(id)sender {
    [self.delegate settingTouchedNotification:self];
}

- (IBAction)otherView:(id)sender {
    [self.delegate settingTouchedOtherView:self];
}

@end
