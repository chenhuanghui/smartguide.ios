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
@synthesize loveStatus,delegate;

- (id)init
{
    self = [[NSBundle mainBundle] loadNibNamed:@"ButtonLove" owner:nil options:nil][0];
    if (self) {
        loveStatus=LOVE_STATUS_NONE;
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
    [self.delegate buttonLoveTouched:self];
}

-(void) love:(bool) animate
{
    loveStatus=LOVE_STATUS_LOVED;
    
    [btnLove setImage:BUTTON_LOVE_IMAGE_LOVE_HOVER forState:UIControlStateNormal];
    [btnLove setImage:BUTTON_LOVE_IMAGE_LOVE_HOVER forState:UIControlStateSelected];
    [btnLove setImage:BUTTON_LOVE_IMAGE_LOVE_HOVER forState:UIControlStateHighlighted];
    
    if(animate)
    {
        [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^{
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
        } completion:nil];
    }
    else
    {
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
    }
}

-(void) unlove:(bool) animate
{
    loveStatus=LOVE_STATUS_NONE;
    
    if(animate)
    {
        [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^{
            btnLove.frame=_buttonFrame;
            imgvLeft.frame=_leftFrame;
            midView.frame=_midFrame;
            lblTop.frame=_lblTopFrame;
            lblTop.textColor=[UIColor darkGrayColor];
            lblBot.frame=_lblBotFrame;
            lblBot.textColor=[UIColor darkGrayColor];
        } completion:^(BOOL finished) {
            
            if(finished)
            {
                [btnLove setImage:BUTTON_LOVE_IMAGE_LOVE forState:UIControlStateNormal];
                [btnLove setImage:BUTTON_LOVE_IMAGE_LOVE_HOVER forState:UIControlStateSelected];
                [btnLove setImage:BUTTON_LOVE_IMAGE_LOVE_HOVER forState:UIControlStateHighlighted];
            }
            else
            {
                [btnLove setImage:BUTTON_LOVE_IMAGE_LOVE_HOVER forState:UIControlStateNormal];
                [btnLove setImage:BUTTON_LOVE_IMAGE_LOVE_HOVER forState:UIControlStateSelected];
                [btnLove setImage:BUTTON_LOVE_IMAGE_LOVE_HOVER forState:UIControlStateHighlighted];
            }
        }];
    }
    else
    {
        btnLove.frame=_buttonFrame;
        imgvLeft.frame=_leftFrame;
        midView.frame=_midFrame;
        lblTop.frame=_lblTopFrame;
        lblTop.textColor=[UIColor darkGrayColor];
        lblBot.frame=_lblBotFrame;
        lblBot.textColor=[UIColor darkGrayColor];
        
        [btnLove setImage:BUTTON_LOVE_IMAGE_LOVE forState:UIControlStateNormal];
        [btnLove setImage:BUTTON_LOVE_IMAGE_LOVE_HOVER forState:UIControlStateSelected];
        [btnLove setImage:BUTTON_LOVE_IMAGE_LOVE_HOVER forState:UIControlStateHighlighted];
    }
}

-(void)setLoveStatus:(enum LOVE_STATUS)_loveStatus
{
    if(loveStatus==_loveStatus)
        return;
    
    loveStatus=_loveStatus;
    
    switch (loveStatus) {
        case LOVE_STATUS_LOVED:
            [self love:false];
            break;
            
        case LOVE_STATUS_NONE:
            [self unlove:false];
            break;
    }
}

-(void)setLoveStatus:(enum LOVE_STATUS)status withNumOfLove:(NSString *)numOfLove animate:(bool)animate
{
    [self setNumOfLove:numOfLove];
    
    switch (status) {
        case LOVE_STATUS_NONE:
            [self unlove:animate];
            break;
            
        case LOVE_STATUS_LOVED:
            [self love:animate];
            break;
    }
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
