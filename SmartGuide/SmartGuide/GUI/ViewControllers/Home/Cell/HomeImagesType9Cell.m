//
//  HomeImagesType9Cell.m
//  SmartGuide
//
//  Created by MacMini on 06/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "HomeImagesType9Cell.h"
#import "Utility.h"
#import "HomeImageType9Cell.h"
#import "UserHome.h"
#import "PageControl.h"

@interface HomeImagesType9Cell()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation HomeImagesType9Cell

-(void)loadWithHome9:(UserHome *)home
{
    _home=home;
    page.numberOfPages=_home.imagesObjects.count;
    page.hidden=_home.imagesObjects.count==1;
    
    [collView reloadData];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [page scrollViewDidScroll:scrollView isHorizontal:false];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _home.imagesObjects.count==0?0:1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _home.imagesObjects.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.l_v_w, _home.home9Size.height);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeImageType9Cell *cell=(HomeImageType9Cell*)[collView dequeueReusableCellWithReuseIdentifier:[HomeImageType9Cell reuseIdentifier] forIndexPath:indexPath];
    UserHomeImage *img=_home.imagesObjects[indexPath.row];
    
    cell.collView=collectionView;
    cell.indexPath=indexPath;
    cell.home=_home;
    
    [cell loadWithURL:img.image size:CGSizeMake(collectionView.l_v_w, _home.imageHeight.floatValue)];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate homeImagesType9Cell:self touchedHome:_home];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
 
    [collView registerNib:[UINib nibWithNibName:[HomeImageType9Cell reuseIdentifier] bundle:nil] forCellWithReuseIdentifier:[HomeImageType9Cell reuseIdentifier]];
    
    page.dotColorCurrentPage=[UIColor whiteColor];
    page.dotColorOtherPage=[[UIColor whiteColor] colorWithAlphaComponent:0.5];
}

+(NSString *)reuseIdentifier
{
    return @"HomeImagesType9Cell";
}

@end
