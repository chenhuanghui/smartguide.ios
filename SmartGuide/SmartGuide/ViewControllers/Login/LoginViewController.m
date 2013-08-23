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
    // Do any additional setup after loading the view from its nib.
    
    _isActived=false;
    [self btnNumberTouchUpInside:btnClear];
    
//    lblPhone.text=@"01225372227";
    
//    if([[LocationManager shareInstance] isAllowLocation])
//        [[LocationManager shareInstance] tryGetUserLocationInfo];
    
    [self flashLabel];
}

-(NSArray *)registerNotification1
{
    return @[NOTIFICATION_LOCATION_AVAILABLE,NOTIFICATION_LOCATION_CITY_AVAILABLE];
}

-(void)receiveNotification1:(NSNotification *)notification
{
    if([notification.name isEqualToString:NOTIFICATION_LOCATION_AVAILABLE])
        [[LocationManager shareInstance] tryGetUserCityInfo];
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

- (IBAction)btnNumberTouchUpInside:(id)sender {
    
    UIButton *btn=(UIButton*)sender;
    
    switch (btn.tag) {
        case 10://clear
            if(_isActived)
                lblPhone.text=@"";
            else
                lblPhone.text=@"(+84)";
            break;
            
        case 11://done
            if(_isActived)
                [self login];
            else
                [self requestActiveCode];
            break;
            
        default:
            if(_isActived)
            {
                if(lblPhone.text.length==4)
                    return;
            }
            
            lblPhone.text=[lblPhone.text stringByAppendingString:btn.titleLabel.text];
            break;
    }
}

-(void) login
{
    if(lblPhone.text.length!=4)
    {
        [AlertView showAlertOKWithTitle:nil withMessage:@"Mã xác thực không hợp lệ" onOK:nil];
        return;
    }
    
    OperationVerifyActiveCode *operation=[[OperationVerifyActiveCode alloc] initWithPhone:_phone aciveCode:lblPhone.text];
    operation.delegate=self;
    
    [operation start];
    
    [self.view showLoadingWithTitle:nil];
}

-(void) requestActiveCode
{
    NSString *phone=[NSString stringWithStringDefault:lblPhone.text];
    phone=[phone stringByRemoveString:@"(",@")",@"+",nil];
    phone=[phone stringByTrimmingWhiteSpace];
    
    if([phone isEqualToString:@"84"])
    {
        [AlertView showAlertOKWithTitle:nil withMessage:@"Nhập số điện thoại dzô" onOK:nil];
        return;
    }
    
    if([[phone substringToIndex:3] isEqualToString:@"840"])
    {
        phone=[phone stringByReplacingCharactersInRange:NSMakeRange(0, 3) withString:@"84"];
    }
    _phone=[[NSString alloc] initWithString:phone];
    
    OperationGetActionCode *operation=[[OperationGetActionCode alloc] initWithPhone:phone];
    operation.delegate=self;
    [operation start];
    
    [self.view showLoadingWithTitle:nil];
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
            lblPhone.text=@"";
            
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
            
            OperationGetToken *getToken=[[OperationGetToken alloc] initWithPhone:_phone activeCode:lblPhone.text];
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
        [TokenManager shareInstance].activeCode=lblPhone.text;
        [Flags setLastIDUser:[DataManager shareInstance].currentUser.idUser.integerValue];
        
        [self.view showLoadingWithTitle:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGIN object:nil];
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
    bgNumPad = nil;
    btn1 = nil;
    btn2 = nil;
    btn3 = nil;
    btn4 = nil;
    btn5 = nil;
    btn6 = nil;
    btn7 = nil;
    btn8 = nil;
    btn9 = nil;
    btnClear = nil;
    btn0 = nil;
    btnDone = nil;
    lblPhone = nil;
    lblInfo = nil;
    [super viewDidUnload];
}
@end

@implementation LoginView



@end