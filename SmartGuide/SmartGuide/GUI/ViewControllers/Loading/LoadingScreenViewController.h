//
//  SGLoadingScreenViewController.h
//  SmartGuide
//
//  Created by MacMini on 31/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGViewController.h"

@class LoadingScreenViewController;

@protocol SGLoadingScreenDelegate <SGViewControllerDelegate>

-(void) SGLoadingFinished:(LoadingScreenViewController*) loadingScreen;

@end

@interface LoadingScreenViewController : SGViewController
{
    __weak IBOutlet UIImageView *imgv;
}

@property (nonatomic, weak) id<SGLoadingScreenDelegate> delegate;

@end
