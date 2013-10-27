//
//  PanGestureView.h
//  SmartGuide
//
//  Created by MacMini on 27/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constant.h"

enum PanGestureDirection {
    PanGestureDirectionToLeft = 0,
    PanGestureDirectionToRight = 1
    };

@protocol PanGestureDelegate <NSObject>

-(void) panGestureMovedToView:(UIView*) view;

@end

@interface PanGestureView : NSObject
{
    CGPoint _startPoint;
}

-(PanGestureView*) initWithDirection:(enum PanGestureDirection) direction withCurrentView:(UIView*) currentView withOtherView:(UIView*) otherView;

-(void) handlePanGesture:(UIPanGestureRecognizer*) ges;

@property (nonatomic, readonly) enum PanGestureDirection panDirection;
@property (nonatomic, weak, readonly) UIView *currentView;
@property (nonatomic, weak, readonly) UIView *otherView;
@property (nonatomic, assign) id<PanGestureDelegate> delegate;

@end
