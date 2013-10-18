//
//  LoadingScreenViewController.h
//  SmartGuide
//
//  Created by XXX on 8/23/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ViewController.h"

@interface LoadingScreenViewController : ViewController
{
    __weak IBOutlet UIImageView *imgvDefault;
}

@property (nonatomic, assign) bool isNeedRemove;
@property (nonatomic, readonly) bool isAnimationFinished;

@end
