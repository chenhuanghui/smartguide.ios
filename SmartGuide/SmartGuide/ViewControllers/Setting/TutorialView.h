//
//  TutorialView.h
//  SmartGuide
//
//  Created by XXX on 8/27/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TutorialView;

@protocol TutorialViewDelegate <NSObject>

-(void) tutorialViewBack:(TutorialView*) tutorial;

@end

@interface TutorialView : UIView
{
    NSArray *_tutorials;
    __weak IBOutlet UIImageView *imgv;
    __weak IBOutlet UIButton *btnNext;
    int _page;
    
    UIButton *btn;
    
    __weak IBOutlet UIButton *btnBack;
    __weak IBOutlet UIButton *btnFind;
    __weak IBOutlet UIButton *btnReward;
}

@property (nonatomic, assign) id<TutorialViewDelegate> delegate;

@end
