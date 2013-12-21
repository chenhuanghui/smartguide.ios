//
//  UserLoginViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "UserLoginViewController.h"

#define DURATION_RESET_SMS 30

#if DEBUG
#define SKIP_INPUT_PHONE 1
#endif

@interface UserLoginViewController ()

@end

@implementation UserLoginViewController
@synthesize delegate;

-(id)init
{
    self=[super initWithNibName:@"UserLoginViewController" bundle:nil];
    
    return self;
}

-(NSArray *)registerNotifications
{
    return @[NOTIFICATION_LOADING_SCREEN_FINISHED,UIApplicationWillResignActiveNotification];
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:NOTIFICATION_LOADING_SCREEN_FINISHED])
    {
        [txt becomeFirstResponder];
    }
    else if([notification.name isEqualToString:UIApplicationWillResignActiveNotification])
    {
        [Flurry trackUserHideAppWhenLogin];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

#if 0
    if([SERVER_API isContainString:@"https"])
        [AlertView showAlertOKWithTitle:@"PRODUCTION MODE" withMessage:nil onOK:nil];
    else
        [AlertView showAlertOKWithTitle:@"DEVELOPER MODE" withMessage:nil onOK:nil];
#endif
    
    [Flurry trackUserViewLogin];
    
    _inputPhone=@"";
    lblCountdown.hidden=true;
    lblCountdown.text=@"";
    
    [self switchToActiveCode];
    
    [txt becomeFirstResponder];
    
    _isActived=false;
    
#if SKIP_INPUT_PHONE
    _isActived=true;
    
    lblInfo.text=@"Nhập mã số xác nhận";
    txt.text=@"";
    txt.leftView=nil;
    txt.leftViewMode=UITextFieldViewModeNever;
    
    lblInfo.layer.shadowColor=[lblInfo.textColor CGColor];
    lblInfo.layer.shadowOffset=CGSizeMake(0, 0);
    [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
        lblInfo.textColor=[UIColor color255WithRed:255 green:0 blue:0 alpha:255];
    } completion:^(BOOL finished) {
        
    }];
    
    lblResend.hidden=true;
    btnResent.hidden=true;
    
    lblCountdown.text=[NSString stringWithFormat:@"%02i",DURATION_RESET_SMS];
    lblGiay.alpha=0;
    lblCountdown.alpha=0;
    lblGiay.hidden=false;
    lblCountdown.hidden=false;

    [UIView animateWithDuration:DURATION_DEFAULT delay:0.5f options:UIViewAnimationOptionCurveLinear animations:^{
        lblGiay.alpha=1;
        lblCountdown.alpha=1;
    } completion:^(BOOL finished) {
        _time=DURATION_RESET_SMS-1;
        _timerSMS=[NSTimer timerWithTimeInterval:1 target:self selector:@selector(countdownSMS) userInfo:nil repeats:true];
        [[NSRunLoop currentRunLoop] addTimer:_timerSMS forMode:NSDefaultRunLoopMode];
    }];
    
    _phone=@"841225372227";
#endif
}

-(void) flashLabel
{
    // leak cycle
    if(!self.view.superview)
        return;
    
    [UIView animateWithDuration:1 animations:^{
        lblInfo.alpha=0.3f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            lblInfo.alpha=1;
        } completion:^(BOOL finished) {
            [self flashLabel];
        }];
    }];
}

-(void)didMoveToParentViewController:(UIViewController *)parent
{
    [super didMoveToParentViewController:parent];
    
    if(parent)
    {
        [self flashLabel];
    }
    
    if(!parent)
    {
        // leak
        if(_timerSMS)
        {
            [_timerSMS invalidate];
            _timerSMS=nil;
        }
    }
}

-(void) login
{
    [Flurry trackUserClickVerifyCode];
    
    if(txt.text.length!=4)
    {
        [AlertView showAlertOKWithTitle:nil withMessage:@"Mã xác thực không hợp lệ" onOK:nil];
        return;
    }
    
    OperationVerifyActiveCode *operation=[[OperationVerifyActiveCode alloc] initWithPhone:_phone aciveCode:txt.text];
    operation.delegate=self;
    
    [operation start];
    
    [self.view showLoading];
    
    [self.view endEditing:true];
}

