//
//  AuthorizationViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGNavigationController.h"
#import "UserLoginViewController.h"
#import "UserFacebookViewController.h"
#import "DataManager.h"
#import "Flags.h"
#import "TokenManager.h"

@protocol AuthorizationDelegate <UINavigationControllerDelegate>

-(void) authorizationSuccessed;
-(void) authorizationCancelled;

@end

@interface AuthorizationViewController : SGNavigationController<UserLoginDelegate,UserFacebookDelegate>

-(void) showLogin;
-(void) showCreateUser;
+(bool) isNeedFillInfo;

@property (nonatomic, assign) id<AuthorizationDelegate> delegate;

@end
