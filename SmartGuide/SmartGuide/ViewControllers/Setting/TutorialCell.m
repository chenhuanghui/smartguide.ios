//
//  TutorialCell.m
//  SmartGuide
//
//  Created by XXX on 9/3/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "TutorialCell.h"
#import "Utility.h"

@implementation TutorialCell

-(void)setTutorialImage:(UIImage *)image
{
    imgv.image=image;
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if(newSuperview)
    {
        imgv.frame=CGRectMake(0, 0, self.frame.size.height, self.frame.size.width);
        imgv.center=CGPointMake(self.frame.size.height/2, self.frame.size.width/2);
    }
}

-(id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    self=[super awakeAfterUsingCoder:aDecoder];
    
    self.frame=[UIScreen mainScreen].bounds;
    
    CGRect rect=self.frame;
    self.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45*2));
    self.frame=rect;
    
    return self;
}

+(CGSize)size
{
    return [UIScreen mainScreen].bounds.size;
}

+(NSString *)reuseIdentifier
{
    return @"TutorialCell";
}

@end