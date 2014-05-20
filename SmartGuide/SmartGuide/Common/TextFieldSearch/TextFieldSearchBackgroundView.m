//
//  TextFieldSearchBackgroundView.m
//  Infory
//
//  Created by XXX on 5/19/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TextFieldSearchBackgroundView.h"

@implementation TextFieldSearchBackgroundView

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    self.contentMode=UIViewContentModeRedraw;
    self.backgroundColor=[UIColor clearColor];
    self.userInteractionEnabled=false;
    
    return self;
}

-(void)drawRect:(CGRect)rect
{
    float y=0;
    
    if(rect.size.height>38)
        y=(rect.size.height-38)/2;
    
    [[UIImage imageNamed:@"bg_search_left.png"] drawAtPoint:CGPointMake(0, y)];
    [[UIImage imageNamed:@"bg_search_mid.png"] drawAsPatternInRect:CGRectMake(19, y, rect.size.width-19-19, rect.size.height)];
    [[UIImage imageNamed:@"bg_search_right.png"] drawAtPoint:CGPointMake(rect.size.width-19, y)];
}

@end
