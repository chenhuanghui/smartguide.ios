//
//  TutorialViewController.h
//  SmartGuide
//
//  Created by MacMini on 07/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class TutorialViewController;

@protocol TutorialDelegate <NSObject>

-(void) tutorialTouchedBack:(TutorialViewController*) controller;

@end

@interface TutorialViewController : SGViewController

@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (nonatomic, weak) id<TutorialDelegate> delegate;

@end
