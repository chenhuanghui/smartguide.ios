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
    [UIView animateWithDuration:0.15f animations:^{
        lblName.alpha=0;
        txt.alpha=0;
    } completion:^(BOOL finished) {
        if(!txt.isEditing)
            lblName.text=[NSString stringWithFormat:@"%@",fb.idUser];
        
        txt.placeholder=[NSString stringWithFormat:@"\" %@ \"", fb.content];
        
        [UIView animateWithDuration:0.15f animations:^{
            lblName.alpha=1;
            txt.alpha=1;
        } completion:^(BOOL finished) {
            [self performSelector:@selector(applyRandomFeedBack) withObject:nil afterDelay:3];
        }];
    }];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(applyRandomFeedBack) object:nil];
    
    lblName.text=[DataManager shareInstance].currentUser.name;
    
    return true;
}

-(void) applyRandomFeedBack
{
    [self applyFeedback:[self randomFeedback]];
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    __block __weak id obj = [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
       
        [self applyFeedback:[self randomFeedback]];
        
        [[NSNotificationCenter defaultCenter] removeObserver:obj];
    }];
    
    [self endEditing:true];
}

@end
