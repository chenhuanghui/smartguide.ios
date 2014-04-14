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
    
    self.leftView=imgv;
    self.leftView.backgroundColor=[UIColor clearColor];
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
    UIImageView *imgv=(UIImageView*)self.leftView;
    NSLog(@"angle %f",angle);
    if(angle==-1)
    {
        imgv.image=[UIImage imageNamed:@"icon_search.png"];
        imgv.frame=CGRectMake(0, 0, 38, self.frame.size.height);
        imgv.transform=CGAffineTransformIdentity;
        imgv.contentMode=UIViewContentModeCenter;
    }
    else
    {
        imgv.image=[UIImage imageNamed:@"icon_refresh_new.png"];
//        imgv.contentMode=UIViewContentModeScaleAspectFit;
        imgv.transform=CGAffineTransformMakeRotation(angle);
        imgv.frame=CGRectMake(0, 0, 18, 18);
    }
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