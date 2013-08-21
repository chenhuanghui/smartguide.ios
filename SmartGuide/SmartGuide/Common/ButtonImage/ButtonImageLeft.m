//
//  ButtonImageLeft.m
//  SmartGuide
//
//  Created by XXX on 8/19/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ButtonImageLeft.h"

@implementation ButtonImageLeft

- (id)init
{
    self = [super init];
    if (self) {
        text=[[NSString alloc] initWithFormat:@""];
    }
    return self;
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    text=[[NSString alloc] initWithString:title?title:@""];
    [super setTitle:title forState:state];
}

-(void)setTrickFont:(UIFont *)trickFont
{
    _trickFont=[UIFont fontWithName:trickFont.fontName size:trickFont.pointSize];
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    if(!_trickFont)
        return [super titleRectForContentRect:contentRect];
    
    contentRect.size.width=[text sizeWithFont:_trickFont].width;
    contentRect.origin.x=0;
    
    return contentRect;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    contentRect.size=[self imageForState:UIControlStateNormal].size;
    
    CGRect rect=[self titleRectForContentRect:contentRect];
    
    contentRect.origin.x=rect.size.width+rect.origin.x+3;
    contentRect.origin.y=(self.frame.size.height-contentRect.size.height)/2;
    
    return contentRect;
}


@end
