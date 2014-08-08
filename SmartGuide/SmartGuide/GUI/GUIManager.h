//
//  GUIManager.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SGViewController.h"
#import "RootViewController.h"

@interface GUIManager : NSObject
{
    void(^_onLoginedCompleted)(bool isLogined);
    CGRect _qrCodeBeforeShowFrame;
}

+(GUIManager*) shareInstance;
-(void) startupWithWindow:(UIWindow*) window;
-(void) logout;

-(void) presentSGViewController:(UIViewController*) controller completion:(void(^)()) completed;
-(void) dismissSGViewControllerCompletion:(void (^)())onCompleted;

-(void) showLoginDialogWithMessage:(NSString*) message onOK:(void(^)()) onOK onCancelled:(void(^)()) onCancelled onLogined:(void(^)(bool isLogined)) onLogin;
-(void) showLoginControll:(void(^)(bool isLogin)) onLogin;
-(void) show404:(void(^)()) onShow onBack:(void(^)()) onBack;

@property (nonatomic, readonly) UIWindow *mainWindow;
@property (nonatomic, strong, readonly) SGNavigationController *rootNavigation;
@property (nonatomic, weak, readonly) RootViewController *rootViewController;
@end