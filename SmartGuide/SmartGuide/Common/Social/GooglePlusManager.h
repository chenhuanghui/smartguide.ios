//
//  GooglePlusManager.h
//  SmartGuide
//
//  Created by MacMini on 08/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GooglePlus/GooglePlus.h>
#import <GoogleOpenSource/GoogleOpenSource.h>

@interface GooglePlusManager : NSObject

+(GooglePlusManager*) shareInstance;

-(GPPSignIn*) gppSignIn;

@property (nonatomic, strong) GTMOAuth2Authentication *authentication;

@end

@interface GooglePlusManager(Share)<GPPSignInDelegate,GPPShareDelegate>

@property (nonatomic, strong, readwrite) NSURL *urlToShare;

-(void) shareLink:(NSURL*) url;

@end