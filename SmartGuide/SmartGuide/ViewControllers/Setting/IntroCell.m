//
//  IntroCell.m
//  SmartGuide
//
//  Created by XXX on 9/4/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "IntroCell.h"
#import "Utility.h"

@implementation IntroCell

-(void)setImageIntro:(UIImage *)img
{
    imgv.image=img;
}

+(NSString *)reuseIdentifier
{
    return @"IntroCell";
}

-(id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    self=[super awakeAfterUsingCoder:aDecoder];
    
    CGRect rect=self.frame;
    rect.size.height=[UIScreen mainScreen].bounds.size.height;
    
    self.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45*2));
    self.frame=rect;
    
    return self;
}

@end
