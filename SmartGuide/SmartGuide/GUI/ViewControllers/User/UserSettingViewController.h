//
//  SGUserSettingViewController.h
//  SmartGuide
//
//  Created by MacMini on 19/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "SGNavigationController.h"
#import "AvatarViewController.h"
#import "ASIOperationUpdateUserProfile.h"
#import "ASIOperationUserProfile.h"
#import "ASIOperationUploadSocialProfile.h"
#import "OperationFBGetProfile.h"
#import "OperationGPGetUserProfile.h"

@class UserSettingViewController;

@protocol SGUserSettingControllerDelegate <SGViewControllerDelegate>

-(void) userSettingControllerFinished:(UserSettingViewController*) controller;
-(void) userSettingControllerTouchedSetting:(UserSettingViewController*) controller;

@end

@interface UserSettingViewController : SGViewController
{
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet UIButton *btnDone;
    __weak IBOutlet UIButton *btnSetting;
    __weak IBOutlet TPKeyboardAvoidingScrollView *scroll;
    __weak IBOutlet UIImageView *imgvBGAvatar;
    __weak IBOutlet UIButton *btnAvatar;
    __weak IBOutlet UIImageView *imgvAvatar;
    __weak IBOutlet UITextField *txtName;
    __weak IBOutlet UILabel *lblDOB;
    __weak IBOutlet UIButton *btnEditDOB;
    __weak IBOutlet UILabel *lblGender;
    __weak IBOutlet UIButton *btnEditGender;
    __weak IBOutlet UIButton *btnLogout;
    __weak IBOutlet UIView *contentView;
    __weak IBOutlet UIView *titleView;
    __weak IBOutlet UIView *backView;
    __weak IBOutlet UIButton *btnBack;
    __weak IBOutlet UIButton *btnFB;
    __weak IBOutlet UIButton *btnGP;
    __weak IBOutlet UIButton *btnCover;
    
    IBOutlet SGNavigationController *_navi;
    __weak AvatarViewController *_avatarController;
    NSDate *_selectedDate;
    NSMutableArray *_avatars;
    UIImage *_avatarImage;
    NSString *_selectedAvatar;
    
    __weak UIView *_pickerView;
    int _selectedGender;
    ASIOperationUpdateUserProfile *_operationUpdateUserProfile;
    ASIOperationUserProfile *_operationUserProfile;
    ASIOperationUploadSocialProfile *_operationUploadSocialProfile;
    OperationFBGetProfile *_operationFBGetProfile;
    OperationGPGetUserProfile *_operationGPGetUserProfile;
    NSString *_accessToken;
}

@property (nonatomic, weak) id<SGUserSettingControllerDelegate> delegate;

@end
