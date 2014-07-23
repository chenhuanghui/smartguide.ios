//
//  ScanResultInforyCell.m
//  Infory
//
//  Created by XXX on 7/2/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultInforyCell.h"
#import "ScanCodeDecode.h"
#import "ScanResultInforyHeaderCell.h"
#import "ScanResultInforyTitleCell.h"
#import "ScanResultInforyTextCell.h"
#import "ScanResultInforyImageCell.h"
#import "ScanResultInforyVideoCell.h"
#import "ScanResultInforyButtonCell.h"
#import "ScanResultInforyShareCell.h"

@interface ScanResultInforyCell()<UITableViewDataSource, UITableViewDelegate,ScanResultInforyVideoCellDelegate, ScanResultInforyButtonCellDelegate>

@end

@implementation ScanResultInforyCell
@synthesize suggestHeight;

-(void)loadWithDecode:(NSArray *) array
{
    _items=array;
    [self layoutIfNeeded];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    table.dataSource=self;
    table.delegate=self;
    [table reloadData];
    table.scrollEnabled=false;
    
    [table l_v_setH:table.contentSize.height];
    suggestHeight=table.contentSize.height;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _items.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScanCodeDecode *decode=_items[indexPath.row];
    
    switch (decode.enumType) {
        case SCANCODE_DECODE_TYPE_BUTTONS:
            return [ScanResultInforyButtonCell heightWithDecode:decode];
            
        case SCANCODE_DECODE_TYPE_HEADER:
        {
            ScanResultInforyHeaderCell *cell=[tableView scanResultInforyHeaderCell];
            [cell loadWithDecode:decode];
            [cell layoutSubviews];
            
            return cell.suggestHeight;
        }
            
        case SCANCODE_DECODE_TYPE_IMAGE:
        {
            ScanResultInforyImageCell *cell=[tableView scanResultInforyImageCell];
            [cell loadWithDecode:decode];
            [cell layoutSubviews];
            
            return cell.suggestHeight;
        }
            
        case SCANCODE_DECODE_TYPE_SMALLTEXT:
        {
            ScanResultInforyTextCell *cell=[tableView scanResultInforyTextCell];
            [cell loadWithDecode:decode];
            [cell layoutSubviews];
            
            return cell.suggestHeight;
        }
            
        case SCANCODE_DECODE_TYPE_BIGTEXT:
        {
            ScanResultInforyTitleCell *cell=[tableView scanResultInforyTitleCell];
            [cell loadWithDecode:decode];
            [cell layoutSubviews];
            
            return cell.suggestHeight;
        }
            
        case SCANCODE_DECODE_TYPE_VIDEO:
        {
            ScanResultInforyVideoCell *cell=[tableView scanResultInforyVideoCell];
            [cell loadWithDecode:decode];
            [cell layoutSubviews];
            
            return cell.suggestHeight;
        }
            
        case SCANCODE_DECODE_TYPE_SHARE:
            return [ScanResultInforyShareCell height];
            
            
        case SCANCODE_DECODE_TYPE_UNKNOW:
            return 0;
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScanCodeDecode *decode=_items[indexPath.row];
    
    switch (decode.enumType) {
        case SCANCODE_DECODE_TYPE_BUTTONS:
        {
            ScanResultInforyButtonCell *cell=[tableView scanResultInforyButtonCell];
            
            cell.delegate=self;
            [cell loadWithDecode:decode];
            
            return cell;
        }
            
        case SCANCODE_DECODE_TYPE_HEADER:
        {
            ScanResultInforyHeaderCell *cell=[tableView scanResultInforyHeaderCell];
            
            [cell loadWithDecode:decode];
            
            return cell;
        }
            
        case SCANCODE_DECODE_TYPE_IMAGE:
        {
            ScanResultInforyImageCell *cell=[tableView scanResultInforyImageCell];
            
            [cell loadWithDecode:decode];
            
            return cell;
        }
            
        case SCANCODE_DECODE_TYPE_SMALLTEXT:
        {
            ScanResultInforyTextCell *cell=[tableView scanResultInforyTextCell];
            
            [cell loadWithDecode:decode];
            
            return cell;
        }
            
        case SCANCODE_DECODE_TYPE_BIGTEXT:
        {
            ScanResultInforyTitleCell *cell=[tableView scanResultInforyTitleCell];
            
            [cell loadWithDecode:decode];
            
            return cell;
        }
            
        case SCANCODE_DECODE_TYPE_VIDEO:
        {
            ScanResultInforyVideoCell *cell=[tableView scanResultInforyVideoCell];
            
            cell.delegate=self;
            
            [cell loadWithDecode:decode];
            
            return cell;
        }
            
        case SCANCODE_DECODE_TYPE_SHARE:
        {
            ScanResultInforyShareCell *cell=[tableView scanResultInforyShareCell];
            [cell loadWithLink:decode.linkShare];
            
            return cell;
        }
            
        case SCANCODE_DECODE_TYPE_UNKNOW:
            return [UITableViewCell new];
    }
    
    return [UITableViewCell new];
}

-(void)scanResultInforyButtonCellTouchedAction:(ScanResultInforyButtonCell *)cell action:(UserNotificationAction *)action
{
    [self.delegate scanResultInforyCell:self touchedAction:action];
}

-(MPMoviePlayerController *)scanResultInforyVideoCellRequestMoviePlayer:(ScanResultInforyVideoCell *)cell
{
    return [self.delegate scanResultInforyCellRequestMoviePlayer:self];
}

+(NSString *)reuseIdentifier
{
    return @"ScanResultInforyCell";
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [table registerScanResultInforyHeaderCell];
    [table registerScanResultInforyTitleCell];
    [table registerScanResultInforyTextCell];
    [table registerScanResultInforyImageCell];
    [table registerScanResultInforyVideoCell];
    [table registerScanResultInforyButtonCell];
    [table registerScanResultInforyShareCell];
}

@end

@implementation UITableView(ScanResultInforyCell)

-(void)registerScanResultInforyCell
{
    [self registerNib:[UINib nibWithNibName:[ScanResultInforyCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ScanResultInforyCell reuseIdentifier]];
}

-(ScanResultInforyCell *)scanResultInforyCell
{
    return [self dequeueReusableCellWithIdentifier:[ScanResultInforyCell reuseIdentifier]];
}

@end