//
//  NLCropViewLayer.m
//  NLImageCropper
//
// Copyright © 2012, Mirza Bilal (bilal@mirzabilal.com)
// All rights reserved.
//  Permission is hereby granted, free of charge, to any person obtaining a copy
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
// 1.	Redistributions of source code must retain the above copyright notice,
//       this list of conditions and the following disclaimer.
// 2.	Redistributions in binary form must reproduce the above copyright notice,
//       this list of conditions and the following disclaimer in the documentation
//       and/or other materials provided with the distribution.
// 3.	Neither the name of Mirza Bilal nor the names of its contributors may be used
//       to endorse or promote products derived from this software without specific
//       prior written permission.
// THIS SOFTWARE IS PROVIDED BY MIRZA BILAL "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
// INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
// FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL MIRZA BILAL BE LIABLE FOR
// ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
// BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
// PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
// IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
// ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "NLCropViewLayer.h"
#import <QuartzCore/QuartzCore.h>


@implementation NLCropViewLayer
{
    UIView *touchedView;
    CGPoint touchedPoint;
    float deltaX;
    float deltaY;
    bool _isInRect;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    UIImage *img=[UIImage imageNamed:@"pin.png"];
    
    CGRect rect=CGRectMake(0, 0, 10, 10);
    
    leftTopCorner = [[UIImageView alloc] initWithImage:img];
    leftTopCorner.layer.shadowColor = [UIColor blackColor].CGColor;
    leftTopCorner.layer.shadowOffset = CGSizeMake(1, 1);
    leftTopCorner.layer.shadowOpacity = 0.6;
    leftTopCorner.layer.shadowRadius = 1.0;
    
    leftBottomCorner = [[UIImageView alloc] initWithImage:img];
    leftBottomCorner.layer.shadowColor = [UIColor blackColor].CGColor;
    leftBottomCorner.layer.shadowOffset = CGSizeMake(1, 1);
    leftBottomCorner.layer.shadowOpacity = 0.6;
    leftBottomCorner.layer.shadowRadius = 1.0;
    
    rightTopCorner = [[UIImageView alloc] initWithImage:img];
    rightTopCorner.layer.shadowColor = [UIColor blackColor].CGColor;
    rightTopCorner.layer.shadowOffset = CGSizeMake(1, 1);
    rightTopCorner.layer.shadowOpacity = 0.6;
    rightTopCorner.layer.shadowRadius = 1.0;
    
    rightBottomCorner = [[UIImageView alloc] initWithImage:img];
    rightBottomCorner.layer.shadowColor = [UIColor blackColor].CGColor;
    rightBottomCorner.layer.shadowOffset = CGSizeMake(1, 1);
    rightBottomCorner.layer.shadowOpacity = 0.6;
    rightBottomCorner.layer.shadowRadius = 1.0;
    
    [self addSubview:leftTopCorner];
    [self addSubview:leftBottomCorner];
    [self addSubview:rightTopCorner];
    [self addSubview:rightBottomCorner];
    
    leftTopCorner.frame=rect;
    leftBottomCorner.frame=rect;
    rightTopCorner.frame=rect;
    rightBottomCorner.frame=rect;
    
    _cropRect.size=CGSizeMake(80, 80);
    _cropRect.origin.x=frame.size.width/2-_cropRect.size.width/2;
    _cropRect.origin.y=frame.size.height/2-_cropRect.size.height;
    
    leftTopCorner.center = _cropRect.origin;
    leftBottomCorner.center = CGPointMake(_cropRect.origin.x , _cropRect.origin.y + _cropRect.size.height);
    rightTopCorner.center = CGPointMake(_cropRect.origin.x + _cropRect.size.width , _cropRect.origin.y);
    rightBottomCorner.center = CGPointMake(_cropRect.origin.x + _cropRect.size.width , _cropRect.origin.y + _cropRect.size.height);
    
    return self;
}

