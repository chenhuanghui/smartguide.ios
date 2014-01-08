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
    return @[NOTIFICATION_FACEBOOK_LOGIN_SUCCESS];
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
}

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
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUploadSocialProfile class]])
    {
        [authorizationController.view removeLoading];
        
        _operationUploadSocialProfile=nil;
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
}

-(void)navigationController:(SGNavigationController *)navigationController willPopController:(SGViewController *)controller
{
    if([controller isKindOfClass:[AvatarViewController class]])
    {
        AvatarViewController *vc=(AvatarViewController*)controller;
        
        _avatars=[vc.avatars mutableCopy];
        _registerInfo.avatarImage=vc.avatarImage;
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
        
        [self.delegate registerControllerFinished:self];
    }
    else
    {
        bool byPass=true;
        
        _registerInfo.name=registerStep1.name;
        
        if(!byPass && (_registerInfo.name.length==0 && !_registerInfo.selectedAvatar))
        {
            [AlertView showAlertOKWithTitle:nil withMessage:@"Bạn phải chọn avatar" onOK:^{
                [self showAvatarController];
            }];
            
            return;
        }
        
        if(!byPass && _registerInfo.name.length==0)
        {
            [AlertView showAlertOKWithTitle:nil withMessage:@"Bạn phải nhập tên" onOK:^{
                [registerStep1 focusName];
            }];
            
            return;
        }
        
        [self showStep2];
    }
}

-(void) showAvatarController
{
    AvatarViewController *vc=[[AvatarViewController alloc] initWithAvatars:_avatars avatarImage:_registerInfo.avatarImage];
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
    
    double delayInSeconds = .0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        btnStep1.selected=true;
        btnStep2.selected=false;
    });
}

- (IBAction)btnStep2TouchUpInside:(id)sender {
    [self showStep2];
}

-(void) showStep1
{
    self.view.userInteractionEnabled=false;
    [registerNavi popViewControllerAnimated:true transition:transitionPushFromLeft()];
    
    [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
        [stepView l_v_setX:0];
        
        [btnConfirm setImage:[UIImage imageNamed:@"button_next_login.png"] forState:UIControlStateNormal];
        [btnConfirm setImage:[UIImage imageNamed:@"button_confirm_login.png"] forState:UIControlStateSelected];
        [btnConfirm setImage:[UIImage imageNamed:@"button_confirm_login.png"] forState:UIControlStateHighlighted];
    } completion:^(BOOL finished) {
        self.view.userInteractionEnabled=true;
    }];
}

-(void) showStep2
{
    if(registerStep2)
        return;
    
    RegisterInfoStep2ViewController *vc=[RegisterInfoStep2ViewController new];
    vc.delegate=self;
    vc.registerController=self;
    
    registerStep2=vc;
    
    [registerNavi pushViewController:vc animated:true transition:transitionPushFromRight()];
    
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

@end

@implementation RegisterInfo
@synthesize avatar,avatarImage,birthday,gender,name,selectedDate,selectedAvatar;

- (id)init
{
    self = [super init];
    if (self) {
        avatarImage=nil;
        avatar=@"";
        birthday=@"";
        gender=GENDER_NONE;
        name=@"";
    }
    return self;
}

@end