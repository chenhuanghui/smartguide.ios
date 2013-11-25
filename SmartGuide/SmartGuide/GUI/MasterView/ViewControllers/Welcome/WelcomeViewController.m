//
//  WelcomeViewController.m
//  SmartGuide
//
//  Created by MacMini on 07/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "WelcomeViewController.h"
#import "Flags.h"
#import "TokenManager.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController
@synthesize delegate;

- (id)init
{
    self = [super initWithNibName:@"WelcomeViewController" bundle:nil];
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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnTryTouchUpInside:(id)sender {
    [Flags setIsShowedWelcomeScreen:true];
    
    [[DataManager shareInstance] makeTryUser];
    
    [self.delegate welcomeControllerTouchedTry:self];
}

- (IBAction)btnLoginTouchUpInside:(id)sender {
    [Flags setIsShowedWelcomeScreen:true];
    
    [self.delegate welcomeControllerTouchedLogin:self];
}
@end
