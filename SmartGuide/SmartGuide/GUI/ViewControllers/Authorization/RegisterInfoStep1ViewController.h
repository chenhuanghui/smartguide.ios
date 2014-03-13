//
//  RegisterInfoStep1ViewController.h
//  SmartGuide
//
//  Created by MacMini on 07/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class RegisterInfoStep1ViewController,RegisterViewController;

@protocol RegisterInfoStep1Contorller <SGViewControllerDelegate>

-(void) registerInfoStep1ControllerTouchedAvatar:(RegisterInfoStep1ViewController*) contorller;

@end

@interface RegisterInfoStep1ViewController : SGViewController
{
    __weak IBOutlet UIButton *btnAvatar;
    __weak IBOutlet UIImageView *imgvAvatar;
    __weak IBOutlet UITextField *txt;
    __weak IBOutlet UIButton *btnSelectAvatar;
    __weak IBOutlet UIButton *btnName;
}

-(void) focusName;
-(NSString*) name;

-(void) loadData;

@property (nonatomic, weak) id<RegisterInfoStep1Contorller> delegate;
@property (nonatomic, weak) RegisterViewController *registerController;

@end