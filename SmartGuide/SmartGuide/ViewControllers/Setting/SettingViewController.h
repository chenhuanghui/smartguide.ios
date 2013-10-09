//
//  SettingViewController.h
//  SmartGuide
//
//  Created by XXX on 7/17/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ViewController.h"
#import "SwitchSetting.h"
#import "FeedbackView.h"
#import "TutorialView.h"
#import "RootViewController.h"
#import "FrontViewController.h"
#import "ShopDetailViewController.h"
#import "IntroView.h"
#import "ASIOperationGetTotalSP.h"
#import "UpdateVersion.h"
#import "AvatarListView.h"
#import "ASIOperationUpdateUserInfo.h"

@interface SettingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SwitchSettingDelegate,FeedbackViewDelegate,TutorialViewDelegate,IntroViewDelegate,ASIOperationPostDelegate,UpdateVersionDelegate,AvatarListViewDelegate,UITextFieldDelegate>
{
    NSMutableArray *_settings;
    __weak IBOutlet UIImageView *avatar;
//    __weak IBOutlet UILabel *lblSP;
    __weak IBOutlet SwitchSetting *switchLocation;
    __weak IBOutlet UITableView *tableSetting;
    __weak IBOutlet UIView *containAvatar;
    __weak IBOutlet UILabel *lblCity;
    __weak IBOutlet UIView *containView;
    __weak IBOutlet UILabel *lblName;
    __weak IBOutlet UIView *userView;
    __weak IBOutlet UIView *editProfileView;
    __weak IBOutlet UIView *locationView;
    __weak IBOutlet UIView *smartguideView;
    __weak IBOutlet UITextField *txtEditName;
    __weak IBOutlet UIButton *btnEditAvatar;
    __weak IBOutlet UIButton *btnEditCancel;
    __weak IBOutlet UIButton *btnEditUpdate;
    __weak IBOutlet UIView *logoView;
    
    
    bool _lockSlide;
//    ASIOperationGetTotalSP *getTotalSP;
    
    CGRect _rectOrginLocationView;
    CGRect _rectOrginSmartGuideView;
    AvatarListView *avatarList;
    NSString *_selectedAvatarLink;
    bool _isEditingProfile;
    
    float _animationHeight;
}

-(void) loadSetting;
-(bool) isLockSlide;
-(void) onHideSetting;

- (IBAction)btnEditProfileTouchUpInside:(id)sender;
- (IBAction)btnEditAvatarTouchUpInside:(id)sender;
- (IBAction)btnEditCancelTouchUpInside:(id)sender;
- (IBAction)btnEditUpdateTouchUpInside:(id)sender;


@end