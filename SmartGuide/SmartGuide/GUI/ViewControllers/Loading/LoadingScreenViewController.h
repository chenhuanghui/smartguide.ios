//
//  SGLoadingScreenViewController.h
//  SmartGuide
//
//  Created by MacMini on 31/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGViewController.h"
#import "OperationNotifications.h"
#import "ASIOperationUserProfile.h"

@class LoadingScreenViewController;

@protocol SGLoadingScreenDelegate <SGViewControllerDelegate>

-(void) SGLoadingFinished:(LoadingScreenViewController*) loadingScreen;

@end

@interface LoadingScreenViewController : SGViewController<OperationURLDelegate,ASIOperationPostDelegate>
{
    OperationNotifications *_notification;
    ASIOperationUserProfile *_operationUserProfile;
    __weak IBOutlet UIImageView *imgv;
    
    bool _viewDidLoad;
    bool _finishedRequestNotification;
    NotificationObject *_notifiObject;
}

@property (nonatomic, weak) id<SGLoadingScreenDelegate> delegate;

@end