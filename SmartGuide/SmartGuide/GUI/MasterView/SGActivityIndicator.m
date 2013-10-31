//
//  SGActivityIndicator.m
//  SmartGuide
//
//  Created by MacMini on 28/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGActivityIndicator.h"

#define ACTIVITY_INDICATOR_TAG 123

@implementation SGActivityIndicator
@synthesize activityIndicator;

-(SGActivityIndicator *)initWithView:(UIView *)view
{
    CGRect rect=view.frame;
    rect.origin=CGPointZero;
    
    self=[super initWithFrame:rect];
    
    rect.size=CGSizeMake(55, 55);
    activityIndicator=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.frame=rect;
    activityIndicator.center=CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    activityIndicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.7f];
    activityIndicator.layer.cornerRadius=8;
    
    [self addSubview:activityIndicator];
    
    return self;
}

-(void) didMoveToSuperview
{
    [super didMoveToSuperview];
    
    if(self.superview)
        [activityIndicator startAnimating];
}

-(void)removeFromSuperview
{
    [activityIndicator stopAnimating];
    activityIndicator=nil;
    
    [super removeFromSuperview];
}

@end

@implementation UIView(SGActivityIndicator)

-(void)SGShowLoading
{
    [self SGRemoveLoading];
    
    SGActivityIndicator *activity=[[SGActivityIndicator alloc] initWithView:self];
    activity.tag=ACTIVITY_INDICATOR_TAG;
    
    [self addSubview:activity];
}

-(void)SGRemoveLoading
{
    UIView *view=[self viewWithTag:ACTIVITY_INDICATOR_TAG];
    while (view) {
        [view removeFromSuperview];
        view=[self viewWithTag:ACTIVITY_INDICATOR_TAG];
    }
}

@end