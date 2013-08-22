//
//  FacebookManager.m
//  SmartGuide
//
//  Created by XXX on 7/24/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "FacebookManager.h"
#import "Constant.h"
#import "FBSession.h"
#import "FBAccessTokenData.h"
#import "DataManager.h"

static FacebookManager *_facebookManager=nil;
@implementation FacebookManager

+(FacebookManager *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _facebookManager=[[FacebookManager alloc] init];
    });
    
    return _facebookManager;
}

-(void)sharer:(SHKSharer *)sharer failedWithError:(NSError *)error shouldRelogin:(BOOL)shouldRelogin
{
    NSLog(@"sharerFailedWithError %@ %@",sharer,error);
}

-(void)sharerAuthDidFinish:(SHKSharer *)sharer success:(BOOL)success
{
    NSLog(@"sharerAuthDidFinish %@ %i",sharer,success);
    
    if(!success)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_LOGIN_FAILED object:nil];
        return;
    }
    
    if(![DataManager shareInstance].currentUser.isConnectedFacebook.boolValue)
    {
        OperationFBGetProfile *getProfile=[[OperationFBGetProfile alloc] initWithAccessToken:[FBSession activeSession].accessTokenData.accessToken];
        getProfile.delegate=self;
        
        [getProfile start];
    }
    else
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_LOGIN_SUCCESS object:nil];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationFBProfile class]])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_UPLOAD_PROFILE_FINISHED object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_LOGIN_SUCCESS object:nil];
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationFBProfile class]])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_UPLOAD_PROFILE_FINISHED object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_LOGIN_SUCCESS object:nil];
    }
}

-(void)operationURLFinished:(OperationURL *)operation
{
    if([operation isKindOfClass:[OperationFBGetProfile class]])
    {
        OperationFBGetProfile *getProfile=(OperationFBGetProfile*)operation;
        
        FBProfile *profile = getProfile.profile;
        
        User *user=[User userWithIDUser:[DataManager shareInstance].currentUser.idUser.integerValue];
        user.avatar=[NSString stringWithStringDefault:getProfile.profile.avatar];
        
        [DataManager shareInstance].currentUser=[User userWithIDUser:user.idUser.integerValue];
        
        ASIOperationFBProfile *postProfile=[[ASIOperationFBProfile alloc] initWithFBProfile:profile];
        postProfile.delegatePost=self;
        [postProfile startAsynchronous];
    }
}

-(void)operationURLFailed:(OperationURL *)operation
{
    if([operation isKindOfClass:[OperationFBGetProfile class]])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_LOGIN_SUCCESS object:nil];
    }
}

-(void)sharerCancelledSending:(SHKSharer *)sharer
{
    NSLog(@"sharerCancelledSending %@",sharer);
}

-(void)sharerFinishedSending:(SHKSharer *)sharer
{
    NSLog(@"sharerFinishedSending %@",sharer);
}

-(void)sharerStartedSending:(SHKSharer *)sharer
{
    NSLog(@"sharerStartedSending %@",sharer);
}

-(void)sharerShowBadCredentialsAlert:(SHKSharer *)sharer
{
    NSLog(@"sharerShowBadCredentialsAlert %@",sharer);
}

-(void)sharerShowOtherAuthorizationErrorAlert:(SHKSharer *)sharer
{
    NSLog(@"sharerShowOtherAuthorizationErrorAlert %@",sharer);
}

-(void)login
{
    SHKFacebook *fb=[[SHKFacebook alloc] init];
    fb.shareDelegate=self;
    if([fb authorize])
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_LOGIN_SUCCESS object:nil];
}

-(void)postText:(NSString *)text identity:(id) tag delegate:(id<SHKSharerDelegate>) delegate
{
    SHKItem *item=[SHKItem text:text];
    item.tagIdentity=tag;
    ((SHKFacebook*)[SHKFacebook shareItem:item]).shareDelegate=delegate;
}

-(void)postImage:(UIImage *)image text:(NSString *)text identity:(id)tag delegate:(id<SHKSharerDelegate>)delegate
{
    SHKItem *item=[SHKItem image:image title:text];
    item.tagIdentity=tag;
    
    ((SHKFacebook*)[SHKFacebook shareItem:item]).shareDelegate=delegate;
}

-(bool)isAuthorized
{
    return [SHKFacebook isServiceAuthorized];
}

-(bool)isLogined
{
    return [FBSession activeSession].state==FBSessionStateOpen;
}

@end

@implementation SHKFacebook(Utility)

- (BOOL)shouldShareSilently
{
    return true;
}

-(BOOL)quiet
{
    return true;
}

@end