//
//  LabelStroke.m
//  SmartGuide
//
//  Created by XXX on 8/13/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "LabelStroke.h"

@implementation LabelStroke
@synthesize strokeColor,strokeWidth;

- (void)drawTextInRect:(CGRect)rect {
    
    CGSize shadowOffset = self.shadowOffset;
    UIColor *textColor = self.textColor;
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, strokeWidth);
    CGContextSetLineJoin(c, kCGLineJoinRound);
    
    CGContextSetTextDrawingMode(c, kCGTextStroke);
    self.textColor = strokeColor;
    [super drawTextInRect:rect];
    
    CGContextSetTextDrawingMode(c, kCGTextFill);
    self.textColor = textColor;
    self.shadowOffset = shadowOffset;
    [super drawTextInRect:rect];
    
    self.shadowOffset = shadowOffset;
    
}

@end
