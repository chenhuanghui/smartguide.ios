//
//  ButtonText.m
//  alignButotn
//
//  Created by XXX on 8/9/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ButtonImageRight.h"

@implementation ButtonImageRight

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGRect rect=[self imageRectForContentRect:contentRect];
    
    contentRect.size.width=self.frame.size.width-rect.size.width;
    contentRect.origin.x=-5;

    return contentRect;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    contentRect.size=[self imageForState:UIControlStateNormal].size;
    contentRect.origin.x=self.frame.size.width-contentRect.size.width;
    contentRect.origin.y=(self.frame.size.height-contentRect.size.height)/2;
    
    return contentRect;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
