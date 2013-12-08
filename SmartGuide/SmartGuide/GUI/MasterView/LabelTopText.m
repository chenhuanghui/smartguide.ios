//
//  LabelTopText.m
//  SmartGuide
//
//  Created by MacMini on 15/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "LabelTopText.h"

@implementation LabelTopText

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)drawTextInRect:(CGRect)rect
{
    [self.text drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) withFont:self.font lineBreakMode:self.lineBreakMode alignment:self.textAlignment];
}

@end
