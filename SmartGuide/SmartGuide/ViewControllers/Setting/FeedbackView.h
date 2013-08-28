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
    __weak IBOutlet UITextView *txt;
    __weak IBOutlet UILabel *lblName;
    __weak IBOutlet UIButton *btnFeedback;
    NSMutableArray *_feedbacks;
    
    bool _isEditing;
    ASIOperationGetFeedback *feedback;
}

@property (nonatomic, assign) id<FeedbackViewDelegate> delegate;

@end

@interface TextFieldFeedBack : UITextField

@end