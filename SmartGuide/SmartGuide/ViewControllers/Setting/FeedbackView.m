//
//  FeedbackView.m
//  SmartGuide
//
//  Created by XXX on 8/27/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "FeedbackView.h"
#import "AlertView.h"
#import "Utility.h"

@implementation FeedbackView
@synthesize delegate;

-(id)init
{
    self=[[[NSBundle mainBundle] loadNibNamed:NIB_PHONE(@"FeedbackView") owner:nil options:nil] objectAtIndex:0];
    
    CGPoint pnt=self.center;
    pnt.y+=20;
    self.center=pnt;
    
    txtFeedBack.hidden=false;
    lblUserFeedback.hidden=false;
    
    txtInput.hidden=true;
    lblUser.hidden=true;
    
    txtInput.text=@"";
    txtFeedBack.text=@"";
    lblUserFeedback.text=@"";
    lblUser.text=@"";
    
    lblUser.text=[DataManager shareInstance].currentUser.name;
    
    [loadingView showLoadingWithTitle:nil];
    
    [self loadFeedBack];
    
    return self;
}

-(void) loadFeedBack
{
    if(feedback)
    {
        [feedback cancel];
        feedback=nil;
    }
    
    feedback=[[ASIOperationGetFeedback alloc] initFeedback];
    feedback.delegatePost=self;
    
    [feedback startAsynchronous];
}

- (IBAction)btnFeedbackTouchUpInside:(id)sender {
    //Người dùng muốn feedback
    if(txtInput.hidden)
    {
        btnFeedback.userInteractionEnabled=false;
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(applyRandomFeedBack) object:nil];
        
        [btnFeedback setTitle:@"GỞI" forState:UIControlStateNormal];
        txtInput.editable=true;
        txtInput.alpha=0;
        lblUser.alpha=0;
        txtInput.hidden=false;
        lblUser.hidden=false;
        txtInput.text=@"";
        
        [txtInput becomeFirstResponder];
        
        [UIView animateWithDuration:0.3f animations:^{
            txtInput.alpha=1;
            lblUser.alpha=1;
            txtFeedBack.alpha=0;
            lblUserFeedback.alpha=0;
        } completion:^(BOOL finished) {
            txtFeedBack.hidden=true;
            lblUserFeedback.hidden=true;
            
            btnFeedback.userInteractionEnabled=true;
        }];
    }
    else //Người dùng gữi gửi feedback
    {
        txtInput.editable=false;
        
        if([txtInput.text stringByRemoveString:@" ",nil].length==0)
        {
            [AlertView showAlertOKWithTitle:nil withMessage:@"Vui lòng nhập nội dung đánh giá" onOK:^{
                [txtInput becomeFirstResponder];
            }];
            return;
        }
        
        ASIOperationPostFeedback *post=[[ASIOperationPostFeedback alloc] initWithIDUser:[DataManager shareInstance].currentUser.idUser.integerValue content:txtInput.text];
        
        post.delegatePost=self;
        [post startAsynchronous];
        
        [loadingView showLoadingWithTitle:nil];
    }
}

- (IBAction)btnBackTouchUpInside:(id)sender {
    [delegate feedbackViewBack:self];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationGetFeedback class]])
    {
        [loadingView removeLoading];

        ASIOperationGetFeedback *fb=(ASIOperationGetFeedback*) operation;
        
        _feedbacks=[[NSMutableArray alloc] initWithArray:fb.feedbacks];
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(applyRandomFeedBack) object:nil];
        [self performSelector:@selector(applyRandomFeedBack) withObject:nil afterDelay:0];
        
        [self hideInput];
        
        feedback=nil;
    }
    else if([operation isKindOfClass:[ASIOperationPostFeedback class]])
    {
        [self loadFeedBack];
    }
}

-(void) applyFeedback:(Feedback*) fb
{
    lblUserFeedback.hidden=false;
    txtFeedBack.hidden=false;
    
    [UIView animateWithDuration:0.15f animations:^{
        lblUserFeedback.alpha=0;
        txtFeedBack.alpha=0;
    } completion:^(BOOL finished) {

        lblUserFeedback.text=fb.user;
        txtFeedBack.text=[NSString stringWithFormat:@"‘‘  %@  ’’",fb.content];
        
        [UIView animateWithDuration:0.15f animations:^{
            lblUserFeedback.alpha=1;
            txtFeedBack.alpha=1;
        } completion:^(BOOL finished) {
            if(finished)
                [self performSelector:@selector(applyRandomFeedBack) withObject:nil afterDelay:3];
        }];
    }];
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
    if([operation isKindOfClass:[ASIOperationGetFeedback class]])
        feedback=nil;
    else if([operation isKindOfClass:[ASIOperationPostFeedback class]])
    {
        [self removeLoading];
    }
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
    [self hideInput];
}

-(void) hideInput
{
    if(!txtInput.hidden)
    {
        [txtInput resignFirstResponder];
        [self endEditing:true];
        
        txtInput.editable=false;
        txtFeedBack.alpha=0;
        lblUserFeedback.alpha=0;
        txtFeedBack.hidden=false;
        lblUserFeedback.hidden=false;
        
        [UIView animateWithDuration:0.3f animations:^{
            txtInput.alpha=0;
            lblUser.alpha=0;
            txtFeedBack.alpha=1;
            lblUserFeedback.alpha=1;
        } completion:^(BOOL finished) {
            txtInput.hidden=true;
            lblUser.hidden=true;
            
            [btnFeedback setTitle:@"ĐÁNH GIÁ" forState:UIControlStateNormal];
            
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(applyRandomFeedBack) object:nil];
            [self applyRandomFeedBack];
        }];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [btnFeedback sendActionsForControlEvents:UIControlEventTouchUpInside];
        return false;
    }
    
    return true;
}

@end
