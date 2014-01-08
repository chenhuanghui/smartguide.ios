//
//  RegisterInfoStep2ViewController.m
//  SmartGuide
//
//  Created by MacMini on 07/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "RegisterInfoStep2ViewController.h"
#import "AuthorizationViewController.h"

@interface RegisterInfoStep2ViewController ()

@end

@implementation RegisterInfoStep2ViewController
@synthesize registerController;

- (id)init
{
    self = [super initWithNibName:@"RegisterInfoStep2ViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self loadData];
}

-(void) loadData
{
    if(registerController.registerInfo.gender==GENDER_MALE)
        [self male];
    else if(registerController.registerInfo.gender==GENDER_FEMALE)
        [self female];
    
    if(registerController.registerInfo.selectedDate)
        [self settingBirthday:registerController.registerInfo.selectedDate];
}

-(void) settingBirthday:(NSDate*) date
{
    txtDay.text=[NSString stringWithFormat:@"%02i",date.day];
    txtMonth.text=[NSString stringWithFormat:@"%02i",date.month];
    txtYear.text=[NSString stringWithFormat:@"%i",date.year];
    
    btnDOB.hidden=true;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnMaleTouchUpInside:(id)sender {
    [self male];
}

-(void) male
{
    btnMale.tag=1;
    btnFemale.tag=0;
    registerController.registerInfo.gender=GENDER_MALE;
    
    [self settingGender];
}

- (IBAction)btnFemaleTouchUpInside:(id)sender {
    [self female];
}

-(void) female
{
    btnMale.tag=0;
    btnFemale.tag=1;
    registerController.registerInfo.gender=GENDER_FEMALE;
    
    [self settingGender];
}

-(void) settingGender
{
    UIImage *tickOn=[UIImage imageNamed:@"button_tickon.png"];
    UIImage *tickOff=[UIImage imageNamed:@"button_tickoff.png"];
    
    if(btnMale.tag==0)
    {
        [btnMale setImage:tickOff forState:UIControlStateNormal];
        [btnMale setImage:tickOn forState:UIControlStateHighlighted];
        [btnMale setImage:tickOn forState:UIControlStateSelected];
    }
    else
    {
        [btnMale setImage:tickOn forState:UIControlStateNormal];
        [btnMale setImage:tickOff forState:UIControlStateHighlighted];
        [btnMale setImage:tickOff forState:UIControlStateSelected];
    }
    
    if(btnFemale.tag==0)
    {
        [btnFemale setImage:tickOff forState:UIControlStateNormal];
        [btnFemale setImage:tickOn forState:UIControlStateHighlighted];
        [btnFemale setImage:tickOn forState:UIControlStateSelected];
    }
    else
    {
        [btnFemale setImage:tickOn forState:UIControlStateNormal];
        [btnFemale setImage:tickOff forState:UIControlStateHighlighted];
        [btnFemale setImage:tickOff forState:UIControlStateSelected];
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self showDOBPicker];
    
    return false;
}

-(void) showDOBPicker
{
    if(self.registerController.isShowedDatePicker)
        return;
    
    UIDatePicker *dp=[self.registerController showDatePicker];
    
    [dp addTarget:self action:@selector(dobChanged:) forControlEvents:UIControlEventValueChanged];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.cancelsTouchesInView=false;
    tap.delaysTouchesEnded=false;
    tap.delaysTouchesBegan=false;
    
    [self.view addGestureRecognizer:tap];
}

-(void) tap:(UITapGestureRecognizer*) tap
{
    [registerController removeDatePicker];
    [self.view removeGestureRecognizer:tap];
}

-(void) dobChanged:(UIDatePicker*) datePicker
{
    registerController.registerInfo.selectedDate=datePicker.date;
    registerController.registerInfo.birthday=[datePicker.date stringValueWithFormat:@"dd/MM/yyyy"];
    [self settingBirthday:datePicker.date];
}

- (IBAction)btnDOBTouchUpInside:(id)sender {
    [self showDOBPicker];
}

@end
