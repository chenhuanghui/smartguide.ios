//
//  ImageScaleCrop.m
//  SmartGuide
//
//  Created by MacMini on 27/02/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ImageScaleCrop.h"
#import "Utility.h"

@implementation ImageScaleCrop

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.contentMode=UIViewContentModeCenter;
    self.clipsToBounds=true;
}

-(void)setContentMode:(UIViewContentMode)contentMode
{
    [super setContentMode:UIViewContentModeCenter];
}

-(void)setImage:(UIImage *)image
{
    if(image)
        image=[image scaleProportionalToSize:self.frame.size];
    
    [super setImage:image];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end