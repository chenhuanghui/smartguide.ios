//
//  404ViewController.h
//  Infory
//
//  Created by XXX on 8/7/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGViewController.h"

@class NotFound404ViewController;

@protocol NotFound404ViewControllerDelegate <SGViewControllerDelegate>

-(void) notFound404ControllerTouchedBack:(NotFound404ViewController*) controller;

@end

@interface NotFound404ViewController : SGViewController

@property (nonatomic, weak) id<NotFound404ViewControllerDelegate> delegate;

@end

@interface SGViewController(NotFound404ViewController)<NotFound404ViewControllerDelegate>

-(void) show404;

@end