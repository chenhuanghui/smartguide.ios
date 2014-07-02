//
//  PeekTitleView.m
//  PeakTitleView
//
//  Created by XXX on 7/2/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import "PeekTitleView.h"
#import "Constant.h"

@interface PeekTitleView()<UIScrollViewDelegate>

@end

@implementation PeekTitleView

- (instancetype)init
{
    self = [[NSBundle mainBundle] loadNibNamed:@"PeekTitleView" owner:nil options:nil][0];
    if (self) {
        _titles=[NSMutableArray new];
    }
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
    [scroll.panGestureRecognizer requireGestureRecognizerToFail:tap];
    
    scroll.scrollEnabled=false;
    
    return self;
}

-(int) currentIndex
{
    return scroll.contentOffset.x/scroll.frame.size.width;
}

-(void) scrollToIndex:(int) index
{
    [self scrollToIndex:index animate:true];
}

-(void) scrollToIndex:(int) index animate:(BOOL) animate
{
    if(index<0 || index>=_titles.count)
        return;
    
    [scroll setContentOffset:CGPointMake(index*scroll.frame.size.width, 0) animated:animate];
}

-(void) scrollNextIndex
{
    [self scrollToIndex:self.currentIndex+1];
}

-(void) scrollPreviousIndex
{
    [self scrollToIndex:self.currentIndex-1];
}

-(void) tap:(UITapGestureRecognizer*) tap
{
    float w3=self.frame.size.width/3;
    CGPoint pnt=[tap locationInView:self];
    
    if(pnt.x<w3)
        [self scrollPreviousIndex];
    else if(pnt.x>w3*2)
        [self scrollNextIndex];
    else
        [self scrollToIndex:self.currentIndex];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self.delegate peekTitleView:self touchedIndex:self.currentIndex];
}

-(void)addTitle:(NSString *)title
{
    [_titles addObject:title];
    
    [self makeLayout];
}

-(void)addTitles:(NSArray *)titles
{
    [_titles addObjectsFromArray:titles];
    
    [self makeLayout];
}

-(void)setTitleIndex:(int)index animate:(bool)animate
{
    [self scrollToIndex:index animate:animate];
}

-(void) makeLayout
{
    [scroll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGRect rect=scroll.frame;
    rect.origin=CGPointZero;
    for(NSString *title in _titles)
    {
        rect.size.width=scroll.frame.size.width;
        UIButton *btn=[[UIButton alloc] initWithFrame:rect];
        
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:COLOR_TEXT_HEADLINE_CONTENT forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont fontWithName:@"AvenirNext-DemiBold" size:15];
        btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
        btn.userInteractionEnabled=false;
        
        [scroll addSubview:btn];
        
        rect.origin.x+=scroll.frame.size.width;
    }
    
    scroll.contentSize=CGSizeMake(scroll.frame.size.width*_titles.count, scroll.contentSize.height);
}

@end

@implementation PeekTouchView

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view=[super hitTest:point withEvent:event];
    
    if(view==self)
    {
        return self.receiveView;
    }
    
    return view;
}

@end

@implementation ScrollPeek

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

@end