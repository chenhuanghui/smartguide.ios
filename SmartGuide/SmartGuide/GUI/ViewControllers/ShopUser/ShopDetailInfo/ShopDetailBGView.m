//
//  ShopDetailBGView.m
//  Infory
//
//  Created by XXX on 6/23/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopDetailBGView.h"

@implementation ShopDetailBGView

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    self.contentMode=UIViewContentModeRedraw;
    self.backgroundColor=[UIColor clearColor];
    self.hidden=true;
    
    return self;
}

-(void)drawRect:(CGRect)rect
{
    if(!imgMid)
    {
        imgTop=[UIImage imageNamed:@"bg_detail_placelist_header.png"];
        imgMid=[UIImage imageNamed:@"bg_detail_info_mid.png"];
        imgBottom=[UIImage imageNamed:@"bg_detail_info_bottom.png"];
    }
    
    [imgTop drawInRect:CGRectMake(0, 0, imgTop.size.width, imgTop.size.height)];
    [imgBottom drawAtPoint:CGPointMake(0, rect.size.height-imgTop.size.height)];
    
    rect.origin.y=imgTop.size.height;
    rect.origin.x=0;
    rect.size.height-=(imgTop.size.height+imgBottom.size.height-1);
    
    [imgMid drawAsPatternInRect:rect];
}

@end