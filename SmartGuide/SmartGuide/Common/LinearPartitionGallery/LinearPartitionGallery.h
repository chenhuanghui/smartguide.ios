//
//  LinearPartitionGallery.h
//  SmartGallery
//
//  Created by XXX on 7/29/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LinearPartitionLayout;

@protocol LinearPartitionLayoutDelegate<NSObject>

-(CGSize) linearPartition:(LinearPartitionLayout*) layout sizeAtIndexPath:(NSIndexPath*) indexPath;

@end

@interface LinearPartitionLayout : UICollectionViewLayout
{
    NSMutableDictionary *_layoutAttributes;
    CGSize _contentSize;
}

@property (nonatomic, weak) IBOutlet id<LinearPartitionLayoutDelegate> delegate;

@end