//
//  IntroView.h
//  SmartGuide
//
//  Created by XXX on 8/28/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMGridView.h"

@class IntroView;

@protocol IntroViewDelegate <NSObject>

-(void) introViewClose:(IntroView*) introView;

@end

@interface IntroView : UIView<GMGridViewDataSource>
{
    __weak IBOutlet GMGridView *grid;
}

@property (nonatomic, assign) id<IntroViewDelegate> delegate;

@end
