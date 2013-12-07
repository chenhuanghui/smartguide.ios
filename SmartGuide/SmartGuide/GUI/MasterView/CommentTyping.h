//
//  CommentTyping.h
//  MakeTypeComment
//
//  Created by MacMini on 06/12/2013.
//  Copyright (c) 2013 MacMini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"
#import "ButtonAgree.h"

@interface CommentTyping : UIView<HPGrowingTextViewDelegate,UIScrollViewDelegate>
{
    __weak IBOutlet HPGrowingTextView *textView;
    __weak IBOutlet UIView *midView;
    __weak IBOutlet UIScrollView *scroll;
    __weak IBOutlet UIView *contentScroll;
    __weak IBOutlet ButtonAgree *btnTopComment;
    __weak IBOutlet UIButton *btnShareFB;
    __weak IBOutlet ButtonAgree *btnSend;
    __weak IBOutlet UIImageView *imgvAvatar;
    __weak IBOutlet UIImageView *imgvBottom;
    bool _isExpanded;
    
    CGRect _imgvBottomFrame;
    CGRect _midFrame;
}

-(void) expand;
-(void) collapse;

-(bool) isExpanded;
+(CGSize) size;

@end