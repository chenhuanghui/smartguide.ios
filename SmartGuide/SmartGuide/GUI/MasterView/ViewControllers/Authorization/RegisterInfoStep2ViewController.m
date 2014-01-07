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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)dob
{
    if(_selectedDate)
        return [_selectedDate stringValueWithFormat:@"dd/MM/yyyy"];
    
    return @"";
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
    btnMale.tag=1;
    btnFemale.tag=0;
    
    [self settingGender];
}

- (IBAction)btnFemaleTouchUpInside:(id)sender {
    btnMale.tag=0;
    btnFemale.tag=1;
    
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
    [self.registerController buttonNext].hidden=true;
    
    UIDatePicker *datePicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.l_v_w, self.l_v_h)];
    datePicker.datePickerMode=UIDatePickerModeDate;
    datePicker.locale=[NSLocale localeWithLocaleIdentifier:@"vi-vn"];
 
    if(_selectedDate)
        datePicker.date=_selectedDate;
    
    [self.view alphaViewWithColor:[UIColor darkGrayColor]];
    
    [self.view.alphaView addSubview:datePicker];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"button_confirm_login.png"] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(btnConfirmDOBTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:self.registerController.buttonNext.frame];
    [btn l_v_addY:-22];
    
    [self.view.alphaView addSubview:btn];
}

-(void) btnConfirmDOBTouchUpInside:(UIButton*) btn
{
    btnDOB.hidden=true;
    
    UIDatePicker *datePicker=self.view.alphaView.subviews[0];
    _selectedDate=datePicker.date;
    
    txtDay.text=[NSString stringWithFormat:@"%02i",_selectedDate.day];
    txtMonth.text=[NSString stringWithFormat:@"%02i",_selectedDate.month];
    txtYear.text=[NSString stringWithFormat:@"%i",_selectedDate.year];
    
    [self.registerController buttonNext].hidden=false;
    [self.view removeAlphaView];
}

- (IBAction)btnDOBTouchUpInside:(id)sender {
    [self showDOBPicker];
}

@end
