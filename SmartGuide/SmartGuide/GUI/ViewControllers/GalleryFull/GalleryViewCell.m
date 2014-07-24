//
//  ShopGalleryViewCell.m
//  SmartGuide
//
//  Created by MacMini on 16/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "GalleryViewCell.h"
#import "ImageManager.h"
#import "LoadingView.h"

@implementation GalleryViewCell

-(void)loadWithImage:(UIImage *)image highlighted:(bool)isHighlighted
{
    [imgv removeLoadingImageSmall];
    imgv.image=image;
    imgvFrame.highlighted=isHighlighted;
}

-(void)loadWithURL:(NSString *)url highlighted:(bool)isHighlighted
{
    [imgv loadGalleryThumbnailWithURL:url resize:CGSizeMake(90, 90)];
    imgvFrame.highlighted=isHighlighted;
}

+(float)height
{
    return 90;
}

+(NSString *)reuseIdentifier
{
    return @"GalleryViewCell";
}

@end

@implementation UICollectionView(GalleryViewCell)

-(void)registerGalleryViewCell
{
    [self registerNib:[UINib nibWithNibName:[GalleryViewCell reuseIdentifier] bundle:nil] forCellWithReuseIdentifier:[GalleryViewCell reuseIdentifier]];
}

-(GalleryViewCell *)galleryViewCellForIndexPath:(NSIndexPath *)indexPath
{
    return [self dequeueReusableCellWithReuseIdentifier:[GalleryViewCell reuseIdentifier] forIndexPath:indexPath];
}

@end