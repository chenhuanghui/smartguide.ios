//
//  RegisterInfoStep2ViewController.m
//  SmartGuide
//
//  Created by MacMini on 07/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "RegisterInfoStep2ViewController.h"

@interface RegisterInfoStep2ViewController ()

@end

@implementation RegisterInfoStep2ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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

-(NSString *)dob
{
    return [NSString stringWithFormat:@"%@/%@/%@",txtDay.text,txtMonth.text,txtYear.text];
}

-(enum GENDER_TYPE)gender
{
    if(btnMale.tag==1)
        return GENDER_MALE;
    if(btnFemale.tag==1)
        return GENDER_FEMALE;
    
    return GENDER_NONE;
}

- (IBAction)btnMaleTouchUpInside:(id)sender {
}

- (IBAction)btnFemaleTouchUpInside:(id)sender {
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return false;
}

@end
