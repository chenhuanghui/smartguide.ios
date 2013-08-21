//
//  NavigationViewController.h
//  SmartGuide
//
//  Created by XXX on 7/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

enum NAVI_TYPE {
    NAVY_POP = 0,
    NAVY_PUSH = 1,
    };

@interface NavigationViewController : UINavigationController

@property (nonatomic, assign) id<NavigationViewControllerDelegate> delegate;
@property (nonatomic, readonly) enum NAVI_TYPE naviType;


@end