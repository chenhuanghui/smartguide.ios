//
//  TextView.m
//  SmartGuide
//
//  Created by MacMini on 14/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TextView.h"
#import "Utility.h"

@implementation TextView
@synthesize placeholder,placeholderXY;

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.placeholderXY=CGPointMake(5, 0);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

-(void) textChanged:(NSNotification*) notification
{
    if(notification.object==self)
    {
        if(lblPlaceHolder)
        {
            lblPlaceHolder.hidden=self.text.length>0;
        }
    }
}

-(void)setPlaceholder:(NSString *)placeholder_
{
    placeholder=[placeholder_ copy];
    
    if(placeholder.length==0)
    {
        if(lblPlaceHolder)
        {
            [lblPlaceHolder removeFromSuperview];
            lblPlaceHolder=nil;
        }
    }
    else
    {
        if(!lblPlaceHolder)
        {
            UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
            
            lbl.textColor=[UIColor lightGrayColor];
            lbl.font=self.font;
            lbl.textAlignment=NSTextAlignmentLeft;
            
            [lbl l_v_setO:placeholderXY];
            
            lblPlaceHolder=lbl;
            
            [self addSubview:lbl];
        }
        
        lblPlaceHolder.text=placeholder;
    }
    
    if(lblPlaceHolder)
    {
        lblPlaceHolder.hidden=self.text.length>0;
    }
}

-(void)setText:(NSString *)text
{
    [super setText:text];
    
    if(lblPlaceHolder)
    {
        lblPlaceHolder.hidden=self.text.length>0;
    }
}

-(void)setPlaceholderXY:(CGPoint)placeholderXY_
{
    placeholderXY=placeholderXY_;
    
    if(lblPlaceHolder)
        [lblPlaceHolder l_v_setO:placeholderXY_];
}

@end
