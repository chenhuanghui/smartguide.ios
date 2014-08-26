//
//  MapCollectionCell.h
//  Infory
//
//  Created by XXX on 8/26/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"

@class Label;

@interface MapCollectionCell : UICollectionViewCell
{
    id <MapObject> _obj;
}

-(void) loadWithMapObject:(id<MapObject>) obj;
//-(float) calculatorHeightWithObject:(id<MapObject>) obj;

+(NSString *)reuseIdentifier;

@property (nonatomic, weak, readonly) UIImageView *imgvBG;
@property (nonatomic, weak, readonly) UIScrollView *scroll;
@property (nonatomic, weak, readonly) Label *lblTitle;
@property (nonatomic, weak, readonly) Label *lblContent;
@property (nonatomic, weak, readonly) UIImageView *imgvLine;
@property (nonatomic, weak, readonly) UIImageView *imgvLogo;
@property (nonatomic, weak, readonly) Label *lblName;
@property (nonatomic, weak, readonly) Label *lblDesc;
@property (nonatomic, weak, readonly) UIButton *btnArrow;
//@property (nonatomic, assign) bool isPrototypeCell;

@end

@interface UICollectionView(MapCollectionCell)

-(void) registerMapCollectionCell;
-(MapCollectionCell*) mapCollectionCell:(NSIndexPath*) idx;
//-(MapCollectionCell*) MapCollectionPrototypeCell;

@end