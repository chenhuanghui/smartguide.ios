//
//  EmptyCollectionCell.m
//  Infory
//
//  Created by XXX on 6/13/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "EmptyCollectionCell.h"

@implementation EmptyCollectionCell

+(NSString *)reuseIdentifier
{
    return @"EmptyCollectionCell";
}

@end

@implementation UICollectionView(EmptyCollectionCell)

-(void)registerEmptyCollectionCell
{
    [self registerNib:[UINib nibWithNibName:[EmptyCollectionCell reuseIdentifier] bundle:nil] forCellWithReuseIdentifier:[EmptyCollectionCell reuseIdentifier]];
}

-(EmptyCollectionCell *)emptyCollectionCellForIndexPath:(NSIndexPath *)indexPath
{
    return [self dequeueReusableCellWithReuseIdentifier:[EmptyCollectionCell reuseIdentifier] forIndexPath:indexPath];
}

@end