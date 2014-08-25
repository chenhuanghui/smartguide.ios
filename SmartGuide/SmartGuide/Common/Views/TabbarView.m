//
//  TabbarView.m
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TabbarView.h"

@implementation TabbarView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self settings];
}

-(void) settings
{
    UIImage *bgNav=[[UIImage imageNamed:@"bg_nav.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    UIImageView *imgv=[[UIImageView alloc] initWithImage:bgNav];
    imgv.frame=CGRectMake(-5, -6, 330, self.frame.size.height+10);
    imgv.transform=CGAffineTransformMakeScale(1, 1.02f);
    
    [self insertSubview:imgv atIndex:0];
    
    _imgvBackground=imgv;
}

-(void)layoutSubviews
{
    if(_imgvBackground)
        [self sendSubviewToBack:_imgvBackground];
}

@end
