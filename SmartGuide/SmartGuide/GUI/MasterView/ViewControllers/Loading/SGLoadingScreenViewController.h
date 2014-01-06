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

@class SGLoadingScreenViewController;

@protocol SGLoadingScreenDelegate <SGViewControllerDelegate>

-(void) SGLoadingFinished:(SGLoadingScreenViewController*) loadingScreen;

@end

@interface SGLoadingScreenViewController : SGViewController<OperationURLDelegate,ASIOperationPostDelegate>
{
    OperationNotifications *_notification;
    ASIOperationUserProfile *_operationUserProfile;
}

@property (nonatomic, weak) id<SGLoadingScreenDelegate> delegate;

@end
