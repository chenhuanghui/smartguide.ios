//
//  DrawXXX.m
//  DrawSort
//
//  Created by MacMini on 26/11/2013.
//  Copyright (c) 2013 MacMini. All rights reserved.
//

#import "ShopListSortView.h"

@interface ShopListSortView()
{
    UIImage *_icon;
    NSString *_text;
}

@end

@implementation ShopListSortView
@synthesize delegate;

-(void)setIcon:(UIImage *)icon text:(NSString *)text
{
    _icon=icon;
    _text=[NSString stringWithString:text];
    
    [self setNeedsDisplay];
}

-(void)setText:(NSString *)text
{
    _text=[NSString stringWithString:text];
    
    [self setNeedsDisplay];
}

/*
 Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.
 */

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    if(_text.length==0)
        return;
    
    UIImage *smallmid=[UIImage imageNamed:@"bgsort_smallmid.png"];
    UIImage *bgSortLeft=[UIImage imageNamed:@"bgsort_left.png"];
    UIImage *bgSortRight=[UIImage imageNamed:@"bgsort_right.png"];
    UIImage *bgtallMid=[UIImage imageNamed:@"bgsort_tallmid.png"];
    float fontSize=12;
    UIFont *font=[UIFont fontWithName:@"Avenir" size:fontSize];
    float textWidth=[_text sizeWithFont:font].width+5;

    CGPoint sortLeft=CGPointMake(26, 0);
    CGRect smallMidLeft=CGRectMake(0, 0, sortLeft.x, smallmid.size.height);
    CGRect tallMid=CGRectMake(sortLeft.x+bgSortLeft.size.width, 0, textWidth+3, bgtallMid.size.height);
    CGPoint sortRight=CGPointMake(tallMid.origin.x+tallMid.size.width, 0);
    CGPoint icon=CGPointMake(sortLeft.x+21, 8);
    CGPoint text=CGPointMake(icon.x+_icon.size.width+4, icon.y-2);
    CGRect smallMidRight=CGRectMake(sortRight.x+bgSortRight.size.width, smallMidLeft.origin.y, 0, smallmid.size.height);
    smallMidRight.size.width=rect.size.width-smallMidRight.origin.x;
    
    _touchedArea=CGRectMake(icon.x, 0, sortRight.x-icon.x, 22);
    
    [smallmid drawAsPatternInRect:smallMidLeft];
    [bgSortLeft drawAtPoint:sortLeft];
    [bgtallMid drawAsPatternInRect:tallMid];
    [bgSortRight drawAtPoint:sortRight];
    [smallmid drawAsPatternInRect:smallMidRight];

    [_icon drawAtPoint:icon];
    
    [[UIColor whiteColor] set];
    [_text drawAtPoint:CGPointMake(text.x, text.y+0.5f) withFont:font];
    
    [[UIColor blackColor] set];
    [_text drawAtPoint:text withFont:font];
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    point=[self convertPoint:point toView:self];
    return CGRectContainsPoint(_touchedArea, point);
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate sortViewTouchedSort:self];
}

@end
