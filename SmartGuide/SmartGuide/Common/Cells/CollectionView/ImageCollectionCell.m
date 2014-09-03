//
//  ImageCollectionCell.m
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ImageCollectionCell.h"
#import "Utility.h"

@implementation ImageCollectionCell

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    self.backgroundColor=[UIColor clearColor];
    self.autoresizesSubviews=false;
    
    UIImageView *imgv=[UIImageView new];
    imgv.S=self.S;
    
    [self addSubview:imgv];
    
    _imgv=imgv;
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _imgv.S=self.S;
}

-(void)setCollView:(UICollectionView *)collView
{
    if(_collView)
        [_collView removeObserver:self forKeyPath:@"contentOffset"];
    
    _collView=collView;
    
    if(_collView)
        [_collView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(_collView.collectionViewFlowLayout.scrollDirection==UICollectionViewScrollDirectionHorizontal)
    {
        NSIndexPath *idx=[_collView indexPathForCell:self];
        
        if(!idx)
            return;
        
        CGRect rect=[_collView rectForItemAtIndexPath:idx];
        _imgv.OX=-(rect.origin.x-_collView.COX)/2;
    }
}

-(void)dealloc
{
    self.collView=nil;
}

+(NSString *)reuseIdentifier
{
    return @"ImageCollectionCell";
}

@end

@implementation UICollectionView(ImageCollectionCell)

-(void)registerImageCollectionCell
{
    [self registerClass:[ImageCollectionCell class] forCellWithReuseIdentifier:[ImageCollectionCell reuseIdentifier]];
}

-(ImageCollectionCell *)imageCollectionCell:(NSIndexPath *)idx
{
    return [self dequeueReusableCellWithReuseIdentifier:[ImageCollectionCell reuseIdentifier] forIndexPath:idx];
}

@end