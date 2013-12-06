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
    __weak HPGrowingTextView *textView;
    float _midY;
}

@end