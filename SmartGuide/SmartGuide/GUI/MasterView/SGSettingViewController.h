//
//  SGSettingViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "Constant.h"

@class SGSettingViewController;

@protocol SGSettingDelegate <SGViewControllerDelegate>

-(void) settingTouchedUser:(SGSettingViewController*) controller;
-(void) settingTouchedUserSetting:(SGSettingViewController*) controller;
-(void) settingTouchedCatalog:(SGSettingViewController*) controller;
-(void) settingTouchedNotification:(SGSettingViewController*) controller;
-(void) settingTouchedOtherView:(SGSettingViewController*) controller;

@end

@interface SGSettingViewController : SGViewController<UIGestureRecognizerDelegate>
{
    __weak IBOutlet UIButton *btnUser;
    __weak IBOutlet UIButton *btnCatalog;
    __weak IBOutlet UIView *containtView;
}

- (IBAction)btnUserTouchUpInside:(id)sender;
- (IBAction)btnCatalogTouchUpInside:(id)sender;


@property (nonatomic, assign) id<SGSettingDelegate> delegate;
@property (nonatomic, assign) UIView *slideView;

@end
