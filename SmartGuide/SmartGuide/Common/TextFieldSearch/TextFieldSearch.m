//
//  TextFieldSearch.m
//  SmartGuide
//
//  Created by MacMini on 10/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TextFieldSearch.h"
#import "Utility.h"

@implementation TextFieldSearch

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    
    [self commonInit];
    
    return self;
}

-(void) commonInit
{
    TextFieldBGView *bg=[[TextFieldBGView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    bgView=bg;
    
    [self addSubview:bg];
    [self sendSubviewToBack:bg];
    UIImageView *imgv=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 38, self.frame.size.height)];
    imgv.image=[UIImage imageNamed:@"icon_search.png"];
    imgv.contentMode=UIViewContentModeCenter;
    
    UIView *lv=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 38, self.l_v_h)];
    lv.backgroundColor=[UIColor clearColor];
    [lv addSubview:imgv];
    
    self.leftView=lv;
    self.leftViewMode=UITextFieldViewModeAlways;
    
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 36, 21)];
    [btn setImage:[UIImage imageNamed:@"button_close_search.png"] forState:UIControlStateNormal];
    btn.hidden=self.text.length==0;
    
    btn.contentMode=UIViewContentModeLeft;
    self.rightView=btn;
    self.rightViewMode=UITextFieldViewModeAlways;
    
    [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.textAlignment=NSTextAlignmentLeft;
    
    self.textColor=[UIColor colorWithRed:91.f/225 green:91.f/255 blue:91.f/255 alpha:1];
    
    [self addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    
    self.background=nil;
    self.borderStyle=UITextBorderStyleNone;
    
    self.font=[UIFont fontWithName:@"Avenir-Roman" size:14];
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    frame.origin=CGPointZero;
    bgView.frame=frame;
}

-(void) textChanged:(UITextField*) txt
{
    self.rightView.hidden=self.text.length==0;
}

-(void) btn:(UIButton*) btn
{
    self.text=@"";
    [self sendActionsForControlEvents:UIControlEventEditingChanged];
}

-(void)setAngle:(float)angle
{
    if(_isRefresh)
        return;
    
    UIImageView *imgv=(UIImageView*)self.leftView.subviews[0];

    if(angle==-999)
    {
        imgv.image=[UIImage imageNamed:@"icon_search.png"];
        imgv.transform=CGAffineTransformIdentity;
    }
    else
    {
        imgv.image=[UIImage imageNamed:@"icon_refresh.png"];
        imgv.transform=CGAffineTransformMakeRotation(angle);
    }
}

-(void)startRefresh
{
    self.imgv.image=[UIImage imageNamed:@"icon_refresh_blue.png"];
    _isRefresh=true;
    self.imgv.transform=CGAffineTransformMakeRotation(0);
    [self rotate:M_PI*2];
}

-(void) rotate:(float) rotate
{
    if(!_isRefresh)
        return;
    
    __weak TextFieldSearch *wSelf=self;
    
    [UIView animateWithDuration:0.15f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.imgv.transform=CGAffineTransformMakeRotation(rotate);
    } completion:^(BOOL finished) {
        if(_isRefresh && wSelf)
            [wSelf rotate:rotate+M_PI/4];
    }];
}

-(void)stopRefresh:(void (^)())onCompleted
{
    _isRefresh=false;
    
    if(!onCompleted)
        return;
    
    UIImage *doneImage=[UIImage imageNamed:@"icon_refresh_done.png"];
    UIImageView *imgvDone=[[UIImageView alloc] initWithImage:doneImage];
    imgvDone.frame=CGRectMake(self.l_v_x-(doneImage.size.width-self.l_v_w)/2, self.l_v_y-(doneImage.size.height-self.l_v_h)/2, doneImage.size.width, doneImage.size.height);
    imgvDone.alpha=0;
    
    [self.superview addSubview:imgvDone];
    
    [UIView animateWithDuration:0.3f animations:^{
        imgvDone.transform=CGAffineTransformMakeScale(1.2f, 1.2f);
        imgvDone.alpha=1;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3f animations:^{
            imgvDone.transform=CGAffineTransformMakeScale(1, 1);
            imgvDone.alpha=0;
        } completion:^(BOOL finished) {
            [imgvDone removeFromSuperview];
            
            [self setAngle:-999];
            
            if(onCompleted)
                onCompleted();
        }];
    }];
}

-(UIImageView*) imgv
{
    return (UIImageView*)self.leftView.subviews[0];
}

-(void)removeFromSuperview
{
    [self stopRefresh:nil];
    
    [super removeFromSuperview];
}

@end

@implementation TextFieldBGView

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    self.contentMode=UIViewContentModeRedraw;
    self.backgroundColor=[UIColor clearColor];
    self.userInteractionEnabled=false;
    
    return self;
}

-(void)drawRect:(CGRect)rect
{
    float y=0;
    
    if(rect.size.height>38)
        y=(rect.size.height-38)/2;
    
    [[UIImage imageNamed:@"bg_search_left.png"] drawAtPoint:CGPointMake(0, y)];
    [[UIImage imageNamed:@"bg_search_mid.png"] drawAsPatternInRect:CGRectMake(19, y, rect.size.width-19-19, rect.size.height)];
    [[UIImage imageNamed:@"bg_search_right.png"] drawAtPoint:CGPointMake(rect.size.width-19, y)];
}

@end