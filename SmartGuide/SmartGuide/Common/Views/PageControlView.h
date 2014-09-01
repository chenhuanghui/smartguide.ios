//
//  PageControlView.h
//  Infory
//
//  Created by XXX on 9/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageControlView : UIView

@property (nonatomic, weak, readonly) UICollectionView *collView;
@property (nonatomic, assign) NSUInteger numberOfPages;
@property (nonatomic, weak) UIScrollView *scroll;
@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;

@end

@interface PageControlCollectionCell : UICollectionViewCell

-(UIView*) createNormalView;
-(UIView*) createSelectedView;

@property (nonatomic, weak, readonly) UIView *normalView;
@property (nonatomic, weak, readonly) UIView *selectedView;
@property (nonatomic, copy) NSIndexPath *idx;

@end

@interface PageControlShopGalleryCell : PageControlCollectionCell

@end