//
//  SGLoadingScreenViewController.h
//  SmartGuide
//
//  Created by MacMini on 31/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGViewController.h"

@class SGLoadingScreenViewController;

@protocol SGLoadingScreenDelegate <NSObject>

-(void) SGLoadingFinished:(SGLoadingScreenViewController*) loadingScreen;

@end

@interface SGLoadingScreenViewController : SGViewController
{
    bool _isDidAppear;
}

@property (nonatomic, weak) id<SGLoadingScreenDelegate> delegate;

@end
