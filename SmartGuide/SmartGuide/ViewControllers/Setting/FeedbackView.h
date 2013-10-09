//
//  FeedbackView.h
//  SmartGuide
//
//  Created by XXX on 8/27/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIOperationGetFeedback.h"
#import "ASIOperationPostFeedback.h"
#import "Feedback.h"
#import "ActivityIndicator.h"

@class FeedbackView,TextFieldFeedBack;

@protocol FeedbackViewDelegate <NSObject>

-(void) feedbackViewBack:(FeedbackView*) feedbackView;

@end

@interface FeedbackView : UIView<ASIOperationPostDelegate,UITextViewDelegate>
{
    __weak IBOutlet UITextView *txtInput;
    __weak IBOutlet UITextView *txtFeedBack;
    __weak IBOutlet UILabel *lblUserFeedback;
    __weak IBOutlet UIButton *btnFeedback;
    __weak IBOutlet UILabel *lblUser;
    __weak IBOutlet UIView *loadingView;
    NSMutableArray *_feedbacks;
    
    bool _isEditing;
    ASIOperationGetFeedback *feedback;
}

@property (nonatomic, assign) id<FeedbackViewDelegate> delegate;

@end