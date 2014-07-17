//
//  ShopDetailInfoHeaderView.m
//  SmartGuide
//
//  Created by MacMini on 23/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopDetailInfoHeaderView.h"

@implementation ShopDetailInfoHeaderView

-(ShopDetailInfoHeaderView *)initWithTitle:(NSString *)title
{
    self=[[NSBundle mainBundle] loadNibNamed:@"ShopDetailInfoHeaderView" owner:nil options:nil][0];
    
    self.maxY=-1;

    lbl.text=title;
    
    return self;
}

-(void)setTitle:(NSString *)title
{
    lbl.text=title;
}

+(float)height
{
    return 38;
}

+(NSString *)reuseIdentifier
{
    return @"ShopDetailInfoHeaderView";
}

-(void)setFrame:(CGRect)frame
{
    if(frame.origin.y<self.originFrame.origin.y+self.offsetY)
        frame.origin.y=self.originFrame.origin.y;
    else
        frame.origin.y=MIN(self.maxY,frame.origin.y-self.offsetY);
    
    [super setFrame:frame];
}

@end
