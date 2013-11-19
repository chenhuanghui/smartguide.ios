//
//  UserFacebookViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "UserFacebookViewController.h"
#import "ASIOperationUploadFBToken.h"

@interface UserFacebookViewController ()

@property (nonatomic, strong) FBProfile *profile;

@end

@implementation UserFacebookViewController
@synthesize delegate;

-(id)init
{
    self=[super initWithNibName:@"UserFacebookViewController" bundle:nil];
    
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
        
        [self.view SGShowLoading];
    }
}

-(void) loginFacebook
{
    [Flurry trackUserClickFacebook];
    [[FacebookManager shareInstance] login];
    _isRequestingProfileFB=false;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

-(void)dealloc
{
    NSLog(@"dealloc %@", CLASS_NAME);
}

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
        
        [self.view SGShowLoading];
    }
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationFBProfile class]])
    {
        postProfile=nil;
        [self.delegate userFacebookSuccessed];
    }
    else if([operation isKindOfClass:[ASIOperationUploadFBToken class]])
    {
        _isUploadedFBToken=true;
        
        [self notifyStartUploadProfile];
    }
    else
    {
        [self.delegate userFacebookSuccessed];
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
        [self.delegate userFacebookSuccessed];
    }
    else if([operation isKindOfClass:[ASIOperationUploadFBToken class]])
    {
        _isUploadedFBToken=true;
        [self notifyStartUploadProfile];
    }
    else
    {
        [self.view SGRemoveLoading];
        [AlertView showAlertOKWithTitle:@"Thông báo" withMessage:@"Tạo thông tin đăng nhập thất bại" onOK:nil];
    }
}

-(void)operationURLFailed:(OperationURL *)operation
{
    [self.view SGRemoveLoading];
    [AlertView showAlertOKWithTitle:nil withMessage:[NSString stringWithFormat:@"%@",operation.error] onOK:nil];
    
    [self.delegate userFacebookSuccessed];
}
- (IBAction)btnCreateTouchUpInside:(id)sender
{
    CreateUserView *userView=[[CreateUserView alloc] init];
    userView.delegate=self;
    
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

-(void)createUserFinished
{
    [DataManager shareInstance].currentUser.isConnectedFacebook=@(false);
    [DataManager shareInstance].currentUser.name=@"XXX";
    
    [[DataManager shareInstance] save];
    
    [self.delegate userFacebookSuccessed];
}

- (IBAction)btnFaceTouchUpInside:(id)sender {
    [self loginFacebook];
}

- (IBAction)face:(id)sender {
    
    [DataManager shareInstance].currentUser.isConnectedFacebook=@(true);
    [DataManager shareInstance].currentUser.name=@"XXX";
    
    [[DataManager shareInstance] save];
    
    [self.delegate userFacebookSuccessed];
}

- (IBAction)create:(id)sender {
    
    CreateUserView *userView=[[CreateUserView alloc] init];
    userView.delegate=self;
    
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


@end
