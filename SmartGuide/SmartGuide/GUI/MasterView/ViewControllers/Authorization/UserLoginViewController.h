//
//  UserLoginViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "OperationGetActionCode.h"
#import "ASIOperationUserCheck.h"
#import "TokenManager.h"
#import "Flags.h"

@protocol UserLoginDelegate <SGViewControllerDelegate>

-(void) userLoginSuccessed;
-(void) userLoginCancelled;

@end

@interface UserLoginViewController : SGViewController<OperationURLDelegate,ASIOperationPostDelegate,UITextFieldDelegate>
{
    __weak IBOutlet UIButton *btnLogin;
    __weak IBOutlet UITextField *txtPhone;
    
    OperationGetActionCode *_operationGetActionCode;
    ASIOperationUserCheck *_operationUserCheck;
    NSString *_activationCode;
    NSString *_phone;
}

@property (nonatomic, assign) id<UserLoginDelegate> delegate;

@end
