//
//  FeedbackView.m
//  SmartGuide
//
//  Created by XXX on 8/27/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "FeedbackView.h"

@implementation FeedbackView
@synthesize delegate;

-(id)init
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"FeedbackView" owner:nil options:nil] objectAtIndex:0];
    
    txt.text=@"";
    txt.placeholder=@"";
    lblName.text=@"";
    
    feedback=[[ASIOperationGetFeedback alloc] initFeedback];
    feedback.delegatePost=self;
    
    [feedback startAsynchronous];
    
    return self;
}

- (IBAction)btnFeedbackTouchUpInside:(id)sender {
}

- (IBAction)btnBackTouchUpInside:(id)sender {
    [delegate feedbackViewBack:self];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationGetFeedback class]])
    {
        ASIOperationGetFeedback *fb=(ASIOperationGetFeedback*) operation;
        
        _feedbacks=[[NSMutableArray alloc] initWithArray:fb.feedbacks];
        
        [self applyFeedback:[self randomFeedback]];
        
        feedback=nil;
    }
}

-(void) applyFeedback:(Feedback*) fb
{
    if(!txt.isEditing)
    {
        lblName.text=[NSString stringWithFormat:@"%@",fb.idUser];
    }
    
    txt.placeholder=[NSString stringWithFormat:@"\" %@ \"", fb.content];
}

-(Feedback*) randomFeedback
{
    if(_feedbacks.count==0)
        return nil;
    
    int rd=arc4random()%(_feedbacks.count);
    
    while (rd>=_feedbacks.count) {
        rd=arc4random()%(_feedbacks.count);
    }
    
    return [_feedbacks objectAtIndex:rd];
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    feedback=nil;
}

-(void)removeFromSuperview
{
    [super removeFromSuperview];
    
    if(feedback)
    {
        feedback.delegatePost=nil;
        [feedback cancel];
        feedback=nil;
    }
}

@end
