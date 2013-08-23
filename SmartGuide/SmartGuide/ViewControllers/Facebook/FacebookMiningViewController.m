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
#import "FBSession.h"
#import "FBAccessTokenData.h"
#import "RootViewController.h"

@interface FacebookMiningViewController ()

@end

@implementation FacebookMiningViewController

- (id)init
{
    self = [super initWithNibName:@"FacebookMiningViewController" bundle:nil];
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
    return @[UIApplicationDidBecomeActiveNotification,NOTIFICATION_FACEBOOK_LOGIN_SUCCESS,NOTIFICATION_FACEBOOK_LOGIN_FAILED];
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:UIApplicationDidBecomeActiveNotification])
    {
        
        if([FBSession activeSession].accessTokenData && [FBSession activeSession].accessTokenData.accessToken)
        {
            btnFace.hidden=true;
            btnSkip.hidden=true;
        }
        else
        {
            btnFace.hidden=false;
            btnSkip.hidden=false;
        }
        
        if(!btnSkip.hidden)
            [self removeIndicator];
        
        if ([FBSession activeSession].accessTokenData.accessToken.length>0) {
            getProfile=[[OperationFBGetProfile alloc] initWithAccessToken:[FBSession activeSession].accessTokenData.accessToken];
            getProfile.delegate=self;
            [getProfile start];
            
            [self showIndicatoWithTitle:@"Get profile"];
        }
    }
    else if([notification.name isEqualToString:NOTIFICATION_FACEBOOK_LOGIN_SUCCESS])
    {
        getProfile=[[OperationFBGetProfile alloc] initWithAccessToken:[FBSession activeSession].accessTokenData.accessToken];
        getProfile.delegate=self;
        [getProfile start];
        
        [self showIndicatoWithTitle:@"Get profile"];
    }
    else if([notification.name isEqualToString:NOTIFICATION_FACEBOOK_LOGIN_FAILED])
    {
        [self removeIndicator];
        [AlertView showAlertOKWithTitle:nil withMessage:@"Login facebook failed" onOK:nil];
    }
}

-(void) loginFacebook
{
    [self showIndicatoWithTitle:@"Wait facebook"];
    [[FacebookManager shareInstance] login];
}

-(void)operationURLFinished:(OperationURL *)operation
{
    if([operation isKindOfClass:[OperationFBGetProfile class]])
    {
        OperationFBGetProfile *ope=(OperationFBGetProfile*)operation;
        
        FBProfile *profile = ope.profile;
        
        User *user=[User userWithIDUser:[DataManager shareInstance].currentUser.idUser.integerValue];
        user.avatar=[NSString stringWithStringDefault:ope.profile.avatar];
        
        [imgvAvatar setSmartGuideImageWithURL:[NSURL URLWithString:user.avatar] placeHolderImage:UIIMAGE_LOADING_AVATAR success:nil failure:nil];
        
        [[DataManager shareInstance] save];
        
        [DataManager shareInstance].currentUser=[User userWithIDUser:user.idUser.integerValue];
        
        getProfile=nil;
        
        postProfile=[[ASIOperationFBProfile alloc] initWithFBProfile:profile];
        postProfile.delegatePost=self;
        [postProfile startAsynchronous];
        
        [self showIndicatoWithTitle:@"Upload infomation"];
    }
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    postProfile=nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_UPLOAD_PROFILE_FINISHED object:nil];
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    postProfile=nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_UPLOAD_PROFILE_FINISHED object:nil];
}

-(void)operationURLFailed:(OperationURL *)operation
{
    [self removeIndicator];
    NSLog(@"%@ failed %@",CLASS_NAME,operation.error);
    [AlertView showAlertOKWithTitle:nil withMessage:[NSString stringWithFormat:@"%@",operation.error] onOK:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_UPLOAD_PROFILE_FINISHED object:nil];
}

- (void)viewDidUnload {
    btnSkip = nil;
    btnFace = nil;
    imgvAvatar = nil;
    [super viewDidUnload];
}

- (IBAction)skipTouchUpInside:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_UPLOAD_PROFILE_FINISHED object:nil];
}

- (IBAction)loginTouchUpInside:(id)sender {
    [self loginFacebook];
}

@end
