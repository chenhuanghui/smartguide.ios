//
//  HitTestView.m
//  SmartGuide
//
//  Created by MacMini on 19/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "HitTestView.h"

@implementation HitTestView
@synthesize receiveView;

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if(!receiveView)
        return [super hitTest:point withEvent:event];
    
    UIView *view = [super hitTest:point withEvent:event];
    if (view == self) {
        return receiveView;
    }
    return view;
}

@end
