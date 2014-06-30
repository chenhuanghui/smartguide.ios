//
//  UserNotificationController.h
//  Infory
//
//  Created by XXX on 6/30/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class SGNavigationController;

@interface UserNotificationController : SGViewController
{
    __weak IBOutlet UIView *contentView;
    __weak IBOutlet UIButton *btnBack;
    __weak IBOutlet UILabel *lblTitle;
    __strong SGNavigationController *_navi;
    
    NSNumber *_idSender;
}

-(UserNotificationController*) initWithIDSender:(NSNumber*) idSender;

@end