//
//  HomeBGCell.m
//  SmartGuide
//
//  Created by MacMini on 31/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "HomeBGCell.h"
#import "Utility.h"
#import "AlphaView.h"

@implementation HomeBGCell

-(void)drawRect:(CGRect)rect
{
//    [super drawRect:rect];
    
    if(!imgMid)
    {
        imgTop=[UIImage imageNamed:@"bg_feed_head_home.png"];
        imgMid=[UIImage imageNamed:@"bg_feed_mid_home.png"];
        imgBottom=[UIImage imageNamed:@"bg_feed_bottom_home.png"];
    }
    
    [imgTop drawInRect:CGRectMake(0, 0, imgTop.size.width, imgTop.size.height)];
    [imgBottom drawAtPoint:CGPointMake(0, rect.size.height-imgTop.size.height)];
    
    rect.origin.y=imgTop.size.height;
    rect.origin.x=0;
    rect.size.height-=(imgTop.size.height+imgBottom.size.height-1);
    
    [imgMid drawAsPatternInRect:rect];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    
    self.contentMode=UIViewContentModeRedraw;
    
    return self;
}

@end
