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
@synthesize viewWillSize;

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.viewWillSize=CGSizeZero;
    
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
        CGSize size=self.l_v_s;
        
        if(!CGSizeEqualToSize(self.viewWillSize, CGSizeZero))
            size=self.viewWillSize;
        
        image=[image scaleProportionalToSize:CGSizeMake(size.width*UIScreenScale(), size.height*UIScreenScale())];
        
        if(image.scale!=UIScreenScale())
            image=[UIImage imageWithCGImage:image.CGImage scale:UIScreenScale() orientation:image.imageOrientation];
        
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
@synthesize viewWillSize;

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.viewWillSize=CGSizeZero;
    
    self.contentMode=UIViewContentModeCenter;
    self.clipsToBounds=true;
    
    self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"pattern_image.jpg"]];
}

-(void)setContentMode:(UIViewContentMode)contentMode
{
    [super setContentMode:UIViewContentModeCenter];
}

-(void)setImage:(UIImage *)image
{
    if(image)
    {
        CGSize imageSize=image.size;
        CGSize size=self.l_v_s;
        
        if(!CGSizeEqualToSize(self.viewWillSize, CGSizeZero))
            size=self.viewWillSize;
        
        float w=size.width/imageSize.width;
        imageSize.width*=w;
        imageSize.height*=w;
        
        image=[image scaleToSize:CGSizeMake(imageSize.width*UIScreenScale(), imageSize.height*UIScreenScale())];
        
        if(image.scale!=UIScreenScale())
            image=[UIImage imageWithCGImage:image.CGImage scale:UIScreenScale() orientation:image.imageOrientation];
        
        [super setImage:image];
        self.backgroundColor=[UIColor clearColor];
    }
    else
    {
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"pattern_image.jpg"]];
        [super setImage:image];
    }
}

+(CGSize)makeSizeFromImageSize:(CGSize)imageSize willWidth:(float)willWidth
{
    float w=willWidth/imageSize.width;
    return CGSizeMake(imageSize.width*w, imageSize.height*w);
}

@end