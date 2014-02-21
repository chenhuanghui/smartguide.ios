//
//  TextFieldSearch.m
//  SmartGuide
//
//  Created by MacMini on 10/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TextFieldSearch.h"

@implementation TextFieldSearch

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    
    [self commonInit];
    
    return self;
}

-(void) commonInit
{
    self.background=[UIImage imageNamed:@"button_search_home.png"];
    
    self.leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, self.frame.size.height)];
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

@end
