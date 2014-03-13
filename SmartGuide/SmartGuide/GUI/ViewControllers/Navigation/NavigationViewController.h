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

@class NavigationViewController;

@protocol NavigationControllerDelegate <SGViewControllerDelegate>

-(void) navigationTouchedUserSetting:(NavigationViewController*) controller;
-(void) navigationTouchedHome:(NavigationViewController*) controller;
-(void) navigationTouchedStore:(NavigationViewController*) controller;
-(void) navigationTouchedPromotion:(NavigationViewController*) controller;
-(void) navigationTouchedTutorial:(NavigationViewController*) controller;

@end

@interface NavigationViewController : SGViewController<UIGestureRecognizerDelegate,LeftControllerCallback>
{
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

-(void) loadData;

@property (nonatomic, assign) id<NavigationControllerDelegate> delegate;
@property (nonatomic, assign) UIView *slideView;

@end
