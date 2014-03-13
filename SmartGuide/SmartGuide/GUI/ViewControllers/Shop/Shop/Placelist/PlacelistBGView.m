//
//  PlacelistBGView.m
//  SmartGuide
//
//  Created by MacMini on 14/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "PlacelistBGView.h"

@implementation PlacelistBGView

-(void)drawRect:(CGRect)rect
{
    [imgTop drawInRect:CGRectMake(0, 0, imgTop.size.width, imgTop.size.height)];
    [imgBottom drawAtPoint:CGPointMake(0, rect.size.height-imgTop.size.height)];
    
    rect.origin.y=imgTop.size.height;
    rect.origin.x=0;
    rect.size.height-=(imgTop.size.height+imgBottom.size.height-1);
    
    [imgMid drawAsPatternInRect:rect];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.contentMode=UIViewContentModeRedraw;
    self.backgroundColor=[UIColor clearColor];
    
    imgTop=[UIImage imageNamed:@"bg_detail_placelist_header.png"];
    imgMid=[UIImage imageNamed:@"bg_detail_info_mid.png"];
    imgBottom=[UIImage imageNamed:@"bg_detail_info_bottom.png"];
    
}

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    self.contentMode=UIViewContentModeRedraw;
    self.backgroundColor=[UIColor clearColor];
    
    imgTop=[UIImage imageNamed:@"bg_detail_placelist_header.png"];
    imgMid=[UIImage imageNamed:@"bg_detail_info_mid.png"];
    imgBottom=[UIImage imageNamed:@"bg_detail_info_bottom.png"];
    
    return self;
}

@end
