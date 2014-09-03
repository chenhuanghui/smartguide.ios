//
//  ImageCollectionCell.h
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCollectionCell : UICollectionViewCell

+(NSString *)reuseIdentifier;

@property (nonatomic, weak, readonly) UIImageView *imgv;
@property (nonatomic, weak) UICollectionView *collView;

@end

@interface UICollectionView(ImageCollectionCell)

-(void) registerImageCollectionCell;
-(ImageCollectionCell*) imageCollectionCell:(NSIndexPath*) idx;

@end