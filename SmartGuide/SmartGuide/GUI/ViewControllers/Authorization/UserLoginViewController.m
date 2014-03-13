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
    return @[UIApplicationWillResignActiveNotification,UIKeyboardWillShowNotification];
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:UIApplicationWillResignActiveNotification])
    {
        [Flurry trackUserHideAppWhenLogin];
    }
    else if([notification.name isEqualToString:UIKeyboardWillShowNotification])
    {
        _keyboardHeight=[notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, txtPhone.l_v_h)];
    lbl.backgroundColor=[UIColor clearColor];
    lbl.textColor=txtPhone.textColor;
    lbl.font=txtPhone.font;
    lbl.textAlignment=NSTextAlignmentCenter;
    
    lbl.text=@"(+84)";
    
    txtPhone.leftView=lbl;
    txtPhone.leftViewMode=UITextFieldViewModeAlways;
    
    FTCoreTextStyle *style=[FTCoreTextStyle styleWithName:@"text"];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.font=[UIFont fontWithName:@"Avenir-Roman" size:13];
    style.color=[UIColor darkGrayColor];
    
    [lblBottom addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"bold"];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.font=[UIFont fontWithName:@"Avenir-Roman" size:13];
    style.color=[UIColor redColor];
    
    [lblBottom addStyle:style];
    
//    NSString *fakePhone=@"841656148907";
//    [self switchToActivationModeWithPhone:fakePhone];
}

-(void) switchToActivationModeWithPhone:(NSString*) phone
{
    _phone=phone;
    txtPhone.text=@"";
    
    UILabel *lbl=(UILabel*)txtPhone.leftView;
    lbl.text=@"";
    [lbl l_v_setW:10];
    txtPhone.placeholder=@"Mã xác thực";
    
    lblTop.text=@"Nhập mã xác thực";
    
    [btnLogin setDefaultImage:[UIImage imageNamed:@"button_confirm_login.png"] highlightImage:[UIImage imageNamed:@"button_confirm_login.png"]];
    
    _countdown=21;
    [self setCountdown];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [txtPhone becomeFirstResponder];
}

-(void)operationURLFinished:(OperationURL *)operation
{
    if([operation isKindOfClass:[OperationGetActionCode class]])
    {
        [self.view removeLoading];
        
        OperationGetActionCode *ope=(OperationGetActionCode*) operation;
        
        if(ope.isSuccess)
        {
            [self switchToActivationModeWithPhone:ope.phone];
        }
        
        if(ope.message.length>0)
            [AlertView showAlertOKWithTitle:nil withMessage:ope.message onOK:nil];
        
        _operationGetActionCode=nil;
    }
}

-(void) setCountdown
{
    if(_countdown<0)
        return;
    
    [lblBottom setText:[NSString stringWithFormat:@"<text>Bạn sẽ nhận được mã xác thực sau <bold>%i</bold> giây</text>",_countdown--]];
    
    [self performSelector:@selector(setCountdown) withObject:nil afterDelay:1];
}

-(void)operationURLFailed:(OperationURL *)operation
{
    if([operation isKindOfClass:[OperationGetActionCode class]])
    {
        _operationGetActionCode=nil;
        
        [self.view removeLoading];
        [AlertView showAlertOKWithTitle:nil withMessage:@"Lỗi kết nối hệ thống" onOK:nil];
    }
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserCheck class]])
    {
        [self.view removeLoading];
        
        ASIOperationUserCheck *ope=(ASIOperationUserCheck*) operation;
        
        if(ope.isSuccess)
        {
            if(ope.message.length>0)
            {
                [AlertView showAlertOKWithTitle:nil withMessage:ope.message onOK:^{
                    [self finishLogin];
                }];
            }
            else
                [self finishLogin];
        }
        else
        {
            NSString *msg=localizeInvailActivationCode();
            
            if(ope.message.length>0)
                msg=ope.message;
            
            [AlertView showAlertOKWithTitle:nil withMessage:msg onOK:^{
                [txtPhone becomeFirstResponder];
            }];
        }
        
        _operationUserCheck=nil;
    }
}

-(void) finishLogin
{
    [SGData shareInstance].fScreen=[UserLoginViewController screenCode];
    [self.delegate userLoginSuccessed];
}

+(NSString *)screenCode
{
    return SCREEN_CODE_LOGIN;
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserCheck class]])
    {
        [self.view removeLoading];
        
        _operationUserCheck=nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnLoginTouchUpInside:(id)sender {
    
    if(_phone.length==0)
    {
        if(txtPhone.text.length<9)
        {
            [AlertView showAlertOKWithTitle:nil withMessage:@"Số điện thoại không họp lệ" onOK:nil];
            return;
        }
        
        if([txtPhone.text startsWith:@"84"])
            txtPhone.text=[txtPhone.text deleteStringAtRange:NSMakeRange(0, 2)];
        else if([txtPhone.text startsWith:@"084"])
            txtPhone.text=[txtPhone.text deleteStringAtRange:NSMakeRange(0, 3)];
        else if([txtPhone.text startsWith:@"0"])
            txtPhone.text=[txtPhone.text deleteCharacterAtIndex:0];
        
        NSString *phone=txtPhone.text;
        phone=[@"84" stringByAppendingString:phone];
        
        _operationGetActionCode=[[OperationGetActionCode alloc] initWithPhone:phone fScreen:[SGData shareInstance].fScreen fData:[SGData shareInstance].fData];
        _operationGetActionCode.delegate=self;
        
        [_operationGetActionCode start];
        
        [self.view showLoadingInsideFrame:CGRectMake(0, 0, self.l_v_w, self.l_v_h-_keyboardHeight)];
    }
    else
    {
        if(txtPhone.text.length<4)
        {
            [AlertView showAlertOKWithTitle:nil withMessage:@"Mã xác thực không họp lệ" onOK:nil];
            return;
        }
        
        _operationUserCheck=[[ASIOperationUserCheck alloc] initWithPhone:_phone aciveCode:txtPhone.text];
        _operationUserCheck.delegatePost=self;
        
        [_operationUserCheck startAsynchronous];
        
        [self.view showLoadingInsideFrame:CGRectMake(0, 0, self.l_v_w, self.l_v_h-_keyboardHeight)];
    }
}

- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if(_operationGetActionCode || _operationUserCheck)
        return false;
    
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
    
    int maxLength=11;
    
    if(_phone.length>0)
        maxLength=4;
    
    return newLength <= maxLength || returnKey;
}

-(void)viewDidUnload
{
    [super viewDidUnload];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(setCountdown) object:nil];
}

-(NSString *)title
{
    return @"Đăng nhập";
}

-(void)dealloc
{
    if(_operationGetActionCode)
    {
        [_operationGetActionCode cancel];
        _operationGetActionCode=nil;
    }
    
    if(_operationUserCheck)
    {
        [_operationUserCheck clearDelegatesAndCancel];
        _operationUserCheck=nil;
    }
}

@end
