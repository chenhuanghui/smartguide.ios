//
//  KMBGView.m
//  SmartGuide
//
//  Created by MacMini on 03/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "KMBGView.h"

@implementation KMBGView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.contentMode=UIViewContentModeRedraw;
}

-(void)drawRect:(CGRect)rect
{

    rect.origin=CGPointZero;
    
    [[UIImage imageNamed:@"pattern_promotion.png"] drawAsPatternInRect:rect];
}

@end
