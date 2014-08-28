//
//  NavigationController.h
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationController : UINavigationController

-(void) setRootViewController:(UIViewController*) controller;

@end

@interface NavigationController(PushBlock)

-(void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void(^)()) onCompleted;

@end