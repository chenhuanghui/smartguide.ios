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

-(void) settingTouchedUser:(SGSettingViewController*) settingController;
-(void) settingTouchedCatalog:(SGSettingViewController*) settingController;

@end

@interface SGSettingViewController : SGViewController<UIGestureRecognizerDelegate>
{
    __weak IBOutlet UIButton *btnUser;
    __weak IBOutlet UIButton *btnCatalog;
}

- (IBAction)btnUserTouchUpInside:(id)sender;
- (IBAction)btnCatalogTouchUpInside:(id)sender;


@property (nonatomic, assign) id<SGSettingDelegate> delegate;
@property (nonatomic, assign) UIView *slideView;

@end
