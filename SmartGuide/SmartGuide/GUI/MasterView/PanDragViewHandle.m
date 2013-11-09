//
//  PanGestureView.m
//  SmartGuide
//
//  Created by MacMini on 27/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "PanDragViewHandle.h"

@implementation PanDragViewHandle
@synthesize panDirection,currentView,otherView,delegate;

-(PanDragViewHandle *)initWithDirection:(enum PanGestureDirection)_direction withCurrentView:(UIView *)_currentView withOtherView:(UIView *)_otherView
{
    self=[super init];
    
    panDirection=_direction;
    currentView=_currentView;
    otherView=_otherView;
    
    return self;
}

-(void)handlePanGesture:(UIPanGestureRecognizer *)ges
{
    switch (ges.state) {
        case UIGestureRecognizerStateBegan:
            _startPoint=[ges locationInView:ges.view];
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGPoint pnt=[ges locationInView:ges.view];
            float deltaX=pnt.x-_startPoint.x;
            _startPoint=pnt;
            
            switch (self.panDirection) {
                case PanGestureDirectionToLeft:
                {
                    if(self.otherView.center.x+deltaX<self.otherView.frame.size.width/2)
                    {
                        self.otherView.center=CGPointMake(self.otherView.frame.size.width/2,self.otherView.center.y);
                        self.currentView.center=CGPointMake(-self.currentView.frame.size.width/2, self.currentView.center.y);
                        return;
                    }
                    
                    self.currentView.center=CGPointMake(self.currentView.center.x+deltaX, self.currentView.center.y);
                    self.otherView.center=CGPointMake(self.otherView.center.x+deltaX, self.otherView.center.y);
                }
                    break;
                    
                case PanGestureDirectionToRight:
                {
                }
                    break;
            }
        }
            break;
            
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        {
            float velocity=[ges velocityInView:ges.view].x;
            
            switch (self.panDirection) {
                case PanGestureDirectionToLeft:
                {
                    if(velocity>0 && velocity>VELOCITY_SLIDE)
                        [self moveToCurrentView];
                    else
                    {
                        if(self.otherView.center.x>self.otherView.frame.size.width/2 + self.otherView.frame.size.width/4)
                            [self moveToCurrentView];
                        else
                            [self moveToOtherView];
                    }
                }
                    break;
                    
                case PanGestureDirectionToRight:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
}

-(void) moveToCurrentView
{
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        switch (self.panDirection) {
            case PanGestureDirectionToLeft:
                self.currentView.center=CGPointMake(self.currentView.frame.size.width/2, self.currentView.center.y);
                self.otherView.center=CGPointMake(self.otherView.frame.size.width*1.5f, self.otherView.center.y);
                break;
                
            case PanGestureDirectionToRight:
                break;
        }
    } completion:^(BOOL finished) {
        [self.delegate panGestureMovedToView:self.currentView];
    }];
}

-(void) moveToOtherView
{
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        switch (self.panDirection) {
            case PanGestureDirectionToLeft:
            {
                self.currentView.center=CGPointMake(-self.currentView.frame.size.width/2, self.currentView.center.y);
                self.otherView.center=CGPointMake(self.otherView.frame.size.width/2, self.otherView.center.y);
            }
                break;
                
            case PanGestureDirectionToRight:
                break;
        }
    } completion:^(BOOL finished) {
        [self.delegate panGestureMovedToView:self.otherView];
    }];
}

CALL_DEALLOC_LOG

@end
