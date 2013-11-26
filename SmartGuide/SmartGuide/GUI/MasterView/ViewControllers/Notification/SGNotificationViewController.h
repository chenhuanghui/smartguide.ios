//
//  SGNotificationViewController.h
//  SmartGuide
//
//  Created by MacMini on 19/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class SGNotificationViewController;

@protocol NotificationControllerDelegate <SGViewControllerDelegate>

-(void) notificationControllerTouchedBack:(SGNotificationViewController*) controller;

@end

@interface SGNotificationViewController : SGViewController

@property (nonatomic, weak) id<NotificationControllerDelegate> delegate;

@end
