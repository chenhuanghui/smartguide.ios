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

+(NSString *)reuseIdentifier
{
    return @"TabHomeImagesCell";
}

@end

@implementation UITableView(TabHomeImagesCell)

-(void) registerTabHomeImagesCell
{
    [self registerNib:[UINib nibWithNibName:[TabHomeImagesCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[TabHomeImagesCell reuseIdentifier]];
}

-(TabHomeImagesCell*) tabHomeImagesCell
{
    return [self dequeueReusableCellWithIdentifier:[TabHomeImagesCell reuseIdentifier]];
}

@end