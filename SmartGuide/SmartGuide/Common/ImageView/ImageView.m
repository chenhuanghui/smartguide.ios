//
//  ImageView.m
//  Infory
//
//  Created by XXX on 4/4/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ImageView.h"
#import "Utility.h"

@implementation ImageView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    CGRect rect=self.frame;
    rect.origin=CGPointZero;
    ImageDefaultBGView *view=[[ImageDefaultBGView alloc] initWithFrame:rect];
    bgView=view;

    [self addSubview:view];
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    frame.origin=CGPointZero;
    bgView.frame=frame;
}

-(void)setImage:(UIImage *)image
{
    if(image)
    {
        bgView.alpha=1;
        bgView.hidden=false;
        [UIView animateWithDuration:0.3f animations:^{
            bgView.alpha=0;
        } completion:^(BOOL finished) {
            bgView.hidden=true;
        }];
    }
    else
    {
        bgView.alpha=1;
        bgView.hidden=false;
    }
    
    [super setImage:image];
}

@end
