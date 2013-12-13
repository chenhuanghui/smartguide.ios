//
//  CommentTyping.m
//  MakeTypeComment
//
//  Created by MacMini on 06/12/2013.
//  Copyright (c) 2013 MacMini. All rights reserved.
//

#import "CommentTyping.h"
#import "Utility.h"

#define COMMENT_TYPING_IMAGE_HEAD [UIImage imageNamed:@"bg_typecomment_head.png"]
#define COMMENT_TYPING_IMAGE_MID [UIImage imageNamed:@"bg_typecomment_mid.png"]
#define COMMENT_TYPING_IMAGE_BOTTOM [UIImage imageNamed:@"bg_typecomment_bottom.png"]

#define COMMENT_TYPING_EXPANED_HEIGHT 114.f-86.f

@implementation CommentTyping

- (id)init
{
    self = [[NSBundle mainBundle] loadNibNamed:@"CommentTyping" owner:nil options:nil][0];
    if (self) {
        
        imgvAvatar.layer.cornerRadius=imgvAvatar.frame.size.height/2;
        imgvAvatar.layer.masksToBounds=true;
        
        textView.isScrollable = NO;
        textView.contentInset = UIEdgeInsetsZero;
        
        textView.minNumberOfLines = 1;
        textView.maxNumberOfLines = 2;
        // you can also set the maximum height in points with maxHeight
        // textView.maxHeight = 200.0f;
        textView.returnKeyType = UIReturnKeyGo; //just as an example
        textView.font = [UIFont systemFontOfSize:12.0f];
        textView.delegate = self;
        textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
        textView.backgroundColor = [UIColor whiteColor];
        textView.placeholder = @"Type to see the textView grow!";
        
        midView.backgroundColor=[UIColor colorWithPatternImage:COMMENT_TYPING_IMAGE_MID];
        
        _imgvBottomFrame=imgvBottom.frame;
        _midFrame=midView.frame;
    }
    return self;
}

-(BOOL)growingTextViewShouldBeginEditing:(HPGrowingTextView *)growingTextView
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    return true;
}

-(void) keyboardWillHide:(NSNotification*) notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    [UIView animateWithDuration:[notification.userInfo floatForKey:UIKeyboardAnimationDurationUserInfoKey] animations:^{
        [scroll l_co_setY:0];
        [imgvBottom l_v_setY:_imgvBottomFrame.origin.y];
        [midView l_v_setH:_midFrame.size.height];
    }];
}

-(void) keyboardWillShow:(NSNotification*) notification
{
    [UIView animateWithDuration:[notification.userInfo floatForKey:UIKeyboardAnimationDurationUserInfoKey] animations:^{
        [scroll l_co_setY:COMMENT_TYPING_EXPANED_HEIGHT];
        [imgvBottom l_v_setY:_imgvBottomFrame.origin.y+COMMENT_TYPING_EXPANED_HEIGHT];
        [midView l_v_setH:_midFrame.size.height+COMMENT_TYPING_EXPANED_HEIGHT];
    }];
}

-(void)growingTextViewDidEndEditing:(HPGrowingTextView *)growingTextView
{
    [scroll setContentOffset:CGPointZero animated:true];
}

-(void)expand
{
    _isExpanded=true;
    
    [UIView animateWithDuration:0.3f animations:^{
        self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height+100);
        midView.backgroundColor=[UIColor colorWithPatternImage:COMMENT_TYPING_IMAGE_MID];
    }];
}

-(void)collapse
{
    _isExpanded=false;

    [UIView animateWithDuration:0.3f animations:^{
        self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height-100);
        midView.backgroundColor=[UIColor colorWithPatternImage:COMMENT_TYPING_IMAGE_MID];
    }];
}

-(bool)isExpanded
{
    return _isExpanded;
}

+(CGSize)size
{
    return CGSizeMake(290, 120);
}

@end
