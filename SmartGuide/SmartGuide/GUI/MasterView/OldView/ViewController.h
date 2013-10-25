//
//  ViewController.h
//  SmartGuide
//
//  Created by XXX on 7/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocalizationManager.h"
#import "ActivityIndicator.h"
#import "AlertView.h"
#import "NSBKeyframeAnimation.h"
#import "NavigationBarView.h"
#import "Constant.h"
#import "Utility.h"

@class FrontViewController;

@interface ViewController : UIViewController<ActivityIndicatorDelegate,NavigationBarDelegate,UIGestureRecognizerDelegate>

-(NSArray*) leftNavigationItems;
-(NSArray*) rightNavigationItems;
-(NSArray*) disableRightNavigationItems;

-(void) configMenu;

-(bool) isModal;

-(NSArray*) registerNotification;
-(void) unregisterNotification;
-(void) receiveNotification:(NSNotification*) notification;
-(void) willPopViewController;

-(bool) allowBannerAds;

-(bool) allowDragPreviousView:(UIPanGestureRecognizer*) pan;

-(FrontViewController*) frontViewController;

@end