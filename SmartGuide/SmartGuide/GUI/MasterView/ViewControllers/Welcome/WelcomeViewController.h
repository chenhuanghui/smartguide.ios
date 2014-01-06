//
//  WelcomeViewController.h
//  SmartGuide
//
//  Created by MacMini on 07/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class WelcomeViewController;

@protocol WelcomeControllerDelegate <SGViewControllerDelegate>

-(void) welcomeControllerTouchedLogin:(WelcomeViewController*) viewController;
-(void) welcomeControllerTouchedTry:(WelcomeViewController*) viewController;

@end

@interface WelcomeViewController : SGViewController
{
    __weak IBOutlet UIButton *btnTry;
    __weak IBOutlet UIButton *btnLogin;
}

@property (nonatomic, assign) id<WelcomeControllerDelegate> delegate;

@end
