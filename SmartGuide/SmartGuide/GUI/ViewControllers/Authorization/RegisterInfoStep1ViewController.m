//
//  RegisterInfoStep1ViewController.m
//  SmartGuide
//
//  Created by MacMini on 07/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "RegisterInfoStep1ViewController.h"
#import "RegisterViewController.h"
#import "ImageManager.h"

@interface RegisterInfoStep1ViewController ()

@end

@implementation RegisterInfoStep1ViewController
@synthesize delegate,registerController;

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

    [txt addTarget:self action:@selector(textFieldDidChangedText:) forControlEvents:UIControlEventEditingChanged];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) textFieldDidChangedText:(UITextField*) textField
{
    btnName.hidden=textField.text.length>0;
    registerController.registerInfo.name=txt.text;
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

-(void)setAvatarImage:(UIImage *)avatar
{
    [imgvAvatar setImage:avatar];
    btnSelectAvatar.hidden=true;
}

-(void)setAvatar:(NSString *)avatar
{
    btnSelectAvatar.hidden=true;;
    [imgvAvatar loadAvatarWithURL:avatar];
}

-(NSString *)name
{
    return txt.text;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:true];
}

-(void)loadData
{
    txt.text=registerController.registerInfo.name;
    
    if(registerController.registerInfo.avatar.length>0)
        [self setAvatar:registerController.registerInfo.avatar];
    else if(registerController.registerInfo.selectedAvatar)
        [self setAvatarImage:registerController.registerInfo.selectedAvatar];
}

@end
