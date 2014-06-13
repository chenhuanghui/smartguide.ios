//
//  EmptyCollectionCell.h
//  Infory
//
//  Created by XXX on 6/13/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmptyCollectionCell : UICollectionViewCell

+(NSString *)reuseIdentifier;

@end

@interface UICollectionView(EmptyCollectionCell)

-(void) registerEmptyCollectionCell;
-(EmptyCollectionCell*) emptyCollectionCellForIndexPath:(NSIndexPath*) indexPath;

@end