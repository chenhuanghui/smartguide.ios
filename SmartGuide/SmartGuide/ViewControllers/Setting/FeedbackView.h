//
//  FeedbackView.h
//  SmartGuide
//
//  Created by XXX on 8/27/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIOperationGetFeedback.h"
#import "Feedback.h"

@class FeedbackView;

@protocol FeedbackViewDelegate <NSObject>

-(void) feedbackViewBack:(FeedbackView*) feedbackView;

@end

@interface FeedbackView : UIView<ASIOperationPostDelegate,UITextFieldDelegate>
{
    __weak IBOutlet UITextField *txt;
    __weak IBOutlet UILabel *lblName;
    __weak IBOutlet UIButton *btnFeedback;
    NSMutableArray *_feedbacks;
    
    ASIOperationGetFeedback *feedback;
}

@property (nonatomic, assign) id<FeedbackViewDelegate> delegate;

@end
