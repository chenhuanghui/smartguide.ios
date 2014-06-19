//
//  ShopGalleryCell.h
//  SmartGuide
//
//  Created by MacMini on 20/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopGalleryCell : UICollectionViewCell
{
    __weak IBOutlet UIImageView *imgv;
}

-(void) loadImage:(NSString*) url;
-(void) collectionViewDidScroll:(UICollectionView*) collectionView indexPath:(NSIndexPath*) idx;
+(NSString *)reuseIdentifier;

@end

@interface UICollectionView(ShopGalleryCell)

-(void) registerShopGalleryCell;
-(ShopGalleryCell*) shopGalleryCellForIndexPath:(NSIndexPath*) indexPath;

@end