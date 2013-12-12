//
//  ButtonLove.m
//  ButtonLove
//
//  Created by MacMini on 12/12/2013.
//  Copyright (c) 2013 MacMini. All rights reserved.
//

#import "ButtonLove.h"

#define BUTTON_LOVE_IMAGE_LOVE [UIImage imageNamed:@"button_love.png"]
#define BUTTON_LOVE_IMAGE_LOVE_HOVER [UIImage imageNamed:@"icon_love.png"]
#define BUTTON_LOVE_IMAGE_LEFT [UIImage imageNamed:@"button_love_release_left.png"]
#define BUTTON_LOVE_IMAGE_RIGHT [UIImage imageNamed:@"button_love_release_right.png"]
#define BUTTON_LOVE_IMAGE_MID [UIImage imageNamed:@"button_love_release_mid.png"]

@implementation ButtonLove
@synthesize isLoved;

- (id)init
{
    self = [[NSBundle mainBundle] loadNibNamed:@"ButtonLove" owner:nil options:nil][0];
    if (self) {
        isLoved=false;
        midView.backgroundColor=[UIColor colorWithPatternImage:BUTTON_LOVE_IMAGE_MID];
        
        _leftFrame=imgvLeft.frame;
        _midFrame=midView.frame;
        _rightFrame=imgvRight.frame;
        _buttonFrame=btnLove.frame;
        _lblTopFrame=lblTop.frame;
        _lblBotFrame=lblBot.frame;
    }
    return self;
}

-(IBAction) btnLoveTouchUpInside:(id)sender
{
    if(self.isLoved)
        [self unlove];
    else
        [self love];
}

-(void) love
{
    isLoved=true;
    
    [self setNeedsLayout];
    
    [btnLove setImage:BUTTON_LOVE_IMAGE_LOVE_HOVER forState:UIControlStateNormal];
    [btnLove setImage:BUTTON_LOVE_IMAGE_LOVE_HOVER forState:UIControlStateSelected];
    [btnLove setImage:BUTTON_LOVE_IMAGE_LOVE_HOVER forState:UIControlStateHighlighted];
    
    [UIView animateWithDuration:0.3f animations:^{
        
        CGRect rect=btnLove.frame;
        rect.origin.x=0;
        btnLove.frame=rect;
        
        rect=imgvLeft.frame;
        rect.origin.x=0;
        imgvLeft.frame=rect;
        
        rect=midView.frame;
        rect.origin.x=imgvLeft.frame.size.width;
        rect.size.width=self.frame.size.width-imgvRight.frame.size.width-imgvLeft.frame.size.width;
        midView.frame=rect;
        
        rect=lblTop.frame;
        rect.origin.x=7;
        lblTop.frame=rect;
        lblTop.textColor=[UIColor whiteColor];
        
        rect=lblBot.frame;
        rect.origin.x=7;
        lblBot.frame=rect;
        lblBot.textColor=[UIColor whiteColor];
        
    } completion:^(BOOL finished) {
    }];
}

-(void) unlove
{
    isLoved=false;
    
    [self setNeedsLayout];
    
    [UIView animateWithDuration:0.3f animations:^{
        
        btnLove.frame=_buttonFrame;
        imgvLeft.frame=_leftFrame;
        midView.frame=_midFrame;
        lblTop.frame=_lblTopFrame;
        lblTop.textColor=[UIColor darkGrayColor];
        lblBot.frame=_lblBotFrame;
        lblBot.textColor=[UIColor darkGrayColor];
    } completion:^(BOOL finished) {
        
        [btnLove setImage:BUTTON_LOVE_IMAGE_LOVE forState:UIControlStateNormal];
        [btnLove setImage:BUTTON_LOVE_IMAGE_LOVE_HOVER forState:UIControlStateSelected];
        [btnLove setImage:BUTTON_LOVE_IMAGE_LOVE_HOVER forState:UIControlStateHighlighted];
    }];
}

-(void)setIsLoved:(bool)_isLoved
{
    if(isLoved==_isLoved)
        return;
    
    isLoved=_isLoved;
    
    if(isLoved)
        [self love];
    else
        [self unlove];
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view=[super hitTest:point withEvent:event];
    
    if(view==self)
        return btnLove;
    
    return view;
}

-(void)setNumOfLove:(NSString *)numOfLove
{
    lblTop.text=numOfLove;
}

@end
