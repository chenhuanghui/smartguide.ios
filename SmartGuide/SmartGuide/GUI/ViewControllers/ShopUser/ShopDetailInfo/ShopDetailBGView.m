//
//  ShopDetailBGView.m
//  Infory
//
//  Created by XXX on 6/23/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopDetailBGView.h"
#import "Utility.h"

@implementation ShopDetailBGView

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    self.backgroundColor=[UIColor clearColor];
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-5)];
    view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_detail_info_mid.png"]];
    view.userInteractionEnabled=false;
    view.autoresizingMask=UIViewAutoresizingNone;
    
    [self addSubview:view];
    
    UIImageView *imgv=[[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height-5, frame.size.width, 5)];
    imgv.image=[UIImage imageNamed:@"bg_detail_info_bottom.png"];
    imgv.autoresizingMask=UIViewAutoresizingNone;
    
    [self addSubview:imgv];
    
    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    if(self.subviews.count>1)
    {
        [self.subviews[0] l_v_setH:frame.size.height-5];
        [self.subviews[1] l_v_setY:frame.size.height-5];
    }
}

@end