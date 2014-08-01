//
//  LinearPartitionGallery.m
//  SmartGallery
//
//  Created by XXX on 7/29/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import "LinearPartitionGallery.h"
#import "Utility.h"

@implementation LinearPartitionLayout

-(int) totalItemCount
{
    int count=0;
    
    int sCount=[self.collectionView numberOfSections];
    for(int s=0;s<sCount;s++)
    {
        count+=[self.collectionView numberOfItemsInSection:s];
    }
    
    return count;
}

-(void)prepareLayout
{
    [super prepareLayout];
    
    CGSize frameSize=self.collectionView.frame.size;
    float ideal_height = MAX(frameSize.height, frameSize.width) / 4;
    int itemCount=[self totalItemCount];
    
    _layoutAttributes=[[NSMutableDictionary alloc] initWithCapacity:itemCount];
    
    CGRect newFrames[itemCount];
    float seq[itemCount];
    float total_width=0;
    
    int count=0;
    NSIndexPath *indexPath=nil;
    for(int s=0;s<self.collectionView.numberOfSections;s++)
    {
        for(int i=0;i<[self.collectionView numberOfItemsInSection:s];i++)
        {
            indexPath=[NSIndexPath indexPathForItem:i inSection:s];
            
            CGSize size=[self.delegate linearPartition:self sizeAtIndexPath:indexPath];
            CGSize newSize=CGSizeResizeToHeight(ideal_height, size);
            newFrames[count]=(CGRect){CGPointZero, newSize};
            seq[count]=newSize.width;
            total_width+=seq[count];
            
            count++;
        }
    }
    
    int K=(int)roundf(total_width/frameSize.width);
    
    float M[itemCount][K];
    float D[itemCount][K];
    
    for (int i = 0 ; i < itemCount; i++)
        for (int j = 0; j < K; j++)
            D[i][j] = 0;
    
    for (int i = 0; i < K; i++)
        M[0][i] = seq[0];
    
    for (int i = 0; i < itemCount; i++)
        M[i][0] = seq[i] + (i ? M[i-1][0] : 0);
    
    float cost;
    for (int i = 1; i < itemCount; i++) {
        for (int j = 1; j < K; j++) {
            M[i][j] = INT_MAX;
            
            for (int k = 0; k < i; k++) {
                cost = MAX(M[k][j-1], M[i][0]-M[k][0]);
                if (M[i][j] > cost) {
                    M[i][j] = cost;
                    D[i][j] = k;
                }
            }
        }
    }
    
    /**
     Ranges & Resizes
     */
    int k1 = K-1;
    int n1 = itemCount-1;
    int ranges[itemCount][2];
    while (k1 >= 0) {
        ranges[k1][0] = D[n1][k1]+1;
        ranges[k1][1] = n1;
        
        n1 = D[n1][k1];
        k1--;
    }
    ranges[0][0] = 0;
    
    float cellDistance = 5;
    float heightOffset = cellDistance, widthOffset;
    float frameWidth;
    for (int i = 0; i < K; i++) {
        float rowWidth = 0;
        frameWidth = frameSize.width - ((ranges[i][1] - ranges[i][0]) + 2) * cellDistance;
        
        for (int j = ranges[i][0]; j <= ranges[i][1]; j++) {
            rowWidth += newFrames[j].size.width;
        }
        
        float ratio = frameWidth / rowWidth;
        widthOffset = 0;
        
        for (int j = ranges[i][0]; j <= ranges[i][1]; j++) {
            newFrames[j].size.width *= ratio;
            newFrames[j].size.height *= ratio;
            newFrames[j].origin.x = widthOffset + (j - (ranges[i][0]) + 1) * cellDistance;
            newFrames[j].origin.y = heightOffset;
            
            widthOffset += newFrames[j].size.width;
        }
        heightOffset += newFrames[ranges[i][0]].size.height + cellDistance;
    }
    
    indexPath=nil;
    count=0;
    for(int s=0;s<self.collectionView.numberOfSections;s++)
    {
        for(int i=0;i<[self.collectionView numberOfItemsInSection:s];i++)
        {
            indexPath=[NSIndexPath indexPathForItem:i inSection:s];
            
            UICollectionViewLayoutAttributes *attribute=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attribute.frame=newFrames[count];
            
            [_layoutAttributes setObject:attribute forKey:indexPath];
            
            count++;
        }
    }
    
    _contentSize=CGSizeMake(frameSize.width, heightOffset);
}

-(CGSize)collectionViewContentSize
{
    return _contentSize;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *array=[NSMutableArray arrayWithCapacity:_layoutAttributes.count];
    
    for(NSString *key in _layoutAttributes)
    {
        UICollectionViewLayoutAttributes *attribute=[_layoutAttributes objectForKey:key];
        
        if(CGRectIntersectsRect(rect, attribute.frame))
            [array addObject:attribute];
    }
    
    return array;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return _layoutAttributes[indexPath];
}

@end