//
//  InfoTypeBGView.m
//  SmartGuide
//
//  Created by MacMini on 23/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "InfoTypeBGView.h"

@implementation InfoTypeBGView
@synthesize drawBottomLine;

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor=[UIColor clearColor];
}

-(void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"bg_detail_info_mid.png"] drawAsPatternInRect:rect];
    
    if(drawBottomLine)
    {
        [[UIImage imageNamed:@"bg_detail_info_bottom.png"] drawAtPoint:CGPointMake(0, rect.size.height-5)];
    }
    else
    {
        CGContextRef context=UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
        CGContextSetLineWidth(context, 0.5f);
        
        CGContextMoveToPoint(context, 4, rect.size.height-2);
        CGContextAddLineToPoint(context, rect.size.width-2, rect.size.height-2);
        
        CGContextStrokePath(context);
    }
}

-(void)setDrawBottomLine:(bool)_drawBottomLine
{
    if(drawBottomLine!=_drawBottomLine)
        [self setNeedsDisplay];
    
    drawBottomLine=_drawBottomLine;
}

@end
