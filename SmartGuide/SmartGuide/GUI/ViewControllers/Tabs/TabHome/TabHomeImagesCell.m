//
//  TabHomeImagesCell.m
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TabHomeImagesCell.h"
#import "HomeImages.h"
#import "HomeImage.h"
#import "ImageCollectionCell.h"
#import "ImageManager.h"

@implementation TabHomeImagesCell

-(void)loadWithHomeImages:(HomeImages *)obj
{
    _obj=obj;
    
    [self.collView reloadData];
    self.collView.contentOffset=CGPointZero;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return MIN(1,_obj.imagesObjects.count);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _obj.imagesObjects.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return collectionView.S;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCollectionCell *cell=[collectionView imageCollectionCell:indexPath];
    HomeImage *obj=_obj.imagesObjects[indexPath.row];
    
    [cell.imgv defaultLoadImageWithURL:obj.image];
    
    return cell;
}

+(NSString *)reuseIdentifier
{
    return @"TabHomeImagesCell";
}

+(float)heightWithHomeImages:(HomeImages *)obj width:(float)width
{
    float height=CGSizeResizeToWidth(width, CGSizeMake(obj.imageWidth.floatValue, obj.imageHeight.floatValue)).height;
    
    return height>0?height+15:0;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self.collView registerImageCollectionCell];
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.collView.SH=self.SH-15;
    [self.collView reloadData];
}

@end

@implementation UITableView(TabHomeImagesCell)

-(void) registerTabHomeImagesCell
{
    [self registerClass:[TabHomeImagesCell class] forCellReuseIdentifier:[TabHomeImagesCell reuseIdentifier]];
}

-(TabHomeImagesCell*) tabHomeImagesCell
{
    return [self dequeueReusableCellWithIdentifier:[TabHomeImagesCell reuseIdentifier]];
}

@end