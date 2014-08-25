//
//  ImagesTableCell.h
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagesTableCell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

+(NSString *)reuseIdentifier;

@property (nonatomic, weak, readonly) UICollectionView *collView;

@end

@interface UITableView(ImagesTableCell)

-(void) registerImagesTableCell;
-(ImagesTableCell*) imagesTableCell;

@end