//
//  SGViewController.h
//  SmartGuide
//
//  Created by MacMini on 28/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "Utility.h"
#import "LocalizationManager.h"
#import "AlertView.h"
#import "ImageManager.h"
#import "LoadingView.h"
#import "Flags.h"
#import "AlphaView.h"

@class SGViewController,SGNavigationController;

@protocol SGViewControllerDelegate <NSObject>

@optional
-(void) SGControllerLoadView:(SGViewController*) sgController;
-(void) SGControllerDidLoadView:(SGViewController*) sgController;

@end

@protocol SGViewControllerHandle <NSObject>

-(void) navigationController:(SGNavigationController*) navigationController willPopController:(SGViewController*) controller;

@end

@interface SGViewController : UIViewController<SGViewControllerHandle>

-(id) initWithDelegate:(id<SGViewControllerDelegate>) delegate;

-(NSArray*) registerNotifications;
-(void) receiveNotification:(NSNotification*) notification;

@property (nonatomic, assign) id<SGViewControllerDelegate> delegate;

@end