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
    
    lbl.text=title;
    
    return self;
}

-(void)setTitle:(NSString *)title
{
    lbl.text=title;
}

+(float)height
{
    return 35;
}

@end
