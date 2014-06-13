//
//  GalleryFullCell.h
//  SmartGuide
//
//  Created by MacMini on 05/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScrollFullCell;
@class GalleryFullCell;

@protocol GalleryFullCellDelegate <NSObject>

-(void) galleryFullCellTouchedOutsideImage:(GalleryFullCell*) cell;

@end

@interface GalleryFullCell : UICollectionViewCell
{
    __weak IBOutlet UIImageView *imgv;
    __weak IBOutlet ScrollFullCell *scroll;
}

-(void) loadImageURL:(NSString*) url;
-(void) loadWithImage:(UIImage*) image;
-(void) zoom:(CGPoint) pnt completed:(void(^)()) onCompleted;
-(bool) isZoomed;
-(void) collectionViewDidScroll:(UICollectionView*) collectionView indexPath:(NSIndexPath*) indexPath;
+(NSString *)reuseIdentifier;

@property (nonatomic, weak) id<GalleryFullCellDelegate> delegate;

@end

@interface ScrollFullCell : UIScrollView

@property (nonatomic, assign) CGPoint limitScrollOffset;

@end

@interface UICollectionView(GalleryFullCell)

-(void) registerGalleryFullCell;
-(GalleryFullCell*) galleryFullCellForIndexPath:(NSIndexPath*) indexPath;

@end