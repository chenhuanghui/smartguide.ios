//
//  SGSettingViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "Constant.h"
#import "SGNavigationController.h"

@class SGSettingViewController;

@protocol SGSettingDelegate <SGViewControllerDelegate>

-(void) settingTouchedUser:(SGSettingViewController*) controller;
-(void) settingTouchedUserSetting:(SGSettingViewController*) controller;
-(void) settingTouchedCatalog:(SGSettingViewController*) controller;
-(void) settingTouchedStore:(SGSettingViewController*) controller;
-(void) settingTouchedOtherView:(SGSettingViewController*) controller;
-(void) settingTouchedPromotion:(SGSettingViewController*) controller;

@end

@interface SGSettingViewController : SGViewController<UIGestureRecognizerDelegate,LeftControllerCallback>
{
    __weak IBOutlet UIButton *btnUser;
    __weak IBOutlet UIButton *btnCatalog;
    __weak IBOutlet UIButton *btnPromotion;
    __weak IBOutlet UIView *containtView;
    __weak IBOutlet UILabel *lblName;
    __weak IBOutlet UIButton *btnUserSetting;
    __weak IBOutlet UIImageView *imgvAvatar;
    __weak IBOutlet UIImageView *imgvBGAvatar;
    __weak IBOutlet UIButton *btnHome;
    __weak IBOutlet UIButton *btnStore;
    __weak IBOutlet UIButton *btnTutorial;
}

@property (nonatomic, assign) id<SGSettingDelegate> delegate;
@property (nonatomic, assign) UIView *slideView;

@end
