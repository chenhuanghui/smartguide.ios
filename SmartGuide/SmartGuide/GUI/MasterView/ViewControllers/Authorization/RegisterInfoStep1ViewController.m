//
//  RegisterInfoStep1ViewController.m
//  SmartGuide
//
//  Created by MacMini on 07/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "RegisterInfoStep1ViewController.h"

@interface RegisterInfoStep1ViewController ()

@end

@implementation RegisterInfoStep1ViewController
@synthesize delegate;

- (id)init
{
    self = [super initWithNibName:@"RegisterInfoStep1ViewController" bundle:nil];
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

- (IBAction)btnAvatarTouchUpInside:(id)sender {
    [self.delegate registerInfoStep1ControllerTouchedAvatar:self];
}

- (IBAction)btnNameTouchUpInside:(id)sender {
    [txt becomeFirstResponder];
}

-(void)focusName
{
    [txt becomeFirstResponder];
}

-(NSString *)avatar
{
    return _avatar;
}

-(UIImage *)avatarImage
{
    return _avatarImage;
}

@end
