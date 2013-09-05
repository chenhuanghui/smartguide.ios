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
    imgvLoading.image=nil;
    imgvLoading.hidden=true;
    imgvImage.frame=CGRectMake(2, 2, 81, 81);
    imgvImage.image=image;
    imgvImage.hidden=false;
}

-(void) showEmptyImage
{
    imgvImage.hidden=true;
    imgvImage.image=nil;
    imgvLoading.image=UIIMAGE_LOADING_SHOP_GALLERY;
    imgvLoading.frame=CGRectMake(2, 2, 81, 81);
    imgvLoading.hidden=false;
}

-(void)setURLString:(NSString *)url duration:(float)duration
{
    if(url.length==0)
    {
        [self showEmptyImage];
        return;
    }
    
    UIImage *img=[[AFImageCache af_sharedImageCache] objectForKey:url];
    
    if(img)
    {
        imgvLoading.image=nil;
        imgvLoading.hidden=true;
        
        imgvImage.frame=CGRectMake(2, 2, 81, 81);
        imgvImage.image=img;
        imgvImage.hidden=false;
    }
    else
    {
        imgvLoading.image=UIIMAGE_LOADING_SHOP_GALLERY;
        imgvLoading.hidden=false;
        imgvLoading.frame=CGRectMake(2, 2, 81, 81);
        
        imgvImage.frame=CGRectMake(2, -81, 81, 81);
        imgvImage.hidden=false;
        
        [imgvImage setSmartGuideImageWithURL:[NSURL URLWithString:url] placeHolderImage:UIIMAGE_LOADING_SHOP_GALLERY success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {

            imgvImage.image=image;
            
            [UIView animateWithDuration:duration animations:^{
                imgvImage.frame=CGRectMake(2, 2, 81, 81);
                imgvLoading.frame=CGRectMake(2, 81, 81, 81);
            } completion:^(BOOL finished) {
                imgvLoading.hidden=true;
                imgvLoading.image=nil;
            }];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *placeholderImage) {
            imgvImage.frame=CGRectMake(2, 2, 81, 81);
            imgvLoading.hidden=true;
            imgvLoading.image=nil;
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

-(UIImage *)userImage
{
    return imgvImage.image;
}

+(CGSize)imageSize
{
    return CGSizeMake(81, 81);
}

-(id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    self=[super awakeAfterUsingCoder:aDecoder];
    
    CGRect rect=self.frame;
    self.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45*2));
    self.frame=rect;
    
    return self;
}

@end
