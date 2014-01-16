//
//  ShopDetailInfoHeaderView.m
//  SmartGuide
//
//  Created by MacMini on 23/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopDetailInfoHeaderView.h"

@implementation ShopDetailInfoHeaderView
@synthesize maxY;

-(ShopDetailInfoHeaderView *)initWithTitle:(NSString *)title
{
    self=[[NSBundle mainBundle] loadNibNamed:@"ShopDetailInfoHeaderView" owner:nil options:nil][0];
    
    maxY=-1;
    lbl.text=title;
    
    return self;
}

-(void)setTitle:(NSString *)title
{
    lbl.text=title;
}

+(float)height
{
    return 43;
}

+(NSString *)reuseIdentifier
{
    return @"ShopDetailInfoHeaderView";
}

-(void)setFrame:(CGRect)frame
{
    if(maxY!=-1)
        frame.origin.y=MIN(maxY,frame.origin.y);
    
    [super setFrame:frame];
}

@end
