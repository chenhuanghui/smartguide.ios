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
    shouldRelogin=true;
    NSLog(@"sharerFailedWithError %@ %@",sharer,error);
}



-(void)sharerAuthDidFinish1:(SHKSharer *)sharer success:(BOOL)success
{
    NSLog(@"sharerAuthDidFinish %@ %i",sharer,success);
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

-(void)facebookLogined:(SHKFacebook *)shk session:(FBSession *)session error:(NSError *)error
{
    if(session.state==FBSessionStateOpen||session.state==FBSessionStateOpenTokenExtended)
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_LOGIN_SUCCESS object:nil];
    else
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_LOGIN_FAILED object:nil];
}

-(void)facebookAuthorizedPost:(SHKFacebook *)shk session:(FBSession *)session error:(NSError *)error
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_LOGIN_SUCCESS object:nil];
}

-(void)postText:(NSString *)text identity:(id) tag delegate:(id<SHKFacebookDelegate>) delegate
{
    SHKItem *item=[SHKItem text:text];
    item.tagIdentity=tag;
    ((SHKFacebook*)[SHKFacebook shareItem:item]).shareDelegate=delegate;
}

-(void) postURL:(NSURL*) url title:(NSString*) title text:(NSString *)text
{
    SHKItem *item=[SHKItem URL:url title:title contentType:SHKURLContentTypeWebpage];
    item.text=text;
    [SHKFacebook shareItem:item];
}

-(void)postImage:(UIImage *)image text:(NSString *)text identity:(id)tag delegate:(id<SHKFacebookDelegate>)delegate
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
    return [FBSession activeSession].state==FBSessionStateOpen || [FBSession activeSession].state==FBSessionStateOpenTokenExtended;
}

-(bool)isAllowPost
{
    return [self isLogined] && [[FBSession activeSession].permissions containsObject:@"publish_actions"];
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