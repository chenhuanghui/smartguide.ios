//
//  RegisterViewController.m
//  SmartGuide
//
//  Created by MacMini on 04/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "RegisterViewController.h"
#import "AvatarViewController.h"
#import "AuthorizationViewController.h"
#import <GoogleOpenSource/GoogleOpenSource.h>
#import "GooglePlusManager.h"

@interface RegisterViewController ()<AvatarControllerDelegate,GPPSignInDelegate>

@end

@implementation RegisterViewController
@synthesize authorizationController,delegate;

- (id)init
{
    self = [super initWithNibName:@"RegisterViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSArray *)registerNotifications
{
    return @[NOTIFICATION_FACEBOOK_LOGIN_SUCCESS,NOTIFICATION_FACEBOOK_LOGIN_FAILED];
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:NOTIFICATION_FACEBOOK_LOGIN_SUCCESS])
    {
        [authorizationController.view showLoading];
        
        _operationFBGetProfile=[[OperationFBGetProfile alloc] initWithAccessToken:[[FBSession activeSession] accessTokenData].accessToken];
        _operationFBGetProfile.delegate=self;
        
        [_operationFBGetProfile start];
    }
    else if([notification.name isEqualToString:NOTIFICATION_FACEBOOK_LOGIN_FAILED])
    {
        [AlertView showAlertOKWithTitle:nil withMessage:localizeFacebookError(notification.object) onOK:nil];
    }
}

#pragma mark - OperationURL

-(void)operationURLFinished:(OperationURL *)operation
{
    if([operation isKindOfClass:[OperationFBGetProfile class]])
    {
        OperationFBGetProfile *ope=(OperationFBGetProfile*) operation;
        
        if(ope.jsonData.length>0)
        {
            _operationUploadSocialProfile=[[ASIOperationUploadSocialProfile alloc] initWithProfile:[ope.jsonData copy] socialType:SOCIAL_FACEBOOK accessToken:[FBSession activeSession].accessTokenData.accessToken];
            _operationUploadSocialProfile.delegatePost=self;
            
            [_operationUploadSocialProfile startAsynchronous];
        }
        else
            [authorizationController.view removeLoading];
        
        _operationFBGetProfile=nil;
    }
    else if([operation isKindOfClass:[OperationGPGetUserProfile class]])
    {
        OperationGPGetUserProfile *ope=(OperationGPGetUserProfile*) operation;
        
        if(ope.jsonData.length>0)
        {
            _operationUploadSocialProfile=[[ASIOperationUploadSocialProfile alloc] initWithProfile:[ope.jsonData copy] socialType:SOCIAL_GOOGLEPLUS accessToken:[GooglePlusManager shareInstance].authentication.accessToken];
            _operationUploadSocialProfile.delegatePost=self;
            
            [_operationUploadSocialProfile startAsynchronous];
        }
        else
            [authorizationController.view removeLoading];
        
        _operationGPGetUserProfile=nil;
    }
}

-(void)operationURLFailed:(OperationURL *)operation
{
    if([operation isKindOfClass:[OperationFBGetProfile class]])
    {
        [authorizationController.view removeLoading];
        
        _operationFBGetProfile=nil;
    }
    else if([operation isKindOfClass:[OperationGPGetUserProfile class]])
    {
        [authorizationController.view removeLoading];
        
        _operationGPGetUserProfile=nil;
    }
}

#pragma mark ASIOperation

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUploadSocialProfile class]])
    {
        [authorizationController.view removeLoading];
        
        ASIOperationUploadSocialProfile *ope=(ASIOperationUploadSocialProfile*) operation;
        
        int status=ope.status;
        
        if(ope.message.length>0)
        {
            [AlertView showAlertOKWithTitle:nil withMessage:ope.message onOK:^{
                if(status==1)
                    [self.delegate registerControllerFinished:self];
            }];
        }
        else
        {
            if(status==1)
            {
                [self.delegate registerControllerFinished:self];
            }
        }
        
        _operationUploadSocialProfile=nil;
    }
    else if([operation isKindOfClass:[ASIOperationUpdateUserProfile class]])
    {
        [authorizationController.view removeLoading];
        
        ASIOperationUpdateUserProfile *ope=(ASIOperationUpdateUserProfile*) operation;
        
        int status=ope.status;
        
        if(ope.message.length>0)
        {
            [AlertView showAlertOKWithTitle:nil withMessage:ope.message onOK:^{
                if(status==1)
                    [self.delegate registerControllerFinished:self];
            }];
        }
        else
        {
            if(status==1)
                [self.delegate registerControllerFinished:self];
        }
        
        _operationUpdateUserProfile=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUploadSocialProfile class]])
    {
        [authorizationController.view removeLoading];
        
        _operationUploadSocialProfile=nil;
    }
    else if([operation isKindOfClass:[ASIOperationUpdateUserProfile class]])
    {
        [authorizationController.view removeLoading];
        
        _operationUpdateUserProfile=nil;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _registerInfo=[RegisterInfo new];
    
    RegisterInfoStep1ViewController *vc=[RegisterInfoStep1ViewController new];
    vc.delegate=self;
    vc.registerController=self;
    
    registerStep1=vc;
    
    SGNavigationController *navi=[[SGNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:navi];
    [containNavi addSubview:navi.view];
    [navi.view l_v_setS:containNavi.l_v_s];
    
    registerNavi=navi;
    
    [self settingButtonStep];
}

-(void)navigationController:(SGNavigationController *)navigationController willPopController:(SGViewController *)controller
{
    if([controller isKindOfClass:[AvatarViewController class]])
    {
        AvatarViewController *vc=(AvatarViewController*)controller;
        
        _avatars=[vc.avatars mutableCopy];
    }
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
    
    if(_isShowedDatePicker)
    {
        [self removeDatePicker];
    }
    
    if(registerStep2)
    {
        if(_registerInfo.birthday.length==0)
        {
            [AlertView showAlertOKWithTitle:nil withMessage:@"Bạn phải chọn ngày sinh" onOK:^{
                [registerStep2 showDOBPicker];
            }];
            return;
        }
        if(_registerInfo.gender==GENDER_NONE)
        {
            [AlertView showAlertOKWithTitle:nil withMessage:@"Bạn phải chọn giới tính" onOK:nil];
            return;
        }
        
        [self.authorizationController.view showLoading];
        
        _operationUpdateUserProfile=[[ASIOperationUpdateUserProfile alloc] initWithName:_registerInfo.name cover:nil avatar:_registerInfo.avatar avatarImage:UIImagePNGRepresentation(_registerInfo.selectedAvatar) gender:_registerInfo.gender socialType:SOCIAL_NONE birthday:_registerInfo.birthday];
        _operationUpdateUserProfile.delegatePost=self;
        
        [_operationUpdateUserProfile startAsynchronous];
    }
    else
    {
        [self showStep2];
    }
}

-(void) showAvatarController
{
    if([self.navigationController.visibleViewController isKindOfClass:[AvatarViewController class]])
        return;
    
    AvatarViewController *vc=[[AvatarViewController alloc] initWithAvatars:_avatars avatarImage:_registerInfo.selectedAvatar];
    vc.delegate=self;
    
    //Không có selectedAvatarImage vì index 0 là hình user đã chọn từ device
    
    if(_registerInfo.avatar)
        [vc setSelectedAvatar:_registerInfo.avatar];
    
    [self.navigationController pushViewController:vc animated:true];
}

- (IBAction)btnFacebookTouchUpInside:(id)sender {
    [[FacebookManager shareInstance] login];
}

- (IBAction)btnGooglePlusTouchUpInside:(id)sender {
    GPPSignIn *gp = [GPPSignIn sharedInstance];
    gp.clientID=kClientId;
    gp.scopes=@[kGTLAuthScopePlusLogin,kGTLAuthScopePlusMe];
    gp.delegate=self;
    gp.shouldFetchGooglePlusUser=true;
    gp.shouldFetchGoogleUserEmail=true;
    
    if(![gp trySilentAuthentication])
        [gp authenticate];
}

-(void)finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error
{
    if(!error)
    {
        [self.authorizationController.view showLoading];
        
        [GooglePlusManager shareInstance].authentication=auth;
        _operationGPGetUserProfile=[[OperationGPGetUserProfile alloc] initWithAccessToken:auth.accessToken clientID:kClientId];
        _operationGPGetUserProfile.delegate=self;
        
        [_operationGPGetUserProfile start];
    }
}

-(void)avatarControllerTouched:(AvatarViewController *)controller avatar:(NSString *)avatar avatarImage:(UIImage *)avatarImage
{
    if(avatar.length>0)
    {
        _registerInfo.avatar=avatar;
        _registerInfo.selectedAvatar=nil;
    }
    else
    {
        _registerInfo.avatar=@"";
        _registerInfo.selectedAvatar=avatarImage;
    }
    
    [registerStep1 loadData];
    
    [self.navigationController popViewControllerAnimated:true];
}

-(UIButton *)buttonNext
{
    return btnConfirm;
}

-(RegisterInfo *)registerInfo
{
    return _registerInfo;
}

- (IBAction)btnStep1TouchUpInside:(id)sender {
    [self showStep1];
}

- (IBAction)btnStep2TouchUpInside:(id)sender {
    [self showStep2];
}

-(void) showStep1
{
    if(registerNavi.visibleViewController==registerStep1)
        return;
    
    [self removeDatePicker];
    
    self.view.userInteractionEnabled=false;
    [registerNavi popViewControllerAnimated:true];
    
    [self settingButtonStep];
    
    [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
        [stepView l_v_setX:0];
        
        [btnConfirm setImage:[UIImage imageNamed:@"button_next_login.png"] forState:UIControlStateNormal];
        [btnConfirm setImage:[UIImage imageNamed:@"button_next_login.png"] forState:UIControlStateSelected];
        [btnConfirm setImage:[UIImage imageNamed:@"button_next_login.png"] forState:UIControlStateHighlighted];
    } completion:^(BOOL finished) {
        self.view.userInteractionEnabled=true;
        
        [registerStep1 focusName];
    }];
}

-(void) settingButtonStep
{
    double delayInSeconds = 0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        //step1
        if([registerNavi.visibleViewController isKindOfClass:[RegisterInfoStep1ViewController class]])
        {
            [btnStep1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [btnStep1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
            [btnStep1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
            
            [btnStep2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [btnStep2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
            [btnStep2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        }
        //step 2
        else
        {
            [btnStep1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [btnStep1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
            [btnStep1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
            
            [btnStep2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [btnStep2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
            [btnStep2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        }
    });
}

-(bool) validateStep1
{
    bool byPass=false;
    
    _registerInfo.name=registerStep1.name;
    
    if(!byPass && (_registerInfo.avatar.length==0 && !_registerInfo.selectedAvatar))
    {
        [AlertView showAlertOKWithTitle:nil withMessage:@"Bạn phải chọn avatar" onOK:^{
            [self showAvatarController];
        }];
        
        return false;
    }
    
    if(!byPass && _registerInfo.name.length==0)
    {
        [AlertView showAlertOKWithTitle:nil withMessage:@"Bạn phải nhập tên" onOK:^{
            [registerStep1 focusName];
        }];
        
        return false;
    }
    
    return true;
}

-(void) showStep2
{
    if(![self validateStep1])
        return;
    
    if(registerStep2)
        return;
    
    [self.view endEditing:true];
    
    RegisterInfoStep2ViewController *vc=[RegisterInfoStep2ViewController new];
    vc.delegate=self;
    vc.registerController=self;
    
    registerStep2=vc;
    
    [self settingButtonStep];
    
    [registerNavi pushViewController:vc animated:true];
    
    self.view.userInteractionEnabled=false;
    [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
        [stepView l_v_setX:self.l_v_w/2];
    } completion:^(BOOL finished) {
        self.view.userInteractionEnabled=true;
    }];
    
    double delayInSeconds = 0.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [btnConfirm setImage:[UIImage imageNamed:@"button_confirm_login.png"] forState:UIControlStateNormal];
        [btnConfirm setImage:[UIImage imageNamed:@"button_confirm_login.png"] forState:UIControlStateSelected];
        [btnConfirm setImage:[UIImage imageNamed:@"button_confirm_login.png"] forState:UIControlStateHighlighted];
    });
}

-(bool)isShowedDatePicker
{
    return _isShowedDatePicker;
}

-(UIDatePicker*) showDatePicker
{
    _isShowedDatePicker=true;
    
    UIDatePicker *datePicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, displayPickerView.l_v_y, displayPickerView.l_v_w, displayPickerView.l_v_h)];
    datePicker.datePickerMode=UIDatePickerModeDate;
    datePicker.locale=[NSLocale localeWithLocaleIdentifier:@"vi-vn"];
    
    if(_registerInfo.selectedDate)
        datePicker.date=_registerInfo.selectedDate;
    
    datePicker.alpha=0;
    
    [self.view insertSubview:datePicker belowSubview:btnConfirm];
    
    self.view.userInteractionEnabled=false;
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        datePicker.alpha=1;
    } completion:^(BOOL finished) {
        self.view.userInteractionEnabled=true;
    }];
    
    _datePicker=datePicker;
    
    return datePicker;
}

-(void)removeDatePicker
{
    if(!_isShowedDatePicker)
        return;
    
    if(_datePicker)
    {
        if(_datePicker.date)
        {
            _registerInfo.selectedDate=_datePicker.date;
            _registerInfo.birthday=[_registerInfo.selectedDate stringValueWithFormat:@"dd/MM/yyyy"];
            
            [registerStep2 loadData];
        }
        
        self.view.userInteractionEnabled=false;

        [UIView animateWithDuration:DURATION_DEFAULT animations:^{
            _datePicker.alpha=0;
        } completion:^(BOOL finished) {
            [_datePicker removeFromSuperview];
            _datePicker=nil;
            
            self.view.userInteractionEnabled=true;
            
            _isShowedDatePicker=false;
        }];
    }
    else
        _isShowedDatePicker=false;
}

-(NSString *)title
{
    return @"Tạo tài khoản";
}

- (IBAction)btnCreateTouchUpInside:(id)sender {
    registerView.hidden=false;
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        [socialView l_v_setX:-socialView.l_v_w];
        socialView.alpha=0;
        
        [registerView l_v_setX:0];
        registerView.alpha=1;
    } completion:^(BOOL finished) {
        socialView.hidden=true;
        
        [registerStep1 focusName];
    }];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    if(_isShowedDatePicker)
        [self removeDatePicker];
}

@end

@implementation RegisterInfo
@synthesize avatar,birthday,gender,name,selectedDate,selectedAvatar;

- (id)init
{
    self = [super init];
    if (self) {
        avatar=@"";
        birthday=@"";
        gender=GENDER_NONE;
        name=@"";
    }
    return self;
}

-(void)setSelectedAvatar:(UIImage *)_selectedAvatar
{
    selectedAvatar=_selectedAvatar;
    
    if(selectedAvatar)
        avatar=@"";
}

-(void)setAvatar:(NSString *)_avatar
{
    avatar=_avatar;
    
    if(avatar.length>0)
        selectedAvatar=nil;
}

@end