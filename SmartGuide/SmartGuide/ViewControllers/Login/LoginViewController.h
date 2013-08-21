//
//  LoginViewController.h
//  SmartGuide
//
//  Created by XXX on 7/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ViewController.h"
#import "OperationGetActionCode.h"
#import "OperationVerifyActiveCode.h"
#import "OperationGetToken.h"

@interface LoginViewController : ViewController<UITextViewDelegate,OperationURLDelegate>
{
    __weak IBOutlet UIImageView *imgvLogo;
    __weak IBOutlet UIView *bgNumPad;
    __weak IBOutlet UIButton *btn1;
    __weak IBOutlet UIButton *btn2;
    __weak IBOutlet UIButton *btn3;
    __weak IBOutlet UIButton *btn4;
    __weak IBOutlet UIButton *btn5;
    __weak IBOutlet UIButton *btn6;
    __weak IBOutlet UIButton *btn7;
    __weak IBOutlet UIButton *btn8;
    __weak IBOutlet UIButton *btn9;
    __weak IBOutlet UIButton *btnClear;
    __weak IBOutlet UIButton *btn0;
    __weak IBOutlet UIButton *btnDone;
    __weak IBOutlet UILabel *lblPhone;
    __weak IBOutlet UILabel *lblInfo;
    bool _isActived;
    NSString *_phone;
}

- (IBAction)btnNumberTouchUpInside:(id)sender;

@end

@interface LoginView : UIView

@end