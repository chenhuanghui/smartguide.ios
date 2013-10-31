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
#import "SGActivityIndicator.h"

@interface SGViewController : UIViewController

-(NSArray*) registerNotifications;
-(void) receiveNotification:(NSNotification*) notification;

@end
