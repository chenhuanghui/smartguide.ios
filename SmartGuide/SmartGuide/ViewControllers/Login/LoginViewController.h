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

@interface LoginViewController : ViewController<UITextFieldDelegate,OperationURLDelegate>
{
    __weak IBOutlet UIImageView *imgvLogo;
    __weak IBOutlet UIImageView *smartguide;
    __weak IBOutlet UIImageView *km;
    __weak IBOutlet UIButton *btnDone;
    __weak IBOutlet UILabel *lblInfo;
    __weak IBOutlet UITextField *txt;
    
    
    bool _isActived;
    NSString *_phone;
    
    NSString *_inputPhone;
    NSTimer *_timerSMS;
    __weak IBOutlet UILabel *lblCountdown;
    __weak IBOutlet UILabel *lblGiay;
    __weak IBOutlet UILabel *lblResend;
    __weak IBOutlet UIButton *btnResent;
    int _time;
}

@end

@interface LoginView : UIView

@end