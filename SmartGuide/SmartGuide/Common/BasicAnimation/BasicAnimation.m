//
//  BasicAnimation.m
//  Infory
//
//  Created by XXX on 6/12/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "BasicAnimation.h"

BasicAnimation* basicTransitionPush(CGPoint fromPosition, CGPoint toPosition, float duration)
{
    BasicAnimation *obj=[BasicAnimation animationWithKeyPath:@"position"];
    
    obj.fromValue=[NSValue valueWithCGPoint:fromPosition];
    obj.toValue=[NSValue valueWithCGPoint:toPosition];
    obj.duration=duration;
    obj.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    obj.fillMode=kCAFillModeForwards;
    obj.removedOnCompletion=true;
    
    return obj;
}

@implementation BasicAnimation

-(void)addToLayer:(CALayer *)layer onStart:(void (^)(BasicAnimation * bsAnimation))onStart onStop:(void (^)(BasicAnimation *bsAnimation, bool finished))onStop
{
    if(onStart)
        _onStart=[onStart copy];
    
    if(onStop)
        _onStop=[onStop copy];
    
    self.delegate=self;
    
    [layer setValue:self.toValue forKeyPath:self.keyPath];
    [layer addAnimation:self forKey:self.keyPath];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if(_onStop)
    {
        _onStop(self,flag);
        _onStop=nil;
    }
    
    self.delegate=nil;
}

-(void)animationDidStart:(CAAnimation *)anim
{
    if(_onStart)
    {
        _onStart(self);
        _onStart=nil;
    }
}

@end