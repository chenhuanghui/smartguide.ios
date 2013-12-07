//
//  SGUserViewController.h
//  SmartGuide
//
//  Created by MacMini on 19/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "SGNavigationController.h"

@interface SGUserViewController : SGViewController
{
    __weak IBOutlet UIView *topView;
    __weak IBOutlet UIView *midView;
    __weak IBOutlet UIView *botView;
    IBOutlet SGNavigationController *midNavigation;
    __weak IBOutlet SGViewController *emptyViewController;
}

@end
