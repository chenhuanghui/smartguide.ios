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
    return @"ImagesCollectionCell";
}

@end

@implementation UITableView(ImagesTableCell)

-(void)registerImagesTableCell
{
    [self registerNib:[UINib nibWithNibName:[ImagesTableCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ImagesTableCell reuseIdentifier]];
}

-(ImagesTableCell *)imagesTableCell
{
    return [self dequeueReusableCellWithIdentifier:[ImagesTableCell reuseIdentifier]];
}

@end