//
//  ShopGalleryViewCell.m
//  SmartGuide
//
//  Created by MacMini on 16/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopGalleryViewCell.h"
#import "ImageManager.h"
#import "LoadingView.h"

@implementation ShopGalleryViewCell

-(id)init
{
    self=[[NSBundle mainBundle] loadNibNamed:@"ShopGalleryViewCell" owner:nil options:nil][0];
 
    [loading showLoading];
    
    return self;
}

-(void)loadWithImage:(UIImage *)image highlighted:(bool)isHighlighted
{
    imgv.image=image;
    imgvFrame.highlighted=isHighlighted;
}

-(void)loadWithURL:(NSString *)url highlighted:(bool)isHighlighted
{
    [imgv loadShopGalleryWithURL:url];
    imgvFrame.highlighted=isHighlighted;
}

-(void)showLoading
{
    imgv.hidden=true;
    loading.hidden=false;
}

-(void)hideLoading
{
    imgv.hidden=false;
    loading.hidden=true;
}

+(float)height
{
    return 91;
}

+(NSString *)reuseIdentifier
{
    return @"ShopGalleryViewCell";
}

-(UIImageView *)imgv
{
    return imgv;
}

@end
