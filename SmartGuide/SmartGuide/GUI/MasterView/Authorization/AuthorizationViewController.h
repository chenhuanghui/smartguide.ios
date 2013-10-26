//
//  AuthorizationViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserLoginViewController.h"
#import "UserFacebookViewController.h"
#import "DataManager.h"
#import "Flags.h"
#import "TokenManager.h"
#import "NavigationViewController.h"

@protocol AuthorizationDelegate <UINavigationControllerDelegate>

-(void) authorizationSuccess;

@end

@interface AuthorizationViewController : UINavigationController<UserLoginDelegate,UserFacebookDelegate>

-(AuthorizationViewController*) initAuthorazion;
+(bool) isNeedAuthoration;

@property (nonatomic, assign) id<AuthorizationDelegate> delegate;

@end
