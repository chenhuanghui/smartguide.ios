//
//  Scroller.m
//  SmartGuide
//
//  Created by MacMini on 27/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "Scroller.h"
#import "Utility.h"
#import "Constant.h"

@implementation Scroller
@synthesize delegate,hidden;

-(Scroller *)init
{
    self=[super init];
    
    return self;
}

-(void)setIcon:(UIImage *)icon
{
    _icon=icon;
}

-(void)setText:(NSString *)text prefix:(NSString *)prefix
{
    CGSize size=[text sizeWithFont:lbl.font];
    
    size.height=lbl.l_v_h;
    
    lbl.text=text;
    
    [UIView animateWithDuration:0.1 animations:^{
        [bgView l_v_setX:(bgView.l_v_w-size.width)-imgv.image.size.width-8];
    } completion:^(BOOL finished) {
        lbl.text=text;
    }];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"observeValueForKeyPath %@ %@ %@",keyPath,object,change);
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(!_scrollBar)
        _scrollBar=[scrollView scrollBar];
    
    if(!_scrollBar)
        return;
    
    if(!view)
    {
        _scrollBar.clipsToBounds=false;
        
        [_scrollBar addObserver:self forKeyPath:@"alpha" options:NSKeyValueObservingOptionNew context:nil];
        [_scrollBar addObserver:self forKeyPath:@"hidden" options:NSKeyValueObservingOptionNew context:nil];
        
        UIView *v=[[UIView alloc] initWithFrame:CGRectMake(-319, 0, 320, 29)];
        v.layer.masksToBounds=true;
        v.backgroundColor=[UIColor clearColor];
        v.hidden=self.hidden;
        
        view=v;
        
        UIView *bg=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 29)];
        bg.backgroundColor=[UIColor clearColor];
        
        bgView=bg;
        
        [v addSubview:bg];
        
        UIImageView *slide_head=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgslide_head.png"]];
        slide_head.frame=CGRectMake(0, 0, 30, 29);
        slide_head.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin;
        
        [bg addSubview:slide_head];
        
        UIView *slide_mid=[[UIView alloc] initWithFrame:CGRectMake(slide_head.l_v_w, 0, bg.l_v_w-slide_head.l_v_w, bg.l_v_h)];
        slide_mid.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgslide_mid.png"]];
        
        [bg addSubview:slide_mid];
        
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(-1, 0, 320, 29)];
        label.textAlignment=NSTextAlignmentRight;
        label.backgroundColor=[UIColor clearColor];
        label.textColor=[UIColor whiteColor];
        label.font=[UIFont systemFontOfSize:12];
        label.autoresizingMask=UIViewAutoresizingNone;
        
        lbl=label;
        
        [v addSubview:label];
        
        UIImageView *imageView=[[UIImageView alloc] initWithImage:_icon];
        imageView.contentMode=UIViewContentModeLeft;
        imageView.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin;
        imageView.frame=bg.frame;
        [imageView l_v_addX:3];
        
        [bg addSubview:imageView];
        
        imgv=imageView;
        
        [_scrollBar addSubview:view];
        
        [bgView l_v_setX:view.l_v_w];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.bounds;
    CGSize size = scrollView.contentSize;
    UIEdgeInsets inset = scrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    
    float maxOffsetY=h-bounds.size.height;
    
    float perOffsetY=(offset.y/maxOffsetY);
    
    y=_scrollBar.l_v_h*perOffsetY;
    
    y=MAX(view.l_v_h, y);
    y=MIN(231-view.l_v_h*2,y);
    
    [view l_v_setY:y];
}

-(CGPoint)center
{
    return CGPointMake(0, view.l_v_y);
}

-(UIImageView *)scrollBar
{
    return _scrollBar;
}

-(CGSize)size
{
    return view.l_v_s;
}

-(UIView *)view
{
    return view;
}

-(void)setHidden:(bool)_hidden
{
    hidden=_hidden;
    
    view.hidden=hidden;
}

-(bool)hidden
{
    return hidden;
}

@end