-(void) drawRect:(CGRect)rect2
{
    [super drawRect:rect2];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect rect = _cropRect;

    CGContextSetRGBFillColor(context,   0.0, 0.0, 0.0, 0.7);    
    CGContextSetRGBStrokeColor(context, 1, 1, 1, 0.7);
    
    
    CGFloat lengths[2];
    lengths[0] = 0.0;
    lengths[1] = 3.0 * 2;
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 3.0);
    //    CGContextSetLineDash(context, 0.0f, lengths, 2);
    
    
    float w = self.bounds.size.width;
    float h = self.bounds.size.height;
    
    CGRect clips2[] =
	{
        CGRectMake(0, 0, w, rect.origin.y),
        CGRectMake(0, rect.origin.y,rect.origin.x, rect.size.height),
        CGRectMake(0, rect.origin.y + rect.size.height, w, h-(rect.origin.y+rect.size.height)),
        CGRectMake(rect.origin.x + rect.size.width, rect.origin.y, w-(rect.origin.x + rect.size.width), rect.size.height),
	};
    CGContextClipToRects(context, clips2, sizeof(clips2) / sizeof(clips2[0]));
    
    CGContextFillRect(context, self.bounds);
    CGContextStrokeRect(context, rect);
    
    UIGraphicsEndImageContext();
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _isInRect=false;
    UITouch *touch=[touches anyObject];
    
    for(UIView *v in [self corners])
    {
        if(CGRectContainsPoint(v.frame, [touch locationInView:self]))
        {
            touchedPoint=[touch locationInView:self];
            touchedView=v;
            break;
        }
    }
    
    if(!touchedView)
    {
        if(CGRectContainsPoint(_cropRect, [touch locationInView:self]))
        {
            touchedPoint=[touch locationInView:self];
            _isInRect=true;
        }
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(touchedView)
    {
        [self setNeedsDisplay];
        
        UITouch *touch=[touches anyObject];
        CGPoint pnt=[touch locationInView:self];
        
        CGPoint centerLT=leftTopCorner.center;
        CGPoint centerLB=leftBottomCorner.center;
        CGPoint centerRT=rightTopCorner.center;
        CGPoint centerRB=rightBottomCorner.center;
        CGRect cropRect=_cropRect;
        
        deltaX=touchedPoint.x-pnt.x;
        deltaY=touchedPoint.y-pnt.y;
        
        float delta=(deltaX+deltaY)/2;

        if(touchedView==leftTopCorner || touchedView==rightBottomCorner)
            touchedView.center=CGPointMake(touchedView.center.x-delta, touchedView.center.y-delta);
        else if(touchedView==leftBottomCorner || touchedView==rightTopCorner)
        {
            deltaY=pnt.y-touchedPoint.y;
            delta=(deltaX+deltaY)/2;
            touchedView.center=CGPointMake(touchedView.center.x-delta, touchedView.center.y+delta);
        }
        
        touchedPoint=[touch locationInView:self];
        
        if(touchedView==leftTopCorner)
        {
            leftBottomCorner.center=CGPointMake(leftTopCorner.center.x, leftBottomCorner.center.y);
            rightTopCorner.center=CGPointMake(rightTopCorner.center.x, leftTopCorner.center.y);
            _cropRect.origin=leftTopCorner.center;
            _cropRect.size.width=rightTopCorner.center.x-leftTopCorner.center.x;
            _cropRect.size.height=leftBottomCorner.center.y-leftTopCorner.center.y;
        }
        else if(touchedView==leftBottomCorner)
        {
            leftTopCorner.center=CGPointMake(leftBottomCorner.center.x, leftTopCorner.center.y);
            rightBottomCorner.center=CGPointMake(rightBottomCorner.center.x, leftBottomCorner.center.y);
            _cropRect.origin.x=leftBottomCorner.center.x;
            _cropRect.origin.y=leftTopCorner.center.y;
            _cropRect.size.width=rightBottomCorner.center.x-leftBottomCorner.center.x;
            _cropRect.size.height=leftBottomCorner.center.y-leftTopCorner.center.y;
        }
        else if(touchedView==rightTopCorner)
        {
            rightBottomCorner.center=CGPointMake(rightTopCorner.center.x, rightBottomCorner.center.y);
            leftTopCorner.center=CGPointMake(leftTopCorner.center.x, rightTopCorner.center.y);
            _cropRect.origin=leftTopCorner.center;
            _cropRect.size.width=rightTopCorner.center.x-leftTopCorner.center.x;
            _cropRect.size.height=rightBottomCorner.center.y-rightTopCorner.center.y;
        }
        else if(touchedView==rightBottomCorner)
        {
            rightTopCorner.center=CGPointMake(rightBottomCorner.center.x, rightTopCorner.center.y);
            leftBottomCorner.center=CGPointMake(leftBottomCorner.center.x, rightBottomCorner.center.y);
            _cropRect.origin=leftTopCorner.center;
            _cropRect.size.width=rightBottomCorner.center.x-leftBottomCorner.center.x;
            _cropRect.size.height=rightBottomCorner.center.y-rightTopCorner.center.y;
        }

        if(_cropRect.size.width<80 || _cropRect.size.width>300 || !CGRectContainsRect(self.frame, _cropRect))
        {
            _cropRect=cropRect;
            leftTopCorner.center=centerLT;
            leftBottomCorner.center=centerLB;
            rightTopCorner.center=centerRT;
            rightBottomCorner.center=centerRB;
        }
    }
    else if(_isInRect)
    {
        [self setNeedsDisplay];
        
        UITouch *touch=[touches anyObject];
        
        deltaX=touchedPoint.x-[touch locationInView:self].x;
        deltaY=touchedPoint.y-[touch locationInView:self].y;
        
        touchedPoint=[touch locationInView:self];
        
        CGRect rect=_cropRect;
        
        _cropRect.origin.x-=deltaX;
        _cropRect.origin.y-=deltaY;
        
        if(!CGRectContainsRect(self.frame, _cropRect))
            _cropRect=rect;
        
        leftTopCorner.center = _cropRect.origin;
        leftBottomCorner.center = CGPointMake(_cropRect.origin.x , _cropRect.origin.y + _cropRect.size.height);
        rightTopCorner.center = CGPointMake(_cropRect.origin.x + _cropRect.size.width , _cropRect.origin.y);
        rightBottomCorner.center = CGPointMake(_cropRect.origin.x + _cropRect.size.width , _cropRect.origin.y + _cropRect.size.height);
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    touchedView=nil;
    touchedPoint=CGPointZero;
    deltaX=0;
    deltaY=0;
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

-(NSArray*) corners
{
    return @[leftTopCorner,leftBottomCorner,rightTopCorner,rightBottomCorner];
}

-(CGRect)cropRect
{
    return _cropRect;
}

@end