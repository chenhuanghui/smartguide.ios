//
//  BasicAnimation.h
//  Infory
//
//  Created by XXX on 6/12/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface BasicAnimation : CABasicAnimation
{
    void(^_onStop)(BasicAnimation* bsAnimation, bool isFinished);
    void(^_onStart)(BasicAnimation* bsAnimation);
}

-(void) addToLayer:(CALayer*) layer onStart:(void(^)(BasicAnimation* bsAnimation)) onStart onStop:(void(^)(BasicAnimation* bsAnimation, bool isFinished)) onStop;

@end
