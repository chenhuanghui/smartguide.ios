//
//  RegisterViewController.m
//  SmartGuide
//
//  Created by MacMini on 04/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "RegisterViewController.h"
#import "AvatarViewController.h"
#import "AuthorizationViewController.h"

@interface RegisterViewController ()<AvatarControllerDelegate>

@end

@implementation RegisterViewController
@synthesize authorizationController;

- (id)init
{
    self = [super initWithNibName:@"RegisterViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    RegisterInfoStep1ViewController *vc=[RegisterInfoStep1ViewController new];
    vc.delegate=self;
    
    registerStep1=vc;
    
    SGNavigationController *navi=[[SGNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:navi];
    [containNavi addSubview:navi.view];
    [navi.view l_v_setS:containNavi.l_v_s];
    
    registerNavi=navi;
}

-(void)navigationController:(SGNavigationController *)navigationController willPopController:(SGViewController *)controller
{
    if([controller isKindOfClass:[AvatarViewController class]])
    {
        AvatarViewController *vc=(AvatarViewController*)controller;
        
        _avatars=[vc.avatars mutableCopy];
        _avatarImage=vc.avatarImage;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)registerInfoStep1ControllerTouchedAvatar:(RegisterInfoStep1ViewController *)contorller
{
    [self showAvatarController];
}

- (IBAction)btnConfirmTouchUpInside:(id)sender {
    
    if(registerStep2)
    {
        if(registerStep2.dob.length==0)
        {
            [AlertView showAlertOKWithTitle:nil withMessage:@"Bạn phải chọn ngày sinh" onOK:^{
                [registerStep2 showDOBPicker];
            }];
            return;
        }
        if(registerStep2.gender==GENDER_NONE)
        {
            [AlertView showAlertOKWithTitle:nil withMessage:@"Bạn phải chọn giới tính" onOK:nil];
            return;
        }
        
        
    }
    else
    {
        bool byPass=true;
        
        if(!byPass && (registerStep1.avatar.length==0 && !registerStep1.avatarImage))
        {
            [AlertView showAlertOKWithTitle:nil withMessage:@"Bạn phải chọn avatar" onOK:^{
                [self showAvatarController];
            }];
            
            return;
        }
        
        if(!byPass && registerStep1.name.length==0)
        {
            [AlertView showAlertOKWithTitle:nil withMessage:@"Bạn phải nhập tên" onOK:^{
                [registerStep1 focusName];
            }];
            
            return;
        }
        
        [lblStep setText:@"2/2"];
        
        RegisterInfoStep2ViewController *vc=[RegisterInfoStep2ViewController new];
        vc.delegate=self;
        vc.registerController=self;
        
        registerStep2=vc;
        
        [registerNavi pushViewController:vc animated:true];
        
        double delayInSeconds = 0.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [btnConfirm setImage:[UIImage imageNamed:@"button_confirm_login.png"] forState:UIControlStateNormal];
            [btnConfirm setImage:[UIImage imageNamed:@"button_confirm_login.png"] forState:UIControlStateSelected];
            [btnConfirm setImage:[UIImage imageNamed:@"button_confirm_login.png"] forState:UIControlStateHighlighted];
        });
    }
}

-(void) showAvatarController
{
    AvatarViewController *vc=[[AvatarViewController alloc] initWithAvatars:_avatars avatarImage:_avatarImage];
    vc.delegate=self;
    
    if(_selectedAvatar)
        [vc setSelectedAvatar:_selectedAvatar];
    
    [self.navigationController pushViewController:vc animated:true];
}

- (IBAction)btnFacebookTouchUpInside:(id)sender {
}

- (IBAction)btnGooglePlusTouchUpInside:(id)sender {
}

-(void)avatarControllerTouched:(AvatarViewController *)controller avatar:(NSString *)avatar avatarImage:(UIImage *)avatarImage
{
    _avatars=[controller.avatars mutableCopy];
    _avatarImage=controller.avatarImage;
    
    if(avatar.length>0)
    {
        _selectedAvatar=[avatar copy];
        [registerStep1 setAvatar:avatar];
    }
    else
    {
        _selectedAvatar=@"";
        [registerStep1 setAvatarImage:avatarImage];
    }
    
    [self.navigationController popViewControllerAnimated:true];
}

-(UIButton *)buttonNext
{
    return btnConfirm;
}

@end
