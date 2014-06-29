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
#import "RegisterViewController.h"
#import "DataManager.h"
#import "Flags.h"
#import "TokenManager.h"
#import "AvatarViewController.h"

@interface AuthorizationViewController : SGViewController<UserLoginDelegate,RegisterControllerDelegate>
{
    __strong SGNavigationController *authorNavi;
    __weak IBOutlet UIView *containView;
}

@property (nonatomic, weak) id<AuthorizationDelegate> delegate;

@end
