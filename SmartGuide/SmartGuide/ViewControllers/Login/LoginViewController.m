//
//  LoginViewController.m
//  SmartGuide
//
//  Created by XXX on 7/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "LoginViewController.h"
#import "DataManager.h"
#import "LocationManager.h"
#import "GMGridViewLayoutStrategies.h"
#import "Flags.h"
#import "TokenManager.h"
#import "RootViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    
    [[RootViewController shareInstance] setNeedRemoveLoadingScreen];
    
    _isActived=false;
    
    [self flashLabel];
    
    return;
    CGRect rect=imgvLogo.frame;
    rect.origin.y=self.view.frame.size.height+rect.size.height;
    imgvLogo.frame=rect;
    
    rect=smartguide.frame;
    rect.origin.y=self.view.frame.size.height+rect.size.height;
    smartguide.frame=rect;
    
    rect=km.frame;
    rect.origin.y=self.view.frame.size.height+rect.size.height;
    km.frame=rect;
    
    rect=lblInfo.frame;
    rect.origin.y=self.view.frame.size.height+rect.size.height;
    lblInfo.frame=rect;
    
    rect=txt.frame;
    rect.origin.y=self.view.frame.size.height+rect.size.height;
    txt.frame=rect;
    
    rect=btnDone.frame;
    rect.origin.y=self.view.frame.size.height+rect.size.height;
    btnDone.frame=rect;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

-(NSArray *)registerNotification
{
    return @[NOTIFICATION_LOADING_SCREEN_FINISHED];
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:NOTIFICATION_LOADING_SCREEN_FINISHED])
    {
        [txt becomeFirstResponder];
        return;
        self.view.userInteractionEnabled=false;
        
        CGRect rect=imgvLogo.frame;
        rect.origin.y=self.view.frame.size.height+rect.size.height;
        imgvLogo.frame=rect;
        
        rect=smartguide.frame;
        rect.origin.y=self.view.frame.size.height+rect.size.height;
        smartguide.frame=rect;
        
        rect=km.frame;
        rect.origin.y=self.view.frame.size.height+rect.size.height;
        km.frame=rect;
        
        rect=lblInfo.frame;
        rect.origin.y=self.view.frame.size.height+rect.size.height;
        lblInfo.frame=rect;
        
        rect=txt.frame;
        rect.origin.y=self.view.frame.size.height+rect.size.height;
        txt.frame=rect;
        
        rect=btnDone.frame;
        rect.origin.y=self.view.frame.size.height+rect.size.height;
        btnDone.frame=rect;
        
        [UIView animateWithDuration:1 animations:^{
            imgvLogo.frame=CGRectMake(106, 15, 114, 100);
        } completion:nil];
        
        [UIView animateWithDuration:1 delay:0.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            smartguide.frame=CGRectMake(116, 130, 95, 24);
        } completion:^(BOOL finished) {
        }];
        
        [UIView animateWithDuration:1 delay:1.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            km.frame=CGRectMake(53, 160, 221, 21);
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:1 animations:^{
                lblInfo.frame=CGRectMake(0, 168, 320, 21);
                txt.frame=CGRectMake(20, 189, 222, 50);
                btnDone.frame=CGRectMake(246, 188, 48, 51);
            } completion:^(BOOL finished) {
                self.view.userInteractionEnabled=true;
                [txt becomeFirstResponder];
            }];
        }];
    }
}

