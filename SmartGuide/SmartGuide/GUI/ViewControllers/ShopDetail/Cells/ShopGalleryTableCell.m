//
//  ShopGalleryTableCell.m
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopGalleryTableCell.h"
#import "ImageCollectionCell.h"
#import "Utility.h"
#import "ShopInfoGallery.h"
#import "ImageManager.h"
#import "PageControl.h"

@interface ShopGalleryTableCell()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@end

@implementation ShopGalleryTableCell

-(void)loadWithGalleries:(NSArray *)galleries
{
    self.galleries=galleries;
    pageControl.numberOfPages=galleries.count;
    pageControl.scroll=collView;
    pageControl.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    
    [collView reloadData];
}

#pragma mark UICollectionView DataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return MIN(_galleries.count, 1);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _galleries.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return collView.S;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCollectionCell *cell=[collView imageCollectionCell:indexPath];
    ShopInfoGallery *obj=_galleries[indexPath.item];
    
    cell.imgv.contentMode=UIViewContentModeScaleAspectFit;
    [cell.imgv defaultLoadImageWithURL:obj.cover];
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [collView registerImageCollectionCell];
}

+(NSString *)reuseIdentifier
{
    return @"ShopGalleryTableCell";
}

+(float)height
{
    return 240;
}

@end

@implementation UITableView(ShopGalleryTableCell)

-(void) registerShopGalleryTableCell
{
    [self registerNib:[UINib nibWithNibName:[ShopGalleryTableCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopGalleryTableCell reuseIdentifier]];
}

-(ShopGalleryTableCell*) shopGalleryTableCell
{
    return [self dequeueReusableCellWithIdentifier:[ShopGalleryTableCell reuseIdentifier]];
}

@end