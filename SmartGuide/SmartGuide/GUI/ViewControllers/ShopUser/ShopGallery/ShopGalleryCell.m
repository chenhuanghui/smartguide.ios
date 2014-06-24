//
//  ShopGalleryCell.m
//  SmartGuide
//
//  Created by MacMini on 20/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopGalleryCell.h"
#import "Constant.h"
#import "Utility.h"
#import "ImageManager.h"

@implementation ShopGalleryCell

+(NSString *)reuseIdentifier
{
    return @"ShopGalleryCell";
}

-(void)loadImage:(NSString *)url
{
    [imgv loadShopCoverWithURL:url resize:imgv.l_v_s];
}

-(void)collectionViewDidScroll:(UICollectionView *)collectionView indexPath:(NSIndexPath *)idx
{
    CGRect rect=[collectionView rectForItemAtIndexPath:idx];
    
    [imgv l_v_setX:-(rect.origin.x-collectionView.l_co_x)/2];
}

@end

@implementation UICollectionView(ShopGalleryCell)

-(void)registerShopGalleryCell
{
    [self registerNib:[UINib nibWithNibName:[ShopGalleryCell reuseIdentifier] bundle:nil] forCellWithReuseIdentifier:[ShopGalleryCell reuseIdentifier]];
}

-(ShopGalleryCell *)shopGalleryCellForIndexPath:(NSIndexPath *)indexPath
{
    return [self dequeueReusableCellWithReuseIdentifier:[ShopGalleryCell reuseIdentifier] forIndexPath:indexPath];
}

@end