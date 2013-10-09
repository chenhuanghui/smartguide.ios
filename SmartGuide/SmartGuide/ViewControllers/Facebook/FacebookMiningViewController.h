//
//  FacebookMiningViewController.h
//  SmartGuide
//
//  Created by XXX on 7/24/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ViewController.h"
#import "OperationFBGetProfile.h"
#import "ASIOperationFBProfile.h"
#import "FacebookManager.h"
#import "ASIOperationUpdateUserInfo.h"
#import "CreateUserView.h"

@interface FacebookMiningViewController : ViewController<OperationURLDelegate,ASIOperationPostDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UIActionSheetDelegate>
{
    __weak IBOutlet UIButton *btnFace;
    __weak IBOutlet UIButton *btnCreate;
    __weak IBOutlet UIView *containtView;
    
    ASIOperationFBProfile *postProfile;
    OperationFBGetProfile *getProfile;
    bool _isUserChangedAvatar;
    bool _isRequestingProfileFB;
    
    bool _isUploadedFBToken;
    bool _isGettedProfile;
}

- (IBAction)btnFaceTouchUpInside:(id)sender;
- (IBAction)btnCreateTouchUpInside:(id)sender;

@end
