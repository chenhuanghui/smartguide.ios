//
//  UserLoginViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "OperationGetActionCode.h"
#import "OperationVerifyActiveCode.h"
#import "OperationGetToken.h"
#import "TokenManager.h"
#import "Flags.h"

@protocol UserLoginDelegate <SGViewControllerDelegate>

-(void) userLoginSuccessed;
-(void) userLoginCancelled;

@end

@interface UserLoginViewController : SGViewController<OperationURLDelegate,UITextFieldDelegate>
{
    __weak IBOutlet UIImageView *imgvLogo;
    __weak IBOutlet UIImageView *smartguide;
    __weak IBOutlet UIButton *btnDone;
    __weak IBOutlet UILabel *lblInfo;
    __weak IBOutlet UITextField *txt;
    
    
    bool _isActived;
    NSString *_phone;
    
    NSString *_inputPhone;
    NSTimer *_timerSMS;
    __weak IBOutlet UILabel *lblCountdown;
    __weak IBOutlet UILabel *lblGiay;
    __weak IBOutlet UILabel *lblResend;
    __weak IBOutlet UIButton *btnResent;
    int _time;
    
    int _idUser;
    NSString *_name;
    bool _isConnectedFacebook;
    NSString *_avatar;
}

@property (nonatomic, assign) id<UserLoginDelegate> delegate;

@end
