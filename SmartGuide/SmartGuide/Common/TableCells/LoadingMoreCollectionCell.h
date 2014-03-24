//
//  LoadingMoreCollectionCell.h
//  Infory
//
//  Created by MacMini on 21/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingMoreCollectionCell : UICollectionViewCell

-(void) showLoading;
+(NSString *)reuseIdentifier;

@property (nonatomic, weak) IBOutlet UIImageView *imgv;

@end

@interface UICollectionView(LoadingMoreCell)

-(void) registerLoadingMoreCell;
-(LoadingMoreCollectionCell*) loadingMoreCellAtIndexPath:(NSIndexPath*) indexPath;

@end