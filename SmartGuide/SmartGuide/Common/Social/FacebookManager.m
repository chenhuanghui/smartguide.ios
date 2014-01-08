//
//  FacebookManager.m
//  SmartGuide
//
//  Created by XXX on 7/24/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "FacebookManager.h"
#import "Constant.h"
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

+(void)checkFacebookToken
{
    if(![FBSession openActiveSessionWithAllowLoginUI:false])
        [FBSession setActiveSession:nil];
}

-(void)login
{
    if([[FBSession activeSession] isOpen])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_LOGIN_SUCCESS object:nil];
        return;
    }
    
    [self openSession];
}

-(bool)isLogined
{
    return [FBSession activeSession].state==FBSessionStateOpen || [FBSession activeSession].state==FBSessionStateOpenTokenExtended;
}

- (void)openSession{
    if(NSClassFromString(@"SLComposeViewController"))
    {
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        {
            __block FBSessionStateHandler runOnceHandle=^(FBSession *session, FBSessionState status, NSError *error)
            {
                if(status==FBSessionStateOpen || status==FBSessionStateOpenTokenExtended)
                {
                    if(![session.permissions containsObject:@"publish_actions"])
                    {
                        dispatch_async(dispatch_get_current_queue(), ^{
                            [[FBSession activeSession] requestNewPublishPermissions:FACEBOOK_PUBLISH_PERMISSION defaultAudience:FBSessionDefaultAudienceEveryone completionHandler:^(FBSession *session, NSError *error) {
                                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_LOGIN_SUCCESS object:nil];
                            }];
                        });
                    }
                    else
                    {
                        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_LOGIN_SUCCESS object:nil];
                    }
                }
                else
                {
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_LOGIN_FAILED object:nil];
                    [[FBSession activeSession] closeAndClearTokenInformation];
                }
            };

            [FBSession openActiveSessionWithReadPermissions:FACEBOOK_READ_PERMISSION allowLoginUI:true completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                
                if(runOnceHandle)
                {
                    runOnceHandle(session,status,error);
                    runOnceHandle=nil;
                }
            }];
        }
        else
        {
            NSMutableArray *per=[NSMutableArray array];
            
            [per addObjectsFromArray:FACEBOOK_READ_PERMISSION];
            [per addObjectsFromArray:FACEBOOK_PUBLISH_PERMISSION];
            
            FBSession *session =
            [[FBSession alloc] initWithAppID:FACEBOOK_APPID
                                 permissions:per	// FB only wants read or publish so use default read, request publish when we need it
                             urlSchemeSuffix:@""
                          tokenCacheStrategy:nil];
            
            [FBSession setActiveSession:session];
            [session openWithCompletionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                
                if(error)
                    [FBSession.activeSession closeAndClearTokenInformation];
                
                if(status==FBSessionStateOpen||status==FBSessionStateOpenTokenExtended)
                {
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_LOGIN_SUCCESS object:nil];
                    return;
                }
                
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_LOGIN_FAILED object:nil];
            }];
        }
    }
    else
    {
        NSMutableArray *per=[NSMutableArray array];
        
        [per addObjectsFromArray:FACEBOOK_READ_PERMISSION];
        [per addObjectsFromArray:FACEBOOK_PUBLISH_PERMISSION];
        
        FBSession *session =
        [[FBSession alloc] initWithAppID:FACEBOOK_APPID
                             permissions:per	// FB only wants read or publish so use default read, request publish when we need it
                         urlSchemeSuffix:@""
                      tokenCacheStrategy:nil];
        
        [FBSession setActiveSession:session];
        [session openWithCompletionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
            
            if(error)
                [FBSession.activeSession closeAndClearTokenInformation];
            
            if(status==FBSessionStateOpen||status==FBSessionStateOpenTokenExtended)
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_LOGIN_SUCCESS object:nil];
                return;
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_LOGIN_FAILED object:nil];
        }];
    }
}

+ (BOOL)handleOpenURL:(NSURL*)url sourceApplication:(NSString *)sourceApplication annotation:(NSString *)annotation
{
	[FBSettings setDefaultAppID:FACEBOOK_APPID];
    
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
}

+ (void)handleWillTerminate
{
	[FBSettings setDefaultAppID:FACEBOOK_APPID];
	// if the app is going away, we close the session object; this is a good idea because
	// things may be hanging off the session, that need releasing (completion block, etc.) and
	// other components in the app may be awaiting close notification in order to do cleanup
	[[FBSession activeSession] close];
}

+ (void)handleDidBecomeActive
{
//    [FBAppEvents activateApp];
    
	[FBSettings setDefaultAppID:FACEBOOK_APPID];
	// We need to properly handle activation of the application with regards to SSO
	//  (e.g., returning from iOS 6.0 authorization dialog or from fast app switching).
    
    [FBAppCall handleDidBecomeActive];
    //	[FBSession.activeSession handleDidBecomeActive];
}

@end