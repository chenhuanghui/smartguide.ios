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

@class SGLoadingScreenViewController;

@protocol SGLoadingScreenDelegate <SGViewControllerDelegate>

-(void) SGLoadingFinished:(SGLoadingScreenViewController*) loadingScreen;

@end

@interface SGLoadingScreenViewController : SGViewController<OperationURLDelegate>
{
    OperationNotifications *_notification;
}

@property (nonatomic, weak) id<SGLoadingScreenDelegate> delegate;

@end