-(void) requestActiveCode
{
    [Flurry trackUserClickRequestActiveCode];
    
    NSString *phone=[NSString stringWithStringDefault:txt.text];
    if(phone.length==0)
    {
        [AlertView showAlertOKWithTitle:nil withMessage:@"Vui lòng nhập số điện thoại" onOK:nil];
        return;
    }
    if(phone.length<9 || phone.length>11)
    {
        [AlertView showAlertOKWithTitle:nil withMessage:@"Số điện thoại không hợp lệ" onOK:nil];
        return;
    }
    
    NSString *strPhone=[NSString stringWithString:phone];
    
    if([[strPhone substringToIndex:3] isEqualToString:@"840"])
    {
        strPhone=[phone stringByReplacingCharactersInRange:NSMakeRange(0, 3) withString:@"84"];
    }
    else if([[strPhone substringWithRange:NSMakeRange(0, 1)] isEqual:@"0"])
    {
        strPhone=[phone stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@"84"];
    }
    else
    {
        strPhone=[@"84" stringByAppendingString:phone];
    }
    
    _phone=[[NSString alloc] initWithString:strPhone];
    _inputPhone=[[NSString alloc] initWithString:txt.text];
    
    [AlertView showWithTitle:[((UILabel*)txt.leftView).text stringByAppendingFormat:@" %@", txt.text] withMessage:@"Mã kích hoạt SmartGuide sẽ được gởi đến số điện thoại trên. Chọn \"Đồng ý\" để tiếp tục hoặc \"Huỷ\" để thay đổi số điện thoại" withLeftTitle:@"Huỷ" withRightTitle:@"Đồng ý" onOK:^{
        [txt becomeFirstResponder];
    } onCancel:^{
        
        [self.view endEditing:true];
        
        OperationGetActionCode *operation=[[OperationGetActionCode alloc] initWithPhone:strPhone];
        operation.delegate=self;
        [operation start];
        
        [self.view showLoading];
    }];
}

-(void) countdownSMS
{
    [UIView animateWithDuration:0.2f animations:^{
        lblCountdown.alpha=0;
    } completion:^(BOOL finished) {
        lblCountdown.text=[NSString stringWithFormat:@"%02i",_time--];
        [UIView animateWithDuration:0.8f animations:^{
            lblCountdown.alpha=1;
        } completion:^(BOOL finished) {
            if(_time==0)
            {
                [_timerSMS invalidate];
                _timerSMS=nil;
                
                [self showReset];
            }
        }];
    }];
}

-(void) showReset
{
    lblResend.alpha=0;
    lblResend.hidden=false;
    btnResent.alpha=0;
    btnResent.hidden=false;
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        lblGiay.alpha=0;
        lblCountdown.alpha=0;
        lblResend.alpha=1;
        btnResent.alpha=1;
    } completion:^(BOOL finished) {
        lblGiay.hidden=true;
        lblCountdown.hidden=true;
    }];
}

-(void) switchToActiveCode
{
    lblCountdown.hidden=true;
    lblCountdown.text=@"";
    lblGiay.hidden=true;
    txt.text=_inputPhone;
    
    lblInfo.textColor=[UIColor color255WithRed:59 green:72 blue:100 alpha:255];
    lblInfo.text=@"Nhập số điện thoại của bạn";
    
    txt.rightViewMode=UITextFieldViewModeAlways;
    
    UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    v.backgroundColor=[UIColor clearColor];
    txt.rightView=v;
    
    NSString *str=@"  (+84)";
    UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, [str sizeWithFont:txt.font].width, 30)];
    lbl.font=txt.font;
    lbl.textColor=[UIColor grayColor];
    lbl.backgroundColor=[UIColor clearColor];
    lbl.text=str;
    txt.leftView=lbl;
    txt.leftViewMode=UITextFieldViewModeAlways;
}

-(void)operationURLFinished:(OperationURL *)operation
{
    if([operation isKindOfClass:[OperationGetActionCode class]])
    {
        [self.view showLoading];
        
        OperationGetActionCode *ope=(OperationGetActionCode*) operation;
        
        if(ope.isSuccess)
        {
            [self.view endEditing:true];
            
            _isActived=true;
            
            lblInfo.text=@"Nhập mã số xác nhận";
            txt.text=@"";
            txt.leftView=nil;
            txt.leftViewMode=UITextFieldViewModeNever;
            
            lblInfo.layer.shadowColor=[lblInfo.textColor CGColor];
            lblInfo.layer.shadowOffset=CGSizeMake(0, 0);
            [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
                lblInfo.textColor=[UIColor color255WithRed:255 green:0 blue:0 alpha:255];
            } completion:^(BOOL finished) {
                
            }];
            
            lblResend.hidden=true;
            btnResent.hidden=true;
            
            lblCountdown.text=[NSString stringWithFormat:@"%02i",DURATION_RESET_SMS];
            lblGiay.alpha=0;
            lblCountdown.alpha=0;
            lblGiay.hidden=false;
            lblCountdown.hidden=false;
            
            [UIView animateWithDuration:DURATION_DEFAULT delay:0.5f options:UIViewAnimationOptionCurveLinear animations:^{
                lblGiay.alpha=1;
                lblCountdown.alpha=1;
            } completion:^(BOOL finished) {
                _time=DURATION_RESET_SMS-1;
                _timerSMS=[NSTimer timerWithTimeInterval:1 target:self selector:@selector(countdownSMS) userInfo:nil repeats:true];
                [[NSRunLoop currentRunLoop] addTimer:_timerSMS forMode:NSDefaultRunLoopMode];
            }];
        }
        else
        {
            [AlertView showAlertOKWithTitle:nil withMessage:ope.message onOK:nil];
        }
    }
    else if([operation isKindOfClass:[OperationVerifyActiveCode class]])
    {
        [self.view showLoading];
        
        OperationVerifyActiveCode *ope=(OperationVerifyActiveCode*) operation;
        
        if(ope.isSuccess)
        {
            _idUser=ope.idUser;
            _name=[[NSString alloc] initWithString:ope.name];
            _avatar=[[NSString alloc] initWithString:ope.avatar];
            _isConnectedFacebook=ope.isConnectedFacebook;
            
            [self.view showLoading];
            
            OperationGetToken *getToken=[[OperationGetToken alloc] initWithPhone:_phone activeCode:txt.text];
            getToken.delegate=self;
            
            [getToken start];
        }
        else
        {
            [AlertView showAlertOKWithTitle:nil withMessage:@"Mã xác thực không đúng" onOK:nil];
        }
    }
    else if([operation isKindOfClass:[OperationGetToken class]])
    {
        if(_timerSMS)
        {
            [_timerSMS invalidate];
            _timerSMS=nil;
            lblCountdown.hidden=true;
            lblGiay.hidden=true;
        }
        
        OperationGetToken *ope=(OperationGetToken*) operation;
        
        [TokenManager shareInstance].accessToken=[[NSString alloc] initWithString:ope.accessToken];
        [TokenManager shareInstance].refreshTokenString=[[NSString alloc] initWithString:ope.refreshToken];
        [TokenManager shareInstance].phone=_phone;
        [TokenManager shareInstance].activeCode=txt.text;
        
        [Flags setLastIDUser:_idUser];
        User *user=[User userWithIDUser:_idUser];
        
        if(!user)
        {
            user=[User insert];
            user.idUser=@(_idUser);
        }
        
        user.name=_name;
        user.avatar=_avatar;
        user.isConnectedFacebook=@(_isConnectedFacebook);
        
        [[DataManager shareInstance] save];
        
        [DataManager shareInstance].currentUser=user;
        
        [self.view endEditing:true];
        
        [self.delegate userLoginSuccessed];
    }
}

-(void)operationURLFailed:(OperationURL *)operation
{
    [self.view showLoading];
    
    [AlertView showAlertOKWithTitle:nil withMessage:localizeConnectToServerFailed() onOK:nil];
}

- (IBAction)btnSendTouchUpInside:(id)sender {
    
    if(txt.leftView)
        [self requestActiveCode];
    else
        [self login];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(!_isActived)
    {
        if(string.length>0)
        {
            BOOL valid;
            NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
            NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:string];
            valid = [alphaNums isSupersetOfSet:inStringSet];
            if (!valid) // Not numeric
            {
                return false;
            }
        }
    }
    
    return true;
}

- (IBAction)btnResendTouchUpInside:(id)sender {
    
    NSString *str=[NSString stringWithFormat:@"(+84) %@",_inputPhone];
    
    [AlertView showWithTitle:str withMessage:@"Mã kích hoạt SmartGuide sẽ được gởi đến số điện thoại trên. Chọn \"Đồng ý\" để tiếp tục hoặc \"Huỷ\" để thay đổi số điện thoại" withLeftTitle:@"Huỷ" withRightTitle:@"Đồng ý" onOK:^{
    } onCancel:^{
        
        [self.view endEditing:true];
        
        OperationGetActionCode *operation=[[OperationGetActionCode alloc] initWithPhone:_phone];
        operation.delegate=self;
        [operation start];
        
        [self.view showLoading];
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:true];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSString *)title
{
    return CLASS_NAME;
}

- (void)viewDidUnload {
    imgvLogo = nil;
    btnDone = nil;
    lblInfo = nil;
    smartguide = nil;
    txt = nil;
    lblCountdown = nil;
    lblGiay = nil;
    lblResend = nil;
    btnResent = nil;
    [super viewDidUnload];
}

- (IBAction)back:(id)sender {
    [self.delegate userLoginCancelled];
}

- (IBAction)login:(id)sender {
    
    [User markDeleteAllObjects];

    [[DataManager shareInstance] save];
    
    User *user=[User insert];
    user.idUser=@(1);
    user.isConnectedFacebook=@(false);
    
    [Flags setLastIDUser:1];
    
    [[DataManager shareInstance] save];
    
    [self.delegate userLoginSuccessed];
}

@end
