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
    {
        float screenScale=UIScreenScale();
        CGSize size=self.l_v_s;
        image=[image scaleProportionalToSize:CGSizeMake(size.width*screenScale, size.height*screenScale)];
        if(image.scale!=screenScale)
            [super setImage:[UIImage imageWithCGImage:image.CGImage scale:screenScale orientation:image.imageOrientation]];
        else
            [super setImage:image];
    }
    else
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

@implementation ImageScaleCropHeight

-(void)setImage:(UIImage *)image
{
    if(image)
    {
        float screenScale=UIScreenScale();
        
        CGSize imageSize=image.size;
        CGSize size=self.l_v_s;
        
        float w=size.width/imageSize.width;
        imageSize.width*=w;
        imageSize.height*=w;
        
        image=[image scaleProportionalToSize:CGSizeMake(imageSize.width*screenScale, imageSize.height*screenScale)];
        if(image.scale!=screenScale)
            [super setImage:[UIImage imageWithCGImage:image.CGImage scale:screenScale orientation:image.imageOrientation]];
        else
            [super setImage:image];
    }
    
    [super setImage:image];
}

@end