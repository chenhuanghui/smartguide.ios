//
//  FacebookMiningViewController.m
//  SmartGuide
//
//  Created by XXX on 7/24/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "FacebookMiningViewController.h"
#import "AlertView.h"
#import "Utility.h"
#import "UIImageView+AFNetworking.h"
#import "RootViewController.h"
#import "ASIOperationUploadFBToken.h"

@interface FacebookMiningViewController ()
{
}

@property (nonatomic, strong) FBProfile *profile;

@end

@implementation FacebookMiningViewController
@synthesize profile;

- (id)init
{
    self = [super initWithNibName:NIB_PHONE(@"FacebookMiningViewController") bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.navigationController setNavigationBarHidden:true];
    [[RootViewController shareInstance] setNeedRemoveLoadingScreen];
}

-(NSArray *)registerNotification
{
    return @[NOTIFICATION_FACEBOOK_LOGIN_SUCCESS];
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:NOTIFICATION_FACEBOOK_LOGIN_SUCCESS])
    {
        if(_isRequestingProfileFB)
            return;
        
        _isRequestingProfileFB=true;
        
        [Flurry trackUserWaitFacebook];
        
        _isGettedProfile=false;
        _isUploadedFBToken=false;
        
        getProfile=[[OperationFBGetProfile alloc] initWithAccessToken:[FBSession activeSession].accessTokenData.accessToken];
        getProfile.delegate=self;
        [getProfile start];
        
        //Send facebook access token to server
        [self uploadFBToken];
        
        [self.view showLoadingWithTitle:nil];
    }
}

-(void) loginFacebook
{
    [Flurry trackUserClickFacebook];
    [[FacebookManager shareInstance] login];
    _isRequestingProfileFB=false;
}
//
//-(void) postCheckinAppWithName:(NSString*) name
//{
//    [[FacebookManager shareInstance] postURL:[NSURL URLWithString:@"http://smartguide.vn"] title:@"SmartGuide - Trải nghiệm ngay nhận quà liền tay" text:[NSString stringWithFormat:@"Chúc mừng bạn %@ đã tham gia cộng đồng #SmartGuide. Chúc bạn có những trải nghiệm hoàn toàn thú vị cùng #SmartGuide",name]];
//}

-(void)operationURLFinished:(OperationURL *)operation
{
    if([operation isKindOfClass:[OperationFBGetProfile class]])
    {
        OperationFBGetProfile *ope=(OperationFBGetProfile*)operation;
        
        self.profile = [ope.profile copy];
        
        getProfile=nil;
        
        _isGettedProfile=true;
        
        [self notifyStartUploadProfile];
    }
}

-(void) notifyStartUploadProfile
{
    if(_isUploadedFBToken && _isGettedProfile)
    {
        postProfile=[[ASIOperationFBProfile alloc] initWithFBProfile:self.profile];
        postProfile.delegatePost=self;
        [postProfile startAsynchronous];
        
        [self.view showLoadingWithTitle:nil];
    }
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationFBProfile class]])
    {
        postProfile=nil;
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_UPLOAD_PROFILE_FINISHED object:nil];
    }
    else if([operation isKindOfClass:[ASIOperationUploadFBToken class]])
    {
        _isUploadedFBToken=true;
        
        [self notifyStartUploadProfile];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_UPLOAD_PROFILE_FINISHED object:nil];
    }
}

-(void) uploadFBToken
{
    ASIOperationUploadFBToken *operation=[[ASIOperationUploadFBToken alloc] initWithIDUser:[DataManager shareInstance].currentUser.idUser.integerValue fbToken:[FBSession activeSession].accessTokenData.accessToken];
    
    operation.delegatePost=self;
    
    [operation startAsynchronous];
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationFBProfile class]])
    {
        postProfile=nil;
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_UPLOAD_PROFILE_FINISHED object:nil];
    }
    else if([operation isKindOfClass:[ASIOperationUploadFBToken class]])
    {
//        [self uploadFBToken];
        _isUploadedFBToken=true;
        [self notifyStartUploadProfile];
    }
    else
    {
        [self.view removeLoading];
        [AlertView showAlertOKWithTitle:@"Thông báo" withMessage:@"Tạo thông tin đăng nhập thất bại" onOK:nil];
    }
}

-(void)operationURLFailed:(OperationURL *)operation
{
    [self.view removeLoading];
    [AlertView showAlertOKWithTitle:nil withMessage:[NSString stringWithFormat:@"%@",operation.error] onOK:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_UPLOAD_PROFILE_FINISHED object:nil];
}

- (void)viewDidUnload {
    btnFace = nil;
    [super viewDidUnload];
}

- (IBAction)btnCreateTouchUpInside:(id)sender
{
    CreateUserView *userView=[[CreateUserView alloc] init];
    
    CGRect rect=userView.frame;
    rect.origin=CGPointMake(0, self.view.frame.size.height);
    userView.frame=rect;
    
    [self.view addSubview:userView];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rectAnim=containtView.frame;
        rectAnim.origin.y=-rectAnim.size.height;
        containtView.frame=rectAnim;
        
        rectAnim=userView.frame;
        rectAnim.origin.y=0;
        userView.frame=rectAnim;
    } completion:^(BOOL finished) {
        [userView focusEdit];
    }];
}

- (IBAction)btnFaceTouchUpInside:(id)sender {
    [self loginFacebook];
}

@end
