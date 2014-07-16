//
//  ScanResultInforyButtonCell.m
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultInforyButtonCell.h"
#import "ScanCodeDecode.h"
#import "UserNotificationAction.h"
#import "ScanButtonCollectionCell.h"

@interface ScanResultInforyButtonCell()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ScanButtonCollectionCellDelegate>

@end

@implementation ScanResultInforyButtonCell

-(void)loadWithDecode:(ScanCodeDecode *)decode
{
    _decode=decode;

    collection.contentInset=UIEdgeInsetsMake(0, 10, 0, 10);
    
    [collection reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _decode.actionObjects.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((collectionView.l_v_w-collectionView.contentInset.left-collectionView.contentInset.right)/_decode.actionObjects.count, collectionView.l_v_h);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ScanButtonCollectionCell *cell=[collectionView scanButtonCollectionCellForIndexPath:indexPath];
    
    cell.delegate=self;
    [cell loadWithAction:_decode.actionObjects[indexPath.row]];
    
    return cell;
}

-(void)scanButtonCollectionCellTouchedAction:(ScanButtonCollectionCell *)cell
{
    [self.delegate scanResultInforyButtonCellTouchedAction:self action:cell.action];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [collection registerScanButtonCollectionCell];
}

-(IBAction)btnTouchUpInside:(id)sender
{
    
}

+(NSString *)reuseIdentifier
{
    return @"ScanResultInforyButtonCell";
}

+(float)heightWithDecode:(ScanCodeDecode *)decode
{    
    return 47+20;
}

@end

@implementation UITableView(ScanResultInforyButtonCell)

-(void)registerScanResultInforyButtonCell
{
    [self registerNib:[UINib nibWithNibName:[ScanResultInforyButtonCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ScanResultInforyButtonCell reuseIdentifier]];
}

-(ScanResultInforyButtonCell *)scanResultInforyButtonCell
{
    return [self dequeueReusableCellWithIdentifier:[ScanResultInforyButtonCell reuseIdentifier]];
}

@end