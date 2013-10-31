//
//  UserFacebookViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "OperationFBGetProfile.h"
#import "ASIOperationFBProfile.h"
#import "FacebookManager.h"
#import "ASIOperationUpdateUserInfo.h"
#import "CreateUserView.h"

@protocol UserFacebookDelegate <NSObject>

-(void) userFacebookSuccessed;

@end

@interface UserFacebookViewController : SGViewController<OperationURLDelegate,ASIOperationPostDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UIActionSheetDelegate,CreateUserDelegate>
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

@property (nonatomic, assign) id<UserFacebookDelegate> delegate;

@end
