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

@interface FacebookManager : NSObject

+(FacebookManager*) shareInstance;

+(void) checkFacebookToken;
-(void) login;
-(bool) isLogined;

+(void) handleDidBecomeActive;
+(void) handleWillTerminate;
+(BOOL)handleOpenURL:(NSURL*)url sourceApplication:(NSString *)sourceApplication annotation:(NSString *)annotation;

@end