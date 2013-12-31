//
//  ButtonPrice.m
//  SmartGuide
//
//  Created by MacMini on 10/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ButtonPrice.h"

#define BUTTON_PRICE_IMAGE_LEFT_NORMAL [UIImage imageNamed:@"bg_price_left.png"]
#define BUTTON_PRICE_IMAGE_RIGHT_NORMAL [UIImage imageNamed:@"bg_price_right.png"]

@implementation ButtonPrice


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    UIImage *left=BUTTON_PRICE_IMAGE_LEFT_NORMAL;
    UIImage *right=BUTTON_PRICE_IMAGE_RIGHT_NORMAL;
    
    [left drawAtPoint:CGPointZero];
    [right drawAtPoint:CGPointMake(rect.origin.x+rect.size.width-right.size.width, 0)];

    [[UIColor whiteColor] set];
    
    rect.origin.x=left.size.width;
    rect.size.width=rect.size.width-right.size.width-left.size.width;
    CGContextFillRect(UIGraphicsGetCurrentContext(), rect);
}

@end
