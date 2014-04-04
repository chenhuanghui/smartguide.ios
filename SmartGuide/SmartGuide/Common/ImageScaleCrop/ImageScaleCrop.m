//
//  ImageScaleCrop.m
//  SmartGuide
//
//  Created by MacMini on 27/02/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ImageScaleCrop.h"
#import "Utility.h"

@implementation ImageDefaultBGView

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    [self setting];
    
    return self;
}

-(void) setting
{
    self.contentMode=UIViewContentModeRedraw;
    self.userInteractionEnabled=false;
}

-(void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"pattern_image.jpg"] drawAsPatternInRect:rect];
}

@end

@implementation ImageDefault
@synthesize bgView;

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    ImageDefaultBGView *bg=[[ImageDefaultBGView alloc] initWithFrame:CGRectMake(0, 0, self.l_v_w, self.l_v_h)];
    bg.alpha=1;
    
    [self addSubview:bg];
    
    bgView=bg;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    frame.origin=CGPointZero;
    bgView.frame=frame;
}

-(void)setImage:(UIImage *)image
{
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        bgView.alpha=image==nil?1:0;
    } completion:nil];
    
    [super setImage:image];
}

@end

@implementation ImageScaleCropAspectFit
@synthesize viewWillSize;

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.viewWillSize=CGSizeZero;
    
    self.contentMode=UIViewContentModeScaleAspectFit;
    self.clipsToBounds=true;
}

-(void)setContentMode:(UIViewContentMode)contentMode
{
    [super setContentMode:UIViewContentModeScaleAspectFit];
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

@end

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

@end

@implementation ImageScaleProportional
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

@end

@implementation ImageScaleCropHeight
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
    }
    else
    {
        [super setImage:image];
    }
}

+(CGSize)makeSizeFromImageSize:(CGSize)imageSize willWidth:(float)willWidth
{
    if(CGSizeEqualToSize(imageSize, CGSizeZero))
        return CGSizeMake(0, 0);
    
    float w=willWidth/imageSize.width;
    return CGSizeMake(imageSize.width*w, imageSize.height*w);
}

@end

@implementation ImageScaleShopGallery
@synthesize viewWillSize;

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.viewWillSize=CGSizeZero;
    
    self.contentMode=UIViewContentModeScaleAspectFill;
    self.clipsToBounds=true;
}

-(void)setContentMode:(UIViewContentMode)contentMode
{
    [super setContentMode:UIViewContentModeScaleAspectFill];
}

-(void)setImage:(UIImage *)image
{
    if(image)
    {
        if(image.scale!=UIScreenScale())
            image=[UIImage imageWithCGImage:image.CGImage scale:UIScreenScale() orientation:image.imageOrientation];
        
        [super setImage:image];
    }
    else
    {
        [super setImage:image];
    }
}

+(CGSize)makeSizeFromImageSize:(CGSize)imageSize willHeight:(float)willHeight
{
    float w=willHeight/imageSize.height;
    return CGSizeMake(imageSize.width*w, imageSize.height*w);
}

@end