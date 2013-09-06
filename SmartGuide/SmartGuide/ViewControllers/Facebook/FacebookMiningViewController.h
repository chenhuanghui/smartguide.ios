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

@interface FacebookMiningViewController : ViewController<OperationURLDelegate,ASIOperationPostDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UIActionSheetDelegate>
{
    __weak IBOutlet UIButton *btnFace;
    __weak IBOutlet UIView *faceView;
    __weak IBOutlet UIView *infoView;
    __weak IBOutlet UITextField *txtUser;
    __weak IBOutlet UIButton *btnAvatar;
    __weak IBOutlet UIView *borderAvatar;
    
    ASIOperationFBProfile *postProfile;
    OperationFBGetProfile *getProfile;
    bool _isUserChangedAvatar;
}

- (IBAction)btnSkipTouchUpInside:(id)sender;
- (IBAction)btnAvatarTouchUpInside:(id)sender;
- (IBAction)btnDoneTouchUpInside:(id)sender;

@end
