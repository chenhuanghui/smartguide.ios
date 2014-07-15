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
#import "AlertView.h"

static FacebookManager *_facebookManager=nil;
@implementation FacebookManager

+(void)load
{
    if([FBSession openActiveSessionWithAllowLoginUI:false])
        [FBSession setActiveSession:nil];
}

+(FacebookManager *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _facebookManager=[[FacebookManager alloc] init];
    });
    
    return _facebookManager;
}

-(void)logout
{
    [[FBSession activeSession] closeAndClearTokenInformation];
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
    return [[FBSession activeSession] isOpen];
}

-(bool) isAvailableSocialFramework
{
    return NSClassFromString(@"SLComposeViewController")!=nil;
}

-(bool) isAvailableSystemAccount
{
    return [self isAvailableSocialFramework] && [SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook];
}

-(void) requestPermission:(NSArray *)permission
{
    __block NSArray *_per=[permission copy];
    
    [[FBSession activeSession] requestNewPublishPermissions:permission defaultAudience:FBSessionDefaultAudienceEveryone completionHandler:^(FBSession *session, NSError *error) {
        if(error)
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_USER_DENIED_PERMISSION object:_per];
        else
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_USER_GRANTED_PERMISSION object:_per];
    }];
}

-(void)requestPermission:(NSArray *)permission onCompleted:(void (^)(enum FACEBOOK_PERMISSION_TYPE))completed
{
    __block id obsGranted=nil;
    __block id obsDenied=nil;
    __block NSArray *_permission=[permission copy];
    __block void(^_completed)(enum FACEBOOK_PERMISSION_TYPE)=[completed copy];
    
    obsGranted=[[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_FACEBOOK_USER_GRANTED_PERMISSION object:nil queue:[NSOperationQueue currentQueue] usingBlock:^(NSNotification *note) {
        
        if(note.object && [note.object isKindOfClass:[NSArray class]])
        {
            NSArray *array=note.object;
            
            if([array isEqualToArray:_permission])
            {
                [[NSNotificationCenter defaultCenter] removeObserver:obsGranted];
                [[NSNotificationCenter defaultCenter] removeObserver:obsDenied];
                
                _completed(FACEBOOK_PERMISSION_GRANTED);
                _completed=nil;
            }
        }
    }];
    
    obsDenied=[[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_FACEBOOK_USER_DENIED_PERMISSION object:nil queue:[NSOperationQueue currentQueue] usingBlock:^(NSNotification *note) {
        
        if(note.object && [note.object isKindOfClass:[NSArray class]])
        {
            NSArray *array=note.object;
            
            if([array isEqualToArray:_permission])
            {
                [[NSNotificationCenter defaultCenter] removeObserver:obsGranted];
                [[NSNotificationCenter defaultCenter] removeObserver:obsDenied];
                
                _completed(FACEBOOK_PERMISSION_DENIED);
                _completed=nil;
            }
        }
    }];
    
    [self requestPermission:permission];
}

-(void) requestPermissionPostToWall
{
    [self requestPermission:FACEBOOK_PUBLISH_PERMISSION];
}

-(void)requestPermissionPostToWallOnCompleted:(void (^)(enum FACEBOOK_PERMISSION_TYPE))completed
{
    [self requestPermission:FACEBOOK_PUBLISH_PERMISSION onCompleted:completed];
}

- (void)openSession{
    if([self isAvailableSystemAccount])
    {
        __block id obsGranted=nil;
        __block id obsDenied=nil;
        
        obsGranted=[[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_FACEBOOK_LOGIN_SUCCESS object:nil queue:[NSOperationQueue currentQueue] usingBlock:^(NSNotification *note) {
            
            [[NSNotificationCenter defaultCenter] removeObserver:obsGranted];
            [[NSNotificationCenter defaultCenter] removeObserver:obsDenied];
        }];
        
        obsDenied=[[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_FACEBOOK_LOGIN_FAILED object:nil queue:[NSOperationQueue currentQueue] usingBlock:^(NSNotification *note) {
            
            [[FBSession activeSession] closeAndClearTokenInformation];
            
            [[NSNotificationCenter defaultCenter] removeObserver:obsGranted];
            [[NSNotificationCenter defaultCenter] removeObserver:obsDenied];
        }];
        
        [FBSession openActiveSessionWithReadPermissions:FACEBOOK_READ_PERMISSION allowLoginUI:true completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
            
            if(error)
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_LOGIN_FAILED object:error];
            else
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_LOGIN_SUCCESS object:nil];
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
                
                if([session.permissions containsObject:FACEBOOK_POST_TO_WALL_PERMISSION])
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_USER_GRANTED_PERMISSION object:FACEBOOK_POST_TO_WALL_PERMISSION];
                else
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_USER_DENIED_PERMISSION object:FACEBOOK_POST_TO_WALL_PERMISSION];
                
                return;
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_LOGIN_FAILED object:error];
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
    [FBAppEvents activateApp];
    
	[FBSettings setDefaultAppID:FACEBOOK_APPID];
	// We need to properly handle activation of the application with regards to SSO
	//  (e.g., returning from iOS 6.0 authorization dialog or from fast app switching).
    
    [FBAppCall handleDidBecomeActive];
    //	[FBSession.activeSession handleDidBecomeActive];
}

-(enum FACEBOOK_PERMISSION_TYPE)permissionTypeForPermission:(NSString *)permission
{
    if([self permissionIsNeedRequest:permission])
        return FACEBOOK_PERMISSION_DENIED;
    
    if([[FBSession activeSession].permissions containsObject:permission])
        return FACEBOOK_PERMISSION_GRANTED;
    
    return FACEBOOK_PERMISSION_DENIED;
}

-(enum FACEBOOK_PERMISSION_TYPE)permissionTypeForPostToWall
{
    return [self permissionTypeForPermission:FACEBOOK_POST_TO_WALL_PERMISSION];
}

-(bool) permissionIsNeedRequest:(NSString*) permission
{
    return [_needPermission containsObject:permission];
}

-(void)markNeedPermissionPostToWall
{
    if(!_needPermission)
        _needPermission=[NSMutableArray new];
    
    if(![_needPermission containsObject:FACEBOOK_POST_TO_WALL_PERMISSION])
        [_needPermission addObject:FACEBOOK_POST_TO_WALL_PERMISSION];
}

-(void)clean
{
    if([[FBSession activeSession] isOpen])
    {
        [[FBSession activeSession] closeAndClearTokenInformation];
    }
}

@end

@implementation FacebookManager(Share)

-(void)shareLink:(NSURL *)url
{
    if(url)
    {
        [FBDialogs presentShareDialogWithLink:url handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
            if(error)
            {
                [AlertView showAlertOKWithTitle:@"Thông báo" withMessage:[error description] onOK:nil];
            }
            else
            {
                
            }
        }];
    }
}

@end