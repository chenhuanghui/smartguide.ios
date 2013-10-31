//
//  AuthorizationViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGNavigationViewController.h"
#import "UserLoginViewController.h"
#import "UserFacebookViewController.h"
#import "DataManager.h"
#import "Flags.h"
#import "TokenManager.h"
#import "NavigationViewController.h"

@protocol AuthorizationDelegate <UINavigationControllerDelegate>

-(void) authorizationSuccessed;
-(void) authorizationCancelled;

@end

@interface AuthorizationViewController : SGNavigationViewController<UserLoginDelegate,UserFacebookDelegate>

-(void) showLogin;
-(void) showCreateUser;
+(bool) isNeedFillInfo;

@property (nonatomic, assign) id<AuthorizationDelegate> delegate;

@end
