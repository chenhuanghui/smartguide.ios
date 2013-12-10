//
//  SGScrollView.m
//  SGScrollView
//
//  Created by MacMini on 10/12/2013.
//  Copyright (c) 2013 MacMini. All rights reserved.
//

#import "SGScrollView.h"

@implementation SGScrollView

-(void)pauseView:(UIView *)view minY:(float)y
{
    if(!_pauseViews)
    {
        _pauseViews=[[NSMutableArray alloc] init];
    }
    
    [_pauseViews addObject:[PauseView pauseViewWithView:view minY:y]];
}

-(CGPoint)offset
{
    return _offset;
}

-(void)setContentOffset:(CGPoint)contentOffset
{
    _offset.x=contentOffset.x-self.contentOffset.x;
    _offset.y=contentOffset.y-self.contentOffset.y;
    
    [super setContentOffset:contentOffset];
    
    CGRect rect=CGRectZero;
    for(PauseView *pv in _pauseViews)
    {
        if(pv.viewFrame.origin.y-contentOffset.y<pv.minY)
        {
            rect=pv.view.frame;
//            rect.origin.y+=-contentOffset.y-(pv.viewFrame.origin.y-pv.minY);
            rect.origin.y=contentOffset.y+pv.viewFrame.origin.y-(pv.viewFrame.origin.y-pv.minY);
            pv.view.frame=rect;
            
            if([pv.view isKindOfClass:[UIScrollView class]])
            {
                UIScrollView *scroll=(UIScrollView*)pv.view;
                [scroll setContentOffset:CGPointMake(scroll.contentOffset.x, rect.origin.y-pv.viewFrame.origin.y)];
            }
        }
    }
}

@end

@implementation PauseView
@synthesize view,minY,viewFrame;

+(PauseView *)pauseViewWithView:(UIView *)view minY:(float)minY
{
    PauseView *pv=[PauseView new];
    pv.view=view;
    pv.minY=minY;
    pv.viewFrame=view.frame;
    
    return pv;
}

@end