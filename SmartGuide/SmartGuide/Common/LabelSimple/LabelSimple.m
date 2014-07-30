//
//  LabelSimple.m
//  Infory
//
//  Created by XXX on 7/30/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "LabelSimple.h"

@implementation LabelSimple

-(void)setFrame:(CGRect)frame
{
    bool animationEnabled=[UIView areAnimationsEnabled];
    
    [UIView setAnimationsEnabled:false];
    [super setFrame:frame];
    [UIView setAnimationsEnabled:animationEnabled];
}

@end
