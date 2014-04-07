//
//  GalleryFullCell.h
//  SmartGuide
//
//  Created by MacMini on 05/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScrollFullCell;

@interface GalleryFullCell : UICollectionViewCell<UIScrollViewDelegate>
{
    __weak IBOutlet UIImageView *imgv;
    __weak IBOutlet ScrollFullCell *scroll;
}

-(void) loadImageURL:(NSString*) url imageSize:(CGSize) imgSize;
-(void) zoom:(CGPoint) pnt completed:(void(^)()) onCompleted;
-(bool) isZoomed;
-(void) collectionViewDidScroll;
+(NSString *)reuseIdentifier;

@property (nonatomic, weak) UICollectionView *collView;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@interface ScrollFullCell : UIScrollView

@property (nonatomic, assign) CGPoint limitScrollOffset;

@end