//
//  LabelTopText.m
//  SmartGuide
//
//  Created by MacMini on 15/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "LabelTopText.h"

@implementation LabelTopText
@synthesize alignTextY;

-(void)drawTextInRect:(CGRect)rect
{
    [self.textColor set];
    [self.text drawInRect:CGRectMake(0, alignTextY, self.frame.size.width, self.frame.size.height) withFont:self.font lineBreakMode:self.lineBreakMode alignment:self.textAlignment];
}

-(void)setAlignTextY:(float)_alignTextY
{
    alignTextY=_alignTextY;
    
    [self setNeedsLayout];
}

@end
