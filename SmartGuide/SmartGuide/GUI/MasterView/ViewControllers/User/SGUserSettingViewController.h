//
//  SGUserSettingViewController.h
//  SmartGuide
//
//  Created by MacMini on 19/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class SGUserSettingViewController;

@protocol SGUserSettingControllerDelegate <SGViewControllerDelegate>

-(void) userSettingControllerTouchedClose:(SGUserSettingViewController*) controller;

@end

@interface SGUserSettingViewController : SGViewController

@property (nonatomic, weak) id<SGUserSettingControllerDelegate> delegate;

@end
