//
//  FacebookManager.h
//  SmartGuide
//
//  Created by XXX on 7/24/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>
#import "OperationFBGetProfile.h"
#import <Social/Social.h>

#define NOTIFICATION_FACEBOOK_USER_GRANTED_PERMISSION @"fbUserGrantedPermission"
#define NOTIFICATION_FACEBOOK_USER_DENIED_PERMISSION @"fbUserDeniedPermission"

enum FACEBOOK_PERMISSION_TYPE {
    FACEBOOK_PERMISSION_DENIED = 0,
    FACEBOOK_PERMISSION_GRANTED = 1
    };

@interface FacebookManager : NSObject

+(FacebookManager*) shareInstance;

+(void) checkFacebookToken;
-(void) login;
-(bool) isLogined;
-(enum FACEBOOK_PERMISSION_TYPE) permissionTypeForPermission:(NSString*) permission;
-(enum FACEBOOK_PERMISSION_TYPE) permissionTypeForPostToWall;

-(void) requestPermission:(NSArray*) permission;
-(void) requestPermissionPostToWall;

+(void) handleDidBecomeActive;
+(void) handleWillTerminate;
+(BOOL)handleOpenURL:(NSURL*)url sourceApplication:(NSString *)sourceApplication annotation:(NSString *)annotation;

@end