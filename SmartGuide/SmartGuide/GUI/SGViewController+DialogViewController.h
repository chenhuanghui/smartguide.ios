//
//  SGViewController+DialogViewController.h
//  Infory
//
//  Created by XXX on 7/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"

@interface UIViewController(DialogViewController)

@property (nonatomic, strong) SGViewController *dialogController;

-(void) showDialogController:(SGViewController*) dialogController withAnimation:(BasicAnimation*) animation onCompleted:(void(^)(SGViewController* controller))completed;
-(void) closeDialogControllerWithAnimation:(BasicAnimation*) animation onCompleted:(void(^)(SGViewController* controller)) completed;

-(BasicAnimation*) dialogControllerDefaultAnimationShow;
-(BasicAnimation*) dialogControllerDefaultAnimationClose;

@end
