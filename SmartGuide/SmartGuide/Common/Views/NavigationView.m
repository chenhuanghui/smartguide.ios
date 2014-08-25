//
//  NavigationView.m
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "NavigationView.h"
#import "Constant.h"

@implementation NavigationView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self settings];
}

-(void) settings
{
    self.frame=CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, 55);
    self.autoresizingMask=UIViewAutoresizingNone;
    self.backgroundColor=[UIColor clearColor];
    self.autoresizesSubviews=false;
    self.clipsToBounds=false;
    
    UIImageView *imgv=[[UIImageView alloc] initWithFrame:CGRectMake(-5, -6, 330, self.frame.size.height+10)];
    
    imgv.image=[[UIImage imageNamed:@"bg_nav.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    imgv.transform=CGAffineTransformMakeScale(1, 1.02f);
    
    if(self.subviews.count==0)
        [self addSubview:imgv];
    else
        [self insertSubview:imgv atIndex:0];
    
    _imgvBackground=imgv;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if(_imgvBackground)
        [self sendSubviewToBack:_imgvBackground];
}

@end

@implementation NavigationTitleLabel

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.font=FONT_SIZE_MEDIUM(14);
}

@end