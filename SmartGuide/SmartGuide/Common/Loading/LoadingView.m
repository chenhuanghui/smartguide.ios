//
//  LoadingView.m
//  SmartGuide
//
//  Created by MacMini on 13/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "LoadingView.h"
#import "Utility.h"

@implementation LoadingView

-(LoadingView *)initWithView:(UIView *)view
{
    self=[super initWithFrame:view.frame];
    [self l_v_setO:CGPointZero];
    
    UIView *bg=[[UIView alloc] initWithFrame:self.frame];
    
    bg.backgroundColor=[UIColor blackColor];
    bg.alpha=0.3f;
    
    bgView=bg;
    
    [self addSubview:bg];
    
    UIActivityIndicatorView *indicator=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [indicator l_v_setS:self.l_v_s];
    
    indicator.autoresizingMask=UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
    
    [self addSubview:indicator];
    
    indicatorView=indicator;
    
    [view addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self l_v_setS:self.superview.l_v_s];
}

-(void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    if(self.superview)
    {
        [indicatorView startAnimating];
    }
}

-(void)removeFromSuperview
{
    [indicatorView stopAnimating];
    
    [self.superview removeObserver:self forKeyPath:@"frame" context:nil];
    
    [super removeFromSuperview];
}

-(UIView *)backgroundView
{
    return bgView;
}

-(UIActivityIndicatorView *)activityIndicatorView
{
    return indicatorView;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end

@implementation UIView(Loading)

-(void) showLoading
{
    for(UIView *view in self.subviews)
        if([view isKindOfClass:[LoadingView class]])
            return;
    
    NSLog(@"showLoading %@",NSStringFromClass([self class]));
    
    LoadingView *loading=[[LoadingView alloc] initWithView:self];
    
    [self addSubview:loading];
    
    [UIView animateWithDuration:0.15f animations:^{
        loading.backgroundView.alpha=0.7f;
    }];
}

-(void) removeLoading:(bool) animate
{
    NSLog(@"removeLoading %@",NSStringFromClass([self class]));
    
    UIView *view=nil;
    
    for(view in self.subviews)
    {
        if([view isKindOfClass:[LoadingView class]])
            break;
    }
    
    if([view isKindOfClass:[LoadingView class]])
    {
        if(animate)
        {
            view.userInteractionEnabled=false;
            [UIView animateWithDuration:0.15f animations:^{
                view.alpha=0;
            } completion:^(BOOL finished) {
                [view removeFromSuperview];
                [self removeLoading:animate];
            }];
        }
        else
        {
            [view removeFromSuperview];
            [self removeLoading:animate];
        }
    }
}

-(void)removeLoading
{
    [self removeLoading:true];
}

@end