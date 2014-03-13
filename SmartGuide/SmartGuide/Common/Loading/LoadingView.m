//
//  LoadingView.m
//  SmartGuide
//
//  Created by MacMini on 13/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "LoadingView.h"
#import "Utility.h"
#import <objc/runtime.h>
#import "ImageManager.h"


static char loadingViewKey;

@implementation LoadingView

-(LoadingView *)initWithView:(UIView *)view
{
    self=[super initWithFrame:view.frame];
    [self l_v_setO:CGPointZero];
    
    UIView *bg=[[UIView alloc] initWithFrame:self.frame];
    
    bg.backgroundColor=[UIColor blackColor];
    bg.alpha=0.3f;
    
    bg.autoresizingMask=UIViewAutoresizingAll();
    
    bgView=bg;
    
    [self addSubview:bg];
    
    UIImageView *imgv=[[UIImageView alloc] initWithImage:nil];
    [imgv l_v_setS:self.l_v_s];
    imgv.contentMode=UIViewContentModeCenter;
    
    imgv.autoresizingMask=UIViewAutoresizingAll();
    
    [self addSubview:imgv];
    
    imgv.animationDuration=DURATION_LOADING;
    imgv.animationImages=[ImageManager sharedInstance].loadingImages;
    imgv.animationRepeatCount=0;
    
    imgvLoading=imgv;

    self.autoresizingMask=UIViewAutoresizingAll();
    
    [view setLoadingView:self];
    
    return self;
}

-(void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    if(self.superview)
    {
        [imgvLoading startAnimating];
    }
}

-(void)removeFromSuperview
{
    [imgvLoading stopAnimating];

    [super removeFromSuperview];
}

-(UIView *)backgroundView
{
    return bgView;
}

@end

@implementation UIView(Loading)

-(LoadingView *)loadingView
{
    return objc_getAssociatedObject(self, &loadingViewKey);
}

-(void)setLoadingView:(LoadingView *)loadingView
{
    objc_setAssociatedObject(self, &loadingViewKey, loadingView, OBJC_ASSOCIATION_ASSIGN);
}

-(void) showLoading
{
    for(UIView *view in self.subviews)
        if([view isKindOfClass:[LoadingView class]])
            return;
    
    LoadingView *loading=[[LoadingView alloc] initWithView:self];
    
    [self addSubview:loading];
    
    [UIView animateWithDuration:0.15f animations:^{
        loading.backgroundView.alpha=0.7f;
    }];
}

-(void) removeLoading:(bool) animate
{
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
                [self setLoadingView:nil];
            }];
        }
        else
        {
            [view removeFromSuperview];
            [self setLoadingView:nil];
            [self removeLoading:animate];
        }
    }
}

-(void)removeLoading
{
    [self removeLoading:true];
}

-(void)showLoadingInsideFrame:(CGRect)rect
{
    [self showLoading];
    self.loadingView.frame=rect;
}

@end