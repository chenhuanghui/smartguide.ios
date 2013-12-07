//
//  CommentTyping.h
//  MakeTypeComment
//
//  Created by MacMini on 06/12/2013.
//  Copyright (c) 2013 MacMini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"

@interface CommentTyping : UIView<HPGrowingTextViewDelegate,UIScrollViewDelegate>
{
    __weak IBOutlet HPGrowingTextView *textView;
    __weak IBOutlet UIView *midView;
    __weak IBOutlet UIImageView *imgvAvatar;
    bool _isExpanded;
}

-(void) expand;
-(void) collapse;

-(bool) isExpanded;

@end