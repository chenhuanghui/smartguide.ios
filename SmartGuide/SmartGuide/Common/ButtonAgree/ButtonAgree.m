//
//  ButtonAgree.m
//  MakeButtonAgree
//
//  Created by MacMini on 05/12/2013.
//  Copyright (c) 2013 MacMini. All rights reserved.
//

#import "ButtonAgree.h"

#define BUTTON_AGREE_IMAGE_LEFT_NORMAL [UIImage imageNamed:@"button_green_left.png"]
#define BUTTON_AGREE_IMAGE_RIGHT_NORMAL [UIImage imageNamed:@"button_green_right.png"]
#define BUTTON_AGREE_IMAGE_MID_NORMAL [UIImage imageNamed:@"button_green_mid.png"]

@implementation ButtonAgree
@synthesize agreeStatus;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    UIImage *left=BUTTON_AGREE_IMAGE_LEFT_NORMAL;
    UIImage *right=BUTTON_AGREE_IMAGE_RIGHT_NORMAL;
    UIImage *mid=BUTTON_AGREE_IMAGE_MID_NORMAL;
    
    [left drawAtPoint:CGPointZero];
    [right drawAtPoint:CGPointMake(rect.origin.x+rect.size.width-right.size.width, 0)];
    
    rect.origin.x=left.size.width;
    rect.size.width=rect.size.width-right.size.width-left.size.width;
    [mid drawAsPatternInRect:rect];
}

-(void)setTitle:(NSString *)text agreeStatus:(enum AGREE_STATUS)status
{
    [self setTitle:text forState:UIControlStateNormal];
    agreeStatus=status;
}

@end

@implementation ImageAgreeView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.contentMode=UIViewContentModeRedraw;
    self.backgroundColor=[UIColor clearColor];
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    UIImage *left=BUTTON_AGREE_IMAGE_LEFT_NORMAL;
    UIImage *right=BUTTON_AGREE_IMAGE_RIGHT_NORMAL;
    UIImage *mid=BUTTON_AGREE_IMAGE_MID_NORMAL;
    
    [left drawAtPoint:CGPointZero];
    [right drawAtPoint:CGPointMake(rect.origin.x+rect.size.width-right.size.width, 0)];
    
    rect.origin.x=left.size.width;
    rect.size.width=rect.size.width-right.size.width-left.size.width;
    [mid drawAsPatternInRect:rect];
}

@end