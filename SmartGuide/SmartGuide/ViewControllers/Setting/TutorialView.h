//
//  TutorialView.h
//  SmartGuide
//
//  Created by XXX on 8/27/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageControl.h"
#import "TutorialCell.h"

@class TutorialView;

@protocol TutorialViewDelegate <NSObject>

-(void) tutorialViewBack:(TutorialView*) tutorial;

@end

@interface TutorialView : UIView<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,PageControlDelegate>
{
    NSArray *_tutorials;
    __weak IBOutlet UIImageView *imgvTutorial;
    __weak IBOutlet UITableView *table;
    __weak IBOutlet PageControl *pageControl;
    
    __weak IBOutlet UIButton *btnBack;
}

@property (nonatomic, assign) id<TutorialViewDelegate> delegate;
@property (nonatomic, assign) bool isHideClose;

@end
