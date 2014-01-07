//
//  RegisterViewController.m
//  SmartGuide
//
//  Created by MacMini on 04/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "RegisterViewController.h"
#import "AvatarViewController.h"


@interface RegisterViewController ()<AvatarControllerDelegate>

@end

@implementation RegisterViewController

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
    
    if(registerNavi.viewControllers.count==1)
    {
        if(registerStep1.avatar.length==0 || !registerStep1.avatarImage)
        {
            [AlertView showAlertOKWithTitle:nil withMessage:@"Bạn phải chọn avatar" onOK:^{
                [self showAvatarController];
            }];
            
            return;
        }
        
        if(registerStep1.name.length==0)
        {
            [AlertView showAlertOKWithTitle:nil withMessage:@"Bạn phải nhập tên" onOK:^{
                [registerStep1 focusName];
            }];
            
            return;
        }
        
        RegisterInfoStep2ViewController *vc=[RegisterInfoStep2ViewController new];
        vc.delegate=self;
        
        [registerNavi pushViewController:vc animated:true];
    }
    else
    {
        
    }
}

-(void) showAvatarController
{
    AvatarViewController *vc=[AvatarViewController new];
    vc.delegate=self;
    
    [self.navigationController pushViewController:vc animated:true];
}

- (IBAction)btnFacebookTouchUpInside:(id)sender {
}

- (IBAction)btnGooglePlusTouchUpInside:(id)sender {
}

-(void)avatarControllerTouched:(AvatarViewController *)controller avatar:(NSString *)avatar
{
    
}

@end
