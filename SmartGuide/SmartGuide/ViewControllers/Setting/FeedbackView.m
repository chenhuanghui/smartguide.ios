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
    self=[[[NSBundle mainBundle] loadNibNamed:@"FeedbackView" owner:nil options:nil] objectAtIndex:0];
    
    txt.text=@"";
    [txt setPlaceHolderText:@"" textColor:[UIColor blackColor]];
    lblName.text=@"";
    
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
    if(_isEditing)
    {
        if([txt.text stringByRemoveString:@" ",nil].length==0)
        {
            [AlertView showAlertOKWithTitle:nil withMessage:@"Vui lòng nhập nội dung đánh giá" onOK:^{
                [txt becomeFirstResponder];
            }];
            return;
        }
        
        ASIOperationPostFeedback *post=[[ASIOperationPostFeedback alloc] initWithIDUser:[DataManager shareInstance].currentUser.idUser.integerValue content:txt.text];
        
        post.delegatePost=self;
        [post startAsynchronous];
        
        [self showLoadingWithTitle:nil];
    }
    else
    {
        [txt becomeFirstResponder];
        [btnFeedback setTitle:@"Gữi" forState:UIControlStateNormal];
    }
}

- (IBAction)btnBackTouchUpInside:(id)sender {
    [delegate feedbackViewBack:self];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationGetFeedback class]])
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(applyRandomFeedBack) object:nil];
        
        ASIOperationGetFeedback *fb=(ASIOperationGetFeedback*) operation;
        
        _feedbacks=[[NSMutableArray alloc] initWithArray:fb.feedbacks];
        
        [self performSelector:@selector(applyRandomFeedBack) withObject:nil afterDelay:0];
        
        feedback=nil;
    }
    else if([operation isKindOfClass:[ASIOperationPostFeedback class]])
    {
        txt.text=@"";
        [txt resignFirstResponder];
        
        [self endEditing:true];
        
        [self removeLoading];
        
        [self loadFeedBack];
    }
}

-(void) applyFeedback:(Feedback*) fb
{
    txt.text=@"";
    [btnFeedback setTitle:@"Đánh giá" forState:UIControlStateNormal];
    [UIView animateWithDuration:0.15f animations:^{
        lblName.alpha=0;
        txt.alpha=0;
    } completion:^(BOOL finished) {
        if(!_isEditing)
            lblName.text=[NSString stringWithFormat:@"%@",fb.user];
        
        [txt setPlaceHolderText:[NSString stringWithFormat:@"%@", fb.content]textColor:[UIColor blackColor]];
        
        [UIView animateWithDuration:0.15f animations:^{
            lblName.alpha=1;
            txt.alpha=1;
        } completion:^(BOOL finished) {
            [self performSelector:@selector(applyRandomFeedBack) withObject:nil afterDelay:3];
        }];
    }];
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(applyRandomFeedBack) object:nil];
    
    
    lblName.text=[DataManager shareInstance].currentUser.name;
    txt.text=@" ";
    [btnFeedback setTitle:@"Gữi" forState:UIControlStateNormal];
    _isEditing=true;
    
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
    txt.text=@"";
    [txt removePlaceHolderText];
    [txt resignFirstResponder];
    [self endEditing:true];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(applyRandomFeedBack) object:nil];
    _isEditing=false;
    [self applyRandomFeedBack];
}

@end

@implementation TextFieldFeedBack

-(void)drawPlaceholderInRect:(CGRect)rect
{
    [[UIColor blackColor] setFill];
    UIFont *fo = [UIFont italicSystemFontOfSize:17];
    float width=[[self placeholder] sizeWithFont:fo].width;
    rect.origin.x=rect.size.width/2-width/2;
    [[self placeholder] drawInRect:rect withFont:fo];
    
    [@"\"" drawInRect:CGRectMake(rect.origin.x-15, rect.origin.y, rect.size.width, rect.size.height) withFont:[UIFont italicSystemFontOfSize:24]];
    [@"\"" drawInRect:CGRectMake(rect.origin.x+width+5, rect.origin.y, rect.size.width, rect.size.height) withFont:[UIFont italicSystemFontOfSize:24]];
}

-(void)drawTextInRect:(CGRect)rect
{
    [[UIColor blackColor] setFill];
    UIFont *fo = [UIFont italicSystemFontOfSize:17];
    float width=[[self text] sizeWithFont:fo].width;
    rect.origin.x=rect.size.width/2-width/2;
    [[self text] drawInRect:rect withFont:fo];
    
    [@"\"" drawInRect:CGRectMake(rect.origin.x-15, rect.origin.y, rect.size.width, rect.size.height) withFont:[UIFont italicSystemFontOfSize:24]];
    [@"\"" drawInRect:CGRectMake(rect.origin.x+width+5, rect.origin.y, rect.size.width, rect.size.height) withFont:[UIFont italicSystemFontOfSize:24]];
}

@end