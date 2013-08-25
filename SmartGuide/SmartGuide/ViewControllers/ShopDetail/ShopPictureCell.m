//
//  ShopPictureCell.m
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopPictureCell.h"
#import "UIImageView+AFNetworking.h"
#import "Utility.h"
#import "Constant.h"
#import <QuartzCore/QuartzCore.h>

@implementation ShopPictureCell

-(void)setImage:(UIImage *)image duration:(float)duration
{
    animationView.image=nil;
    animationView.hidden=true;
    picture.hidden=false;
    picture.frame=CGRectMake(0, 0, 81, 81);
    picture.image=image;
}

-(void)setURLString:(NSString *)url duration:(float)duration
{
    if(url.length==0)
    {
        picture.frame=CGRectMake(0, -81, 81, 81);
        picture.hidden=true;
        picture.image=nil;
        animationView.image=UIIMAGE_LOADING_SHOP_GALLERY;
        animationView.frame=CGRectMake(0, 0, 81, 81);
        animationView.hidden=false;
        return;
    }
    
    UIImage *img=[[AFImageCache af_sharedImageCache] objectForKey:url];
    
    if(img)
    {
        animationView.image=nil;
        animationView.hidden=true;
        picture.frame=CGRectMake(0, 0, 81, 81);
        picture.image=img;
    }
    else
    {
        animationView.image=UIIMAGE_LOADING_SHOP_GALLERY;
        animationView.hidden=false;
        animationView.frame=CGRectMake(0, 0, 81, 81);
        
        CGRect rect=picture.frame;
        rect.origin.y=-81;
        picture.frame=rect;
        
        picture.hidden=false;
        
        [picture setSmartGuideImageWithURL:[NSURL URLWithString:url] placeHolderImage:UIIMAGE_LOADING_SHOP_GALLERY success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            animationView.frame=CGRectMake(0, 0, 81, 81);
            CGRect rect=picture.frame;
            rect.origin.y=-rect.size.height;
            picture.frame=rect;
            picture.image=image;
            
            [UIView animateWithDuration:duration animations:^{
                picture.frame=CGRectMake(0, 0, picture.frame.size.width, picture.frame.size.height);
                animationView.frame=CGRectMake(0, animationView.frame.size.height/2, animationView.frame.size.width, animationView.frame.size.height);
            } completion:^(BOOL finished) {
                animationView.hidden=true;
                animationView.image=nil;
            }];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *placeholderImage) {
            picture.frame=CGRectMake(0, 0, picture.frame.size.width, picture.frame.size.height);
            animationView.frame=CGRectMake(0, animationView.frame.size.height/2, animationView.frame.size.width, animationView.frame.size.height);
            animationView.hidden=true;
            animationView.image=nil;
        }];
    }
}

+(NSString *)reuseIdentifier
{
    return @"ShopPictureCell";
}

+(CGSize)size
{
    return CGSizeMake(85, 85);
}

-(id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    self=[super awakeAfterUsingCoder:aDecoder];
    
    imageContaint.layer.masksToBounds=true;
    animationView.layer.masksToBounds=true;
    self.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45*2));
    
    return self;
}

-(UIImage *)userImage
{
    return picture.image;
}

+(CGSize)imageSize
{
    return CGSizeMake(81, 81);
}

@end
