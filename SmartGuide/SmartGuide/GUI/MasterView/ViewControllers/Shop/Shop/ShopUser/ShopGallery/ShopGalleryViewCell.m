//
//  ShopGalleryViewCell.m
//  SmartGuide
//
//  Created by MacMini on 16/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopGalleryViewCell.h"
#import "ImageManager.h"

@implementation ShopGalleryViewCell

-(id)init
{
    self=[[NSBundle mainBundle] loadNibNamed:@"ShopGalleryViewCell" owner:nil options:nil][0];
    
    return self;
}

-(void)loadWithImage:(NSString *)url highlighted:(bool)isHighlighted
{
    [imgv loadShopGalleryWithURL:url];
    imgvFrame.highlighted=isHighlighted;
}

+(float)height
{
    return 91;
}

+(NSString *)reuseIdentifier
{
    return @"ShopGalleryViewCell";
}

@end
