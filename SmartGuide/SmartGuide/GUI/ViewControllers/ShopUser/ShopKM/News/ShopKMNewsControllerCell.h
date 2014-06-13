//
//  SUKMNewsContaintCell.h
//  Infory
//
//  Created by XXX on 6/6/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPMoviePlayerController;

@interface ShopKMNewsControllerCell : UICollectionViewCell
{
    __weak IBOutlet UITableView *tableKM;
    __weak IBOutlet UIView *bg;
    NSArray *_kmNews;
    
    __strong MPMoviePlayerController *_player;
}

-(void) loadWithKMNews:(NSArray*) kms maxHeight:(float) maxHeight;
-(void) tableDidScroll:(UICollectionView*) table;
-(void) tableDidEndDisplayCell:(UICollectionView*) table;

+(float) heightWithKMNews:(NSArray*) kms;
+(NSString *)reuseIdentifier;

@end

@interface UICollectionView(ShopKMNewsControllerCell)

-(void) registerShopKMNewsControllerCell;
-(ShopKMNewsControllerCell*) shopKMNewsControllerCellForIndexPath:(NSIndexPath*) indexPath;

@end