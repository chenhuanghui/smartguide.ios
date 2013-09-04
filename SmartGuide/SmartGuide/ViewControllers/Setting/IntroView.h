//
//  IntroView.h
//  SmartGuide
//
//  Created by XXX on 8/28/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageControl.h"

@class IntroView;

@protocol IntroViewDelegate <NSObject>

-(void) introViewClose:(IntroView*) introView;

@end

@interface IntroView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UITableView *table;
    __weak IBOutlet PageControl *page;
}

@property (nonatomic, assign) id<IntroViewDelegate> delegate;

@end
