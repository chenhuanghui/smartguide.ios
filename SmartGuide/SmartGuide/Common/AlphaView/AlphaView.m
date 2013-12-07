//
//  AlphaView.m
//  SmartGuide
//
//  Created by XXX on 7/30/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "AlphaView.h"
#import <QuartzCore/QuartzCore.h>

@implementation AlphaView

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    self.tag=ALPHA_TAG;
    
    [super willMoveToSuperview:newSuperview];
}

-(void)setTag:(NSInteger)tag
{
    tag=ALPHA_TAG;
    [super setTag:tag];
}

-(NSInteger)tag
{
    return ALPHA_TAG;
}

-(void)removeFromSuperview
{
    [super removeFromSuperview];
}

@end

@implementation UIView(AlphaView)

-(AlphaView *)makeAlphaView
{
    CGRect rect=self.frame;
    rect.origin=CGPointZero;
    
    AlphaView *alphaView=[self alphaView];
    if(!alphaView)
    {
        if([self isKindOfClass:[UIScrollView class]])
            rect.size=((UIScrollView*)self).contentSize;
        
        alphaView=[[AlphaView alloc] initWithFrame:rect];
        [self addSubview:alphaView];
    }
    else
        alphaView.frame=rect;
    
    return alphaView;
}

-(AlphaView *)makeAlphaViewBelowView:(UIView *)view
{
    AlphaView *alphaView=[self makeAlphaView];
    
    [self removeAlphaView];
    
    [self insertSubview:alphaView belowSubview:view];
    
    return alphaView;
}

-(AlphaView *)alphaView
{
    for(id obj in self.subviews)
    {
        if([obj isKindOfClass:[AlphaView class]])
            return obj;
    }
    
    return nil;
}

-(AlphaView *)alphaViewWithColor:(UIColor *)color
{
    AlphaView *ap=[self alphaView];
    if(!ap)
    {
        ap=[self makeAlphaView];
        ap.backgroundColor=color;
    }
    
    return ap;
}

-(AlphaView *)alphaViewWithColor:(UIColor *)color belowView:(UIView *)view
{
    AlphaView *ap=[self alphaView];
    if(!ap)
    {
        ap=[self makeAlphaViewBelowView:view];
        ap.backgroundColor=color;
    }
    
    return ap;
}

-(void)removeAlphaView
{
    while ([self alphaView]) {
        [[self alphaView] removeFromSuperview];
    }
}

@end