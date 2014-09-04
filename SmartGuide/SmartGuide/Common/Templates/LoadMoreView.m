//
//  LoadMoreView.m
//  Infory
//
//  Created by XXX on 8/26/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "LoadMoreView.h"
#import "ImageManager.h"

@implementation LoadMoreView

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    self.autoresizesSubviews=false;
    self.backgroundColor=[UIColor clearColor];
    
    frame.origin=CGPointZero;
    UIImageView *imgv=[[UIImageView alloc] initWithFrame:frame];
    imgv.contentMode=UIViewContentModeCenter;
    imgv.animationImages=[ImageManager sharedInstance].loadingImagesSmall;
    imgv.animationDuration=0.7f;
    
    [self addSubview:imgv];
    
    _imgv=imgv;
    
    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    frame.origin=CGPointZero;
    
    if(_imgv)
        _imgv.frame=frame;
}

-(void)startAnimating
{
    [_imgv startAnimating];
}

-(void)stopAnimating
{
    [_imgv stopAnimating];
}

@end

#import <objc/runtime.h>
static char LoadMoreViewKey;
@implementation UIView(LoadMoreView)

-(LoadMoreView *)loadMoreView
{
    return objc_getAssociatedObject(self, &LoadMoreViewKey);
}

-(void)setLoadMoreView:(LoadMoreView *)loadMoreView
{
    objc_setAssociatedObject(self, &LoadMoreViewKey, loadMoreView, OBJC_ASSOCIATION_ASSIGN);
}

-(void)showLoadMore
{
    [self showLoadMoreInRect:(CGRect){CGPointZero, self.frame.size}];
}

-(void)showLoadMoreInRect:(CGRect)rect
{
    if(self.loadMoreView)
    {
        self.loadMoreView.frame=rect;
        [self.loadMoreView stopAnimating];
        [self.loadMoreView startAnimating];
        return;
    }
    
    LoadMoreView *view=[[LoadMoreView alloc] initWithFrame:rect];
    
    [view startAnimating];
    
    [self addSubview:view];
    
    self.loadMoreView=view;
}

-(void)removeLoadMore
{
    if(self.loadMoreView)
    {
        [self.loadMoreView stopAnimating];
        [self.loadMoreView removeFromSuperview];
        self.loadMoreView=nil;
    }
}

@end