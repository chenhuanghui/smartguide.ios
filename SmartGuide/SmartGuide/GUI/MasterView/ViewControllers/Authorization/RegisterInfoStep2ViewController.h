//
//  RegisterInfoStep2ViewController.h
//  SmartGuide
//
//  Created by MacMini on 07/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class RegisterViewController;

@interface RegisterInfoStep2ViewController : SGViewController<UITextFieldDelegate>
{
    __weak IBOutlet UITextField *txtDay;
    __weak IBOutlet UITextField *txtMonth;
    __weak IBOutlet UITextField *txtYear;
    __weak IBOutlet UIButton *btnMale;
    __weak IBOutlet UIButton *btnFemale;
    __weak IBOutlet UIButton *btnDOB;
}

-(void) showDOBPicker;

@property (nonatomic, weak) RegisterViewController *registerController;

@end
