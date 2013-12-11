//
//  SGScrollView.m
//  SGScrollView
//
//  Created by MacMini on 10/12/2013.
//  Copyright (c) 2013 MacMini. All rights reserved.
//

#import "SGScrollView.h"
#import "Utility.h"

@implementation SGScrollView

-(void)pauseView:(UIView *)view minY:(float)y
{
    if(!_pauseViews)
    {
        _pauseViews=[[NSMutableArray alloc] init];
    }
    
    [_pauseViews addObject:[PauseView pauseViewWithView:view minY:y]];
}

-(void)clearPauseViews
{
    [_pauseViews removeAllObjects];
}

-(void)clearFollowViews
{
    [_followViews removeAllObjects];
}

-(void)followView:(UIView *)view
{
    if(!_followViews)
    {
        _followViews=[[NSMutableArray alloc] init];
    }
    
    FollowView *fv=[FollowView new];
    fv.view=view;
    fv.viewFrame=view.frame;
    
    [_followViews addObject:fv];
}

-(CGPoint)offset
{
    return _offset;
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
}

-(void)removeFromSuperview
{
    [super removeFromSuperview];
}

-(void)setContentOffset:(CGPoint)contentOffset
{
    _offset.x=contentOffset.x-self.contentOffset.x;
    _offset.y=contentOffset.y-self.contentOffset.y;
    
    [super setContentOffset:contentOffset];
    
    if(_willRemoveFromSuperview)
        return;
    
    NSMutableArray *array=[NSMutableArray array];
    CGRect rect=CGRectZero;
    
    if(_followViews)
    {
        array=[NSMutableArray array];
        for(FollowView *fv in _followViews)
        {
            if(!fv.view)
                [array addObject:fv];
        }
        
        [_followViews removeObjectsInArray:array];
        
        for(FollowView *fv in _followViews)
        {
            [fv.view l_v_setY:fv.viewFrame.origin.y-contentOffset.y];
        }
    }
    
    if(_pauseViews)
    {
        for(PauseView *pv in _pauseViews)
        {
            if(!pv.view)
                [array addObject:pv];
        }
        
        [_pauseViews removeObjectsInArray:array];
        
        for(PauseView *pv in _pauseViews)
        {
            NSLog(@"%f %f",pv.viewFrame.origin.y-contentOffset.y,pv.minY);
            if(pv.viewFrame.origin.y-contentOffset.y<pv.minY)
            {
                rect=pv.view.frame;
                
                if([self.subviews containsObject:pv.view])
                {
                    rect.origin.y=contentOffset.y+pv.viewFrame.origin.y-(pv.viewFrame.origin.y-pv.minY);
                }
                else
                {
                    rect.origin.y=pv.viewFrame.origin.y-(pv.viewFrame.origin.y-pv.minY);
                }
                pv.view.frame=rect;
                
                if([pv.view isKindOfClass:[UIScrollView class]])
                {
                    UIScrollView *scroll=(UIScrollView*)pv.view;
                    [scroll setContentOffset:CGPointMake(scroll.contentOffset.x, rect.origin.y-pv.viewFrame.origin.y)];
                }
                
            }
        }
    }
}

- (void)dealloc
{
    [_pauseViews removeAllObjects];
    _pauseViews=nil;
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

@implementation FollowView
@synthesize view,viewFrame;

@end