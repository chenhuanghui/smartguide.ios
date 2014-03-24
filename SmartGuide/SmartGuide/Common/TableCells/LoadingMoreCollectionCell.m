//
//  LoadingMoreCollectionCell.m
//  Infory
//
//  Created by MacMini on 21/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "LoadingMoreCollectionCell.h"
#import "ImageManager.h"

@implementation LoadingMoreCollectionCell

-(void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    if(self.superview)
        [self.imgv startAnimating];
    else
        [self.imgv stopAnimating];
}

-(void)showLoading
{
    [self.imgv startAnimating];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.imgv.animationDuration=DURATION_LOADING;
    self.imgv.animationImages=[ImageManager sharedInstance].loadingImages;
    self.imgv.animationRepeatCount=0;
}

+(NSString *)reuseIdentifier
{
    return @"LoadingMoreCollectionCell";
}

@end

@implementation UICollectionView(LoadingMoreCell)

-(void) registerLoadingMoreCell
{
    [self registerNib:[UINib nibWithNibName:[LoadingMoreCollectionCell reuseIdentifier] bundle:nil] forCellWithReuseIdentifier:[LoadingMoreCollectionCell reuseIdentifier]];
}

-(LoadingMoreCollectionCell*) loadingMoreCellAtIndexPath:(NSIndexPath *)indexPath
{
    return [self dequeueReusableCellWithReuseIdentifier:[LoadingMoreCollectionCell reuseIdentifier] forIndexPath:indexPath];
}

@end