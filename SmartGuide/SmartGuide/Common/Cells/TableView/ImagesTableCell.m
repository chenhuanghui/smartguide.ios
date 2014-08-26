//
//  ImagesTableCell.m
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ImagesTableCell.h"
#import "Utility.h"

@implementation ImagesTableCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.backgroundColor=[UIColor clearColor];
    self.contentView.backgroundColor=[UIColor clearColor];
    self.clipsToBounds=false;
    self.contentView.clipsToBounds=true;
    self.autoresizesSubviews=true;
    self.contentView.autoresizesSubviews=false;
    
    CGRect rect=self.frame;
    rect.origin=CGPointZero;
    
    UICollectionView *collView=[[UICollectionView alloc] initWithFrame:rect collectionViewLayout:[UICollectionViewFlowLayout new]];
    collView.dataSource=self;
    collView.delegate=self;
    collView.backgroundColor=[UIColor clearColor];
    
    collView.collectionViewFlowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    collView.collectionViewFlowLayout.minimumInteritemSpacing=0;
    collView.collectionViewFlowLayout.minimumLineSpacing=0;
    collView.collectionViewFlowLayout.itemSize=CGSizeZero;
    
    [self.contentView addSubview:collView];
    
    _collView=collView;
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.collView.S=self.S;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 0;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.collView.S;
}

+(NSString *)reuseIdentifier
{
    return @"ImagesTableCell";
}

@end

@implementation UITableView(ImagesTableCell)

-(void)registerImagesTableCell
{
    [self registerClass:[ImagesTableCell class] forCellReuseIdentifier:[ImagesTableCell reuseIdentifier]];
}

-(ImagesTableCell *)imagesTableCell
{
    return [self dequeueReusableCellWithIdentifier:[ImagesTableCell reuseIdentifier]];
}

@end