//
//  KMBGView.m
//  SmartGuide
//
//  Created by MacMini on 03/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "KMBGView.h"

@implementation KMBGView

-(void)drawRect:(CGRect)rect
{
    if(!img)
        img=[UIImage imageNamed:@"pattern_promotion.png"];
    
    rect.origin=CGPointZero;
    
    [img drawAsPatternInRect:rect];
}

@end
