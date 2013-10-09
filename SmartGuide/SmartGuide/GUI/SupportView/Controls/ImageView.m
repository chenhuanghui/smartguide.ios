//
//  ImageView.m
//  SmartGuide
//
//  Created by XXX on 7/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ImageView.h"
#import <QuartzCore/QuartzCore.h>

@implementation ImageView

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    self.layer.cornerRadius=8;
    self.layer.masksToBounds=true;
    
    [super willMoveToSuperview:newSuperview];
}

@end
