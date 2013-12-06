//
//  CommentTyping.m
//  MakeTypeComment
//
//  Created by MacMini on 06/12/2013.
//  Copyright (c) 2013 MacMini. All rights reserved.
//

#import "CommentTyping.h"

#define COMMENT_TYPING_IMAGE_HEAD [UIImage imageNamed:@"bg_typecomment_head.png"]
#define COMMENT_TYPING_IMAGE_MID [UIImage imageNamed:@"bg_typecomment_mid.png"]
#define COMMENT_TYPING_IMAGE_BOTTOM [UIImage imageNamed:@"bg_typecomment_bottom.png"]

@implementation CommentTyping

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if(newSuperview && !textView)
    {
        HPGrowingTextView *tv = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(2, 5, self.frame.size.width-4, self.frame.size.height-4)];
        
        textView=tv;
        
        textView.backgroundColor=[UIColor clearColor];
        
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
        
        [self addSubview:tv];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f",scrollView.contentOffset.y);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    UIImage *head=COMMENT_TYPING_IMAGE_HEAD;
    UIImage *mid=COMMENT_TYPING_IMAGE_MID;
    UIImage *bottom=COMMENT_TYPING_IMAGE_BOTTOM;

    [head drawAtPoint:CGPointZero];
    [mid drawAsPatternInRect:CGRectMake(0, head.size.height, rect.size.width, rect.size.height-bottom.size.height-head.size.height)];
    [bottom drawAtPoint:CGPointMake(0, rect.size.height-bottom.size.height)];
}

-(void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    NSLog(@"willChangeHeight %f",height);
}

@end
