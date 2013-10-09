//
//  ActivityIndicator.m
//  SmartGuide
//
//  Created by XXX on 7/12/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ActivityIndicator.h"
#import "Utility.h"
#import <QuartzCore/QuartzCore.h>
#import "Constant.h"
#import <objc/runtime.h>

@implementation ActivityIndicator
@synthesize touchDelegate,delegate;
@synthesize countdown;
@synthesize tagID;

-(ActivityIndicator *)initWithTitle:(NSString *)title
{
    self=[super initWithFrame:CGRectZero];
    
    _indicatorTitle=[[NSString alloc] initWithString:title];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    UILabel* lbl=[[UILabel alloc] initWithFrame:CGRectZero];
    lbl.text=title;
    lbl.backgroundColor=[UIColor clearColor];
    lbl.textColor=[UIColor whiteColor];
    lbl.textAlignment=NSTextAlignmentCenter;
    
    UIView *blackView=[[UIView alloc] init];
    blackView.backgroundColor=COLOR_BACKGROUND_APP;
    
    [blackView.layer setMasksToBounds:YES];
    [blackView.layer setCornerRadius:8.0];
    [blackView.layer setBorderColor:[[UIColor clearColor] CGColor]];
    [blackView.layer setBorderWidth:1.0];
    
    blackView.tag=1;
    indicator.tag=2;
    lbl.tag=3;
    
    [indicator startAnimating];
    
    [self addSubview:blackView];
    [self addSubview:indicator];
    [self addSubview:lbl];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh:) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    return self;
}

-(void)setTitle:(NSString *)title
{
    if(_timerCountdown)
    {
        [_timerCountdown invalidate];
        _timerCountdown=nil;
    }
    
    _indicatorTitle=[[NSString alloc] initWithString:title];
    
    UILabel *lbl=(UILabel*)[self viewWithTag:3];
    
    lbl.text=[NSString stringWithStringDefault:title];
    
    [self alignLayout:self.superview];
}

-(void) refresh:(NSNotification*) notification
{
    UILabel *lbl=(UILabel*)[self viewWithTag:3];
    [lbl setNeedsDisplay];
}

-(void)removeFromSuperview
{
    [self.superview removeObserver:self forKeyPath:@"frame"];
    _indicatorTitle=nil;
    
    if(_timerCountdown)
    {
        [_timerCountdown invalidate];
        _timerCountdown=nil;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [((UIActivityIndicatorView*)[self viewWithTag:2]) stopAnimating];
    
    [[self viewWithTag:1] removeFromSuperview];
    [[self viewWithTag:2] removeFromSuperview];
    [[self viewWithTag:3] removeFromSuperview];
    
    [super removeFromSuperview];
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    if(newSuperview)
    {
        [self alignLayout:newSuperview];
        [self startAnimation];
        
        UIActivityIndicatorView *indicator=(UIActivityIndicatorView*)[self viewWithTag:2];
        
        if(newSuperview.backgroundColor==[UIColor whiteColor])
        {
            indicator.color=[UIColor blackColor];
        }
    }
    
    [super willMoveToSuperview:newSuperview];
}

-(void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    if(self.superview)
    {
        [self.superview addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(self.superview)
    {
        self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.superview.frame.size.width, self.superview.frame.size.height);
        [self alignLayout:self.superview];
    }
}

-(void) alignLayout:(UIView*) newSuperview
{
    float alignX=20;
    
    self.layer.masksToBounds=true;
    
    UIView *blackView=(UIView*)[self viewWithTag:1];
    UIActivityIndicatorView *indicator=(UIActivityIndicatorView*)[self viewWithTag:2];
    UILabel *lbl=(UILabel*)[self viewWithTag:3];
    lbl.text=[NSString stringWithStringDefault:lbl.text];
    
    CGRect rect=self.frame;
    
    lbl.frame=rect;
    lbl.center=CGPointMake(lbl.center.x+alignX, lbl.center.y);
    
    CGSize size=[lbl.text sizeWithFont:lbl.font];
    
    if(newSuperview.frame.size.height<37 || newSuperview.frame.size.width<37)
        [indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    else
        [indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    indicator.frame=CGRectMake(0, 0, 37, 37);
    indicator.center=CGPointMake(rect.size.width/2-size.width/2-indicator.frame.size.width/2, rect.size.height/2);
    indicator.center=CGPointMake(indicator.center.x+alignX, indicator.center.y);
    
    rect=indicator.frame;
    
    rect.origin.x-=17;
    rect.origin.y-=17;
    rect.size.width+=34;
    rect.size.height+=34;
    
    blackView.frame=rect;
}

-(void)alignRect:(CGRect)rectAlign
{
    float alignX=20;
    
    self.layer.masksToBounds=true;
    
    UIView *blackView=(UIView*)[self viewWithTag:1];
    UIActivityIndicatorView *indicator=(UIActivityIndicatorView*)[self viewWithTag:2];
    UILabel *lbl=(UILabel*)[self viewWithTag:3];
    lbl.text=[NSString stringWithStringDefault:lbl.text];
    
    CGRect rect=self.frame;
    
    lbl.frame=rect;
    lbl.center=CGPointMake(lbl.center.x+alignX, lbl.center.y);
    
    CGSize size=[lbl.text sizeWithFont:lbl.font];
    
    if(rectAlign.size.height<37 || rectAlign.size.width<37)
        [indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    else
        [indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    indicator.frame=CGRectMake(0, 0, 37, 37);
    indicator.center=CGPointMake(rect.size.width/2-size.width/2-indicator.frame.size.width/2, rect.size.height/2);
    indicator.center=CGPointMake(indicator.center.x+alignX, indicator.center.y);
    
    rect=indicator.frame;
    
    rect.origin.x-=17;
    rect.origin.y-=17;
    rect.size.width+=34;
    rect.size.height+=34;
    
    blackView.frame=rect;
}

-(void)startAnimation
{
    //    self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3f];
    //
    //    [UIView animateWithDuration:0.5f animations:^{
    //        self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7f];
    //    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(touchDelegate && [touchDelegate respondsToSelector:@selector(touchesBegan:withEvent:)])
        [touchDelegate touchesBegan:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(touchDelegate && [touchDelegate respondsToSelector:@selector(touchesMoved:withEvent:)])
        [touchDelegate touchesMoved:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(touchDelegate && [touchDelegate respondsToSelector:@selector(touchesEnded:withEvent:)])
        [touchDelegate touchesEnded:touches withEvent:event];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(touchDelegate && [touchDelegate respondsToSelector:@selector(touchesCancelled:withEvent:)])
        [touchDelegate touchesCancelled:touches withEvent:event];
}

-(void)setCountdown:(int)_countdown
{
    countdown=_countdown;
    
    if(!_timerCountdown)
    {
        _timerCountdown=[NSTimer timerWithTimeInterval:1 target:self selector:@selector(loopCountdown) userInfo:nil repeats:true];
        [[NSRunLoop currentRunLoop] addTimer:_timerCountdown forMode:NSDefaultRunLoopMode];
    }
    
    UILabel *lbl=(UILabel*)[self viewWithTag:3];
    
    if(_indicatorTitle && _indicatorTitle.length>0)
        [lbl setText:[NSString stringWithFormat:@"%@ %i",_indicatorTitle,self.countdown]];
}

-(void) loopCountdown
{
    if(![NSThread isMainThread])
    {
        [self performSelectorOnMainThread:@selector(loopCountdown) withObject:nil waitUntilDone:true];
        return;
    }
    
    UILabel *lbl=(UILabel*)[self viewWithTag:3];
    
    if(_indicatorTitle && _indicatorTitle.length>0)
        [lbl setText:[NSString stringWithFormat:@"%@ %i",_indicatorTitle,self.countdown]];
    
    self.countdown--;
    
    if(self.countdown<0)
    {
        if(_timerCountdown)
        {
            [_timerCountdown invalidate];
            _timerCountdown=nil;
            
            if(delegate && [delegate respondsToSelector:@selector(activityIndicatorCountdownEnded:)])
                [delegate activityIndicatorCountdownEnded:self];
            
            [self removeFromSuperview];
        }
    }
}

@end

@implementation UIView(ActivityIndicator)


-(ActivityIndicator*) activityIndicator
{
    ActivityIndicator *indicator=nil;
    bool isFounded=false;
    for(indicator in self.subviews)
    {
        if([indicator isKindOfClass:[ActivityIndicator class]])
        {
            isFounded=true;
            break;
        }
    }
    
    if(isFounded)
        return indicator;
    
    return nil;
}

-(ActivityIndicator*)showLoadingWithTitle:(NSString *)title
{
    NSString *msg=@"";
    if(title.length>0)
        msg=[@"  " stringByAppendingString:[NSString stringWithStringDefault:title]];
    
    [self removeLoading];
    
    ActivityIndicator *indicator=(ActivityIndicator*)[self viewWithTag:3333];
    
    if(!indicator)
    {
        indicator=[[ActivityIndicator alloc] initWithTitle:msg];
        indicator.tag=3333;
    }
    else
        [indicator setTitle:msg];
    
    CGRect rect=self.frame;
    rect.origin=CGPointZero;
    [indicator setFrame:rect];
    indicator.layer.cornerRadius=self.layer.cornerRadius;
    
    [self addSubview:indicator];
    
    return indicator;
}

-(ActivityIndicator *)showLoadingWithTitle:(NSString *)title countdown:(int)countdown delegate:(id<ActivityIndicatorDelegate>)delegate
{
    ActivityIndicator *indicator=[self showLoadingWithTitle:title];
    indicator.delegate=delegate;
    indicator.countdown=countdown;
    
    return indicator;
}

-(void)removeLoading
{
    while ((ActivityIndicator*)[self viewWithTag:3333])
    {
        [[self viewWithTag:3333] removeFromSuperview];
    }
}

-(void)centerActivityIndicator:(CGRect)rect
{
    ActivityIndicator *act=[self activityIndicator];
    
    if(act)
    {
        [act alignRect:rect];
    }
}

@end