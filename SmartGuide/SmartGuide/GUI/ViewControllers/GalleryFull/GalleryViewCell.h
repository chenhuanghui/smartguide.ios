//
//  ShopGalleryViewCell.h
//  SmartGuide
//
//  Created by MacMini on 16/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryViewCell : UICollectionViewCell
{
    __weak IBOutlet UIImageView *imgvFrame;
    __weak IBOutlet UIImageView *imgv;
}

-(void) loadWithURL:(NSString*) url highlighted:(bool) isHighlighted;
-(void) loadWithImage:(UIImage*) image highlighted:(bool) isHighlighted;

+(NSString*) reuseIdentifier;
+(float) height;

@end

@interface UICollectionView(GalleryViewCell)

-(void) registerGalleryViewCell;
-(GalleryViewCell*) galleryViewCellForIndexPath:(NSIndexPath*) indexPath;

@end