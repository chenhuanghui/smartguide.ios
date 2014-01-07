//
//  RegisterViewController.h
//  SmartGuide
//
//  Created by MacMini on 04/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "SGNavigationController.h"
#import "RegisterInfoStep1ViewController.h"
#import "RegisterInfoStep2ViewController.h"

@interface RegisterViewController : SGViewController<RegisterInfoStep1Contorller>
{
    __weak IBOutlet UIButton *btnAvatar;
    __weak IBOutlet UIButton *btnConfirm;
    __weak IBOutlet UIButton *btnFacebook;
    __weak IBOutlet UIButton *btnGooglePlus;
    __weak IBOutlet UITextField *txtName;
    __weak IBOutlet UIView *containNavi;
    
    __weak SGNavigationController *registerNavi;
    
    __weak RegisterInfoStep1ViewController *registerStep1;
}

@end
