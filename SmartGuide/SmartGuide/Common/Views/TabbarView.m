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
    self.imgvBackground.image=[[UIImage imageNamed:@"bg_nav.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    self.imgvBackground.transform=CGAffineTransformMakeScale(1, 1.02f);
}

@end
