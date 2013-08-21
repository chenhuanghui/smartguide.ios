//
//  NavigationTitleView.m
//  SmartGuide
//
//  Created by XXX on 7/23/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "NavigationTitleView.h"

@implementation NavigationTitleView

-(NavigationTitleView *)initWithTitle:(NSString *)title withTarget:(id)target withAction:(SEL)selector
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"NavigationTitleView" owner:nil options:nil] objectAtIndex:0];
    
    lbl.text=title;
    
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

-(void)setTitle:(NSString *)title
{
    if(title)
        lbl.text=title;
    else
        lbl.text=@"";
    
    [self align];
}

-(void) align
{
    [lbl sizeToFit];
    
    CGRect rect=lbl.frame;
    rect.origin=CGPointZero;
    CGSize size=[lbl.text sizeWithFont:lbl.font constrainedToSize:CGSizeMake(320, 44)];
    rect.size.width=size.width;
    rect.size.height=44;
    lbl.frame=rect;

//    rect.size.height=14;
//    rect.origin.y=30;
//    btn.frame=rect;
    
    rect.size.height=44;
    self.frame=rect;
    self.center=CGPointMake(160, 22);
    
    btn.hidden=true;
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [self align];
    
    [super willMoveToSuperview:newSuperview];
}

@end
