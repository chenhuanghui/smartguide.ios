//
//  UserLoginViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "FTCoreTextView.h"

@class AuthorizationViewController;

@protocol UserLoginDelegate <SGViewControllerDelegate>

-(void) userLoginSuccessed;
-(void) userLoginCancelled;

@end

@interface UserLoginViewController : SGViewController
{
    __weak IBOutlet UIButton *btnLogin;
    __weak IBOutlet UITextField *txtPhone;
    __weak IBOutlet UILabel *lblTop;
    __weak IBOutlet FTCoreTextView *lblBottom;
    
    int _countdown;
    
    NSString *_activationCode;
    NSString *_phone;
    
    float _keyboardHeight;
}

@property (nonatomic, assign) id<UserLoginDelegate> delegate;
@property (nonatomic, weak) AuthorizationViewController *authorizationController;

@end
