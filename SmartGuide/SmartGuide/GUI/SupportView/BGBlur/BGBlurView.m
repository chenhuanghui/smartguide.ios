//
//  BGBlurView.m
//  SmartGuide
//
//  Created by XXX on 7/30/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "BGBlurView.h"
#import <QuartzCore/QuartzCore.h>
#import "Constant.h"
#define SHADOW_HEIGHT 20.0
#define SHADOW_INVERSE_HEIGHT 10.0

@implementation BGBlurView

- (id)init
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"BGBlurView" owner:nil options:nil] objectAtIndex:0];
    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [self load];
}

-(void) load
{
    CGRect rect=self.frame;
    rect.origin=CGPointZero;
    rect.size.height=20;
    blurTop.frame=rect;
    
    rect.origin.y=self.frame.size.height-20;
    blurBottom.frame=rect;
    
    blurBottom.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blurup.png"]];
    blurTop.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blur.png"]];
    
    blurTop.hidden=true;
    blurBottom.hidden=true;
    [self.layer addSublayer:[self shadowAsInverse:false]];
}

- (CAGradientLayer *)shadowAsInverse:(BOOL)inverse
{
	CAGradientLayer *newShadow = [[CAGradientLayer alloc] init];
	CGRect newShadowFrame =
    CGRectMake(0, 0, self.frame.size.width,
               inverse ? SHADOW_INVERSE_HEIGHT : SHADOW_HEIGHT);
	newShadow.frame = newShadowFrame;
	CGColorRef darkColor =
    [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:
     inverse ? (SHADOW_INVERSE_HEIGHT / SHADOW_HEIGHT) * 0.5 : 0.5].CGColor;
	CGColorRef lightColor =
    [COLOR_BACKGROUND_APP colorWithAlphaComponent:0.0].CGColor;
	newShadow.colors =
    [NSArray arrayWithObjects:
     (__bridge id)(inverse ? lightColor : darkColor),
     (__bridge id)(inverse ? darkColor : lightColor),
     nil];
	return newShadow;
}

@end