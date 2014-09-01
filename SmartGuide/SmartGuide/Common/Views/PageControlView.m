//
//  PageControlView.m
//  Infory
//
//  Created by XXX on 9/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "PageControlView.h"
#import "Utility.h"

@interface PageControlView()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@end

@implementation PageControlView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self initComponents];
    
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initComponents];
}

-(void) initComponents
{
    CGRect frame=self.frame;
    frame.origin=CGPointZero;
    UICollectionView *collView=[[UICollectionView alloc] initWithFrame:frame collectionViewLayout:[UICollectionViewFlowLayout new]];
    collView.backgroundColor=[UIColor clearColor];
    collView.dataSource=self;
    collView.delegate=self;
    collView.collectionViewFlowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    
    [collView registerClass:[PageControlShopGalleryCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self addSubview:collView];
    _collView=collView;
    
    self.userInteractionEnabled=false;
}

#pragma mark UICollectionView DataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return MIN(_numberOfPages, 1);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _numberOfPages;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float size=MIN(collectionView.SW, collectionView.SH);
    return CGSizeMake(size, size);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PageControlCollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.idx=indexPath;
    
    return cell;
}

-(void)setScroll:(UIScrollView *)scroll
{
    if(_scroll)
        [_scroll removeObserver:self forKeyPath:@"contentOffset"];
    
    _scroll=scroll;
    
    if(_scroll)
        [_scroll addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    UIScrollView *scroll=object;
    if(_scrollDirection==UICollectionViewScrollDirectionHorizontal)
    {
        CGPoint pnt=scroll.contentOffset;
        
        int page=pnt.x/scroll.SW;
        
        for(PageControlShopGalleryCell *cell in _collView.visibleCells)
        {
            if([cell isKindOfClass:[PageControlShopGalleryCell class]])
            {
                if(cell.idx.item==page)
                    cell.selected=true;
                else
                    cell.selected=false;
            }
        }
    }
}

-(void)dealloc
{
    self.scroll=nil;
}

@end

@implementation PageControlCollectionCell

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    UIView *view=[self createNormalView];
    
    [self addSubview:view];
    _normalView=view;
    
    view=[self createSelectedView];
    
    [self addSubview:view];
    _selectedView=view;
    
    return self;
}

-(UIView *)createNormalView
{
    CGRect rect=self.frame;
    rect.origin=CGPointZero;
    
    UIView *view=[[UIView alloc] initWithFrame:rect];
    
    return view;
}

-(UIView *)createSelectedView
{
    CGRect rect=self.frame;
    rect.origin=CGPointZero;
    
    UIView *view=[[UIView alloc] initWithFrame:rect];
    
    return view;
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    [UIView animateWithDuration:0.15f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        _normalView.alpha=1-selected;
        _selectedView.alpha=selected;
    } completion:nil];
}

@end

@implementation PageControlShopGalleryCell

-(UIView *)createNormalView
{
    CGRect rect=self.frame;
    rect.origin=CGPointZero;
    
    UIView *view=[[UIView alloc] initWithFrame:rect];
    view.backgroundColor=[UIColor whiteColor];
    view.clipsToBounds=true;
    view.layer.cornerRadius=rect.size.width/2;
    
    return view;
}

-(UIView *)createSelectedView
{
    CGRect rect=self.frame;
    rect.origin=CGPointZero;
    
    UIView *view=[[UIView alloc] initWithFrame:rect];
    view.backgroundColor=[UIColor clearColor];
    view.clipsToBounds=true;
    view.layer.cornerRadius=rect.size.width/2;
    view.layer.borderWidth=2;
    view.layer.borderColor=[UIColor whiteColor].CGColor;
    
    return view;
}

@end