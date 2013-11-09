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
    
}

- (IBAction)btnTryTouchUpInside:(id)sender;
- (IBAction)btnLoginTouchUpInside:(id)sender;

@property (nonatomic, assign) id<WelcomeControllerDelegate> delegate;

@end
