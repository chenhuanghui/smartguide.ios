//
//  TouchView.m
//  SmartGuide
//
//  Created by XXX on 8/4/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "TouchView.h"

@implementation TouchView
@synthesize delegate;

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([self isRespondsSEL:@selector(viewTouchBegan:touches:withEvent:)])
        [delegate viewTouchBegan:self touches:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([self isRespondsSEL:@selector(viewTouchMoved:touches:withEvent:)])
        [delegate viewTouchMoved:self touches:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([self isRespondsSEL:@selector(viewTouchEnded:touches:withEvent:)])
        [delegate viewTouchEnded:self touches:touches withEvent:event];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([self isRespondsSEL:@selector(viewTouchCancelled:touches:withEvent:)])
        [delegate viewTouchCancelled:self touches:touches withEvent:event];
}

-(bool) isRespondsSEL:(SEL) selector
{
    return delegate && [delegate respondsToSelector:selector];
}

@end
