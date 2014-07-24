//
//  RevealViewController.h
//  Infory
//
//  Created by XXX on 7/24/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class RevealViewController;

@protocol RevealControllerDelegate <SGViewControllerDelegate>

-(void) revealControllerWillDisplayRearView:(RevealViewController*) controlelr;

@end

@interface RevealViewController : SGViewController

-(RevealViewController*) initWithFrontController:(UIViewController*) frontControlelr rearController:(UIViewController*) rearController;

-(void) showRearController:(bool) animate;
-(void) showFrontController:(bool) animate;

@property (nonatomic, weak) UIViewController *rearController;
@property (nonatomic, weak) UIViewController *frontController;
@property (nonatomic, weak) id<RevealControllerDelegate> delegate;

@end
