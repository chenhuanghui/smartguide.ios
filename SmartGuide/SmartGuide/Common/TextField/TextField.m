//
//  TextField.m
//  Infory
//
//  Created by XXX on 5/21/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TextField.h"
#import "Utility.h"

@implementation TextField
@synthesize leftViewType, rightViewType;

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    [self textChanged:self];
}

-(void) textChanged:(id) sender
{
    switch (self.rightViewType) {
        case TEXTFIELD_RIGHTVIEW_CLEAR:
            self.rightView.hidden=self.text.length==0;
            break;
            
        case TEXTFIELD_RIGHTVIEW_NONE:
        case TEXTFIELD_RIGHTVIEW_LOCATION:
            break;
    }
}

-(void)setLeftViewType:(enum TEXTFIELD_LEFTVIEW_TYPE)leftViewType_
{
    leftViewType=leftViewType_;
    
    switch (leftViewType) {
        case TEXTFIELD_LEFTVIEW_SEARCH:
        {
            UIImageView *imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_search.png"]];
            imgv.contentMode=UIViewContentModeCenter;
            [imgv l_v_setS:CGSizeMake(38, 38)];
            self.leftView=imgv;
            self.leftViewMode=UITextFieldViewModeAlways;
        }
            break;
            
        case TEXTFIELD_LEFTVIEW_LOCATION:
        {
            UIImageView *imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_location.png"]];
            imgv.contentMode=UIViewContentModeCenter;
            [imgv l_v_setS:CGSizeMake(38, 38)];
            self.leftView=imgv;
            self.leftViewMode=UITextFieldViewModeAlways;
        }
            break;
            
        case TEXTFIELD_LEFTVIEW_NONE:
        {
            UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 38, 38)];
            view.backgroundColor=[UIColor clearColor];
            
            self.leftView=view;
            self.leftViewMode=UITextFieldViewModeAlways;
        }
            break;
    }
}

-(void) btnRightTouchUpInside:(id) sender
{
    if([self.delegate respondsToSelector:@selector(textFieldTouchedRightView:)])
        [self.delegate textFieldTouchedRightView:self];
}

-(void)setRightViewType:(enum TEXTFIELD_RIGHTVIEW_TYPE)rightViewType_
{
    rightViewType=rightViewType_;
    
    switch (rightViewType) {
        case TEXTFIELD_RIGHTVIEW_CLEAR:
        {
            UIImageView *imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_close_search.png"]];
            imgv.contentMode=UIViewContentModeCenter;
            [imgv l_v_setS:CGSizeMake(38, 38)];
            
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn l_v_setS:CGSizeMake(38, 38)];
            btn.backgroundColor=[UIColor clearColor];
            [btn addTarget:self action:@selector(btnRightTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
            
            UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 38, 38)];
            view.backgroundColor=[UIColor clearColor];
            
            [view addSubview:imgv];
            [view addSubview:btn];
            
            self.rightView=view;
            self.rightViewMode=UITextFieldViewModeAlways;
        }
            break;
            
        case TEXTFIELD_RIGHTVIEW_LOCATION:
        {
            UIImageView *imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_location.png"]];
            imgv.contentMode=UIViewContentModeCenter;
            [imgv l_v_setS:CGSizeMake(38, 38)];
            
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn l_v_setS:CGSizeMake(38, 38)];
            btn.backgroundColor=[UIColor clearColor];
            [btn addTarget:self action:@selector(btnRightTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
            
            UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 38, 38)];
            view.backgroundColor=[UIColor clearColor];
            
            [view addSubview:imgv];
            [view addSubview:btn];
            
            self.rightView=view;
            self.rightViewMode=UITextFieldViewModeAlways;
        }
            break;
            
        case TEXTFIELD_RIGHTVIEW_NONE:
        {
            UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 38, 38)];
            view.backgroundColor=[UIColor clearColor];
            
            self.rightView=view;
            self.rightViewMode=UITextFieldViewModeAlways;
        }
            break;
    }
}

@end

@implementation SearchTextField

-(enum TEXTFIELD_DISPLAY_TYPE)displayType
{
    return TEXTFIELD_DISPLAY_TYPE_SEARCH;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    UIImageView *imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_search_left.png"]];
    [imgv l_v_setS:CGSizeMake(19, 38)];
    imgv.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin;
    
    [self addSubview:imgv];
    
    imgvLeft=imgv;
    
    UIView *view=[[UIView alloc] init];
    view.frame=CGRectMake(19, 0, self.l_v_w-19*2, 38);
    view.contentMode=UIViewContentModeRedraw;
    view.autoresizesSubviews=false;
    view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_search_mid.png"]];
    view.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin;
    view.userInteractionEnabled=false;
    
    [self addSubview:view];
    
    midView=view;
    
    imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_search_right.png"]];
    imgv.frame=CGRectMake(self.l_v_w-19, 0, 19, 38);
    imgv.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin;
    
    [self addSubview:imgv];
    
    imgvRight=imgv;
}

@end