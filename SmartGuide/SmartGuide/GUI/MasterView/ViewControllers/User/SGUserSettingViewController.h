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

@class SGUserSettingViewController;

@protocol SGUserSettingControllerDelegate <SGViewControllerDelegate>

-(void) userSettingControllerFinished:(SGUserSettingViewController*) controller;
-(void) userSettingControllerTouchedSetting:(SGUserSettingViewController*) controller;

@end

@interface SGUserSettingViewController : SGViewController
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
    NSString *_accessToken;
}

@property (nonatomic, weak) id<SGUserSettingControllerDelegate> delegate;

@end
