//
//  TouchView.m
//  SmartGuide
//
//  Created by XXX on 8/4/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "TouchView.h"

@implementation TouchView
@synthesize receiveView;

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view=[super hitTest:point withEvent:event];
    if(view==self)
        return receiveView;
    
    return view;
}

@end