-(void) flashLabel
{
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

-(void) login
{
    if(txt.text.length!=4)
    {
        [AlertView showAlertOKWithTitle:nil withMessage:@"Mã xác thực không hợp lệ" onOK:nil];
        return;
    }
    
    OperationVerifyActiveCode *operation=[[OperationVerifyActiveCode alloc] initWithPhone:_phone aciveCode:txt.text];
    operation.delegate=self;
    
    [operation start];
    
    [self.view showLoadingWithTitle:nil];
}

-(void) requestActiveCode
{
    NSString *phone=[NSString stringWithStringDefault:txt.text];
    if(phone.length==0)
    {
        [AlertView showAlertOKWithTitle:nil withMessage:@"Vui lòng nhập số điện thoại" onOK:nil];
        return;
    }
    else if(phone.length<10 || phone.length>11)
    {
        [AlertView showAlertOKWithTitle:nil withMessage:@"Số điện thoại không hợp lệ" onOK:nil];
        return;
    }
    
    [AlertView showWithTitle:txt.text withMessage:@"Mã kích hoạt SmartGuide sẽ được gửi đến số điện thoại trên. Chọn \"Đồng ý\" để tiếp tục hoặc \"Huỷ\" để thay đổi số điện thoại" withLeftTitle:@"Huỷ" withRightTitle:@"Đồng ý" onOK:^{
        [txt becomeFirstResponder];
    } onCancel:^{
        NSString *strPhone=[NSString stringWithString:phone];
        
        if([[strPhone substringToIndex:3] isEqualToString:@"840"])
        {
            strPhone=[phone stringByReplacingCharactersInRange:NSMakeRange(0, 3) withString:@"84"];
        }
        else if([strPhone substringWithRange:NSMakeRange(0, 1)])
        {
            strPhone=[phone stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@"84"];
        }
        
        _phone=[[NSString alloc] initWithString:strPhone];
        
        OperationGetActionCode *operation=[[OperationGetActionCode alloc] initWithPhone:strPhone];
        operation.delegate=self;
        [operation start];
        
        [self.view showLoadingWithTitle:nil];
    }];
}

-(void)operationURLFinished:(OperationURL *)operation
{
    [self.view removeLoading];
    
    if([operation isKindOfClass:[OperationGetActionCode class]])
    {
        OperationGetActionCode *ope=(OperationGetActionCode*) operation;
        
        if(ope.isSuccess)
        {
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
        }
        else
        {
            [AlertView showAlertOKWithTitle:nil withMessage:@"Số điện thoại không hợp lệ" onOK:nil];
        }
    }
    else if([operation isKindOfClass:[OperationVerifyActiveCode class]])
    {
        OperationVerifyActiveCode *ope=(OperationVerifyActiveCode*) operation;
        
        if(ope.isSuccess)
        {
            [self.view showLoadingWithTitle:nil];
            
            [TokenManager shareInstance].phone=_phone;
            
            OperationGetToken *getToken=[[OperationGetToken alloc] initWithPhone:_phone activeCode:txt.text];
            getToken.delegate=self;
            
            [getToken start];
        }
        else
        {
            [AlertView showAlertOKWithTitle:nil withMessage:@"Mã xác thực không đúng" onOK:nil];
        }
    }
    else
    {
        OperationGetToken *ope=(OperationGetToken*) operation;
        
        [TokenManager shareInstance].accessToken=[[NSString alloc] initWithString:ope.accessToken];
        [TokenManager shareInstance].refreshTokenString=[[NSString alloc] initWithString:ope.refreshToken];
        [TokenManager shareInstance].activeCode=txt.text;
        [Flags setLastIDUser:[DataManager shareInstance].currentUser.idUser.integerValue];
        
        [self.view endEditing:true];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardDidHideNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            
            [[NSNotificationCenter defaultCenter] removeObserver:note];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGIN object:nil];
        }];
    }
}

-(void)operationURLFailed:(OperationURL *)operation
{
    [self.view removeLoading];
    if([operation isKindOfClass:[OperationGetActionCode class]])
    {
        [AlertView showAlertOKWithTitle:nil withMessage:@"Số điện thoại không hợp lệ" onOK:nil];
    }
    else if([operation isKindOfClass:[OperationVerifyActiveCode class]])
    {
        [AlertView showAlertOKWithTitle:nil withMessage:@"Mã xác thực không đúng" onOK:nil];
    }
    else
        [AlertView showAlertOKWithTitle:nil withMessage:@"Lỗi" onOK:nil];
}

-(bool)allowBannerAds
{
    return false;
}

-(bool)allowBottomBar
{
    return false;
}

- (void)viewDidUnload {
    imgvLogo = nil;
    btnDone = nil;
    lblInfo = nil;
    smartguide = nil;
    km = nil;
    txt = nil;
    [super viewDidUnload];
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

@end

@implementation LoginView



@end