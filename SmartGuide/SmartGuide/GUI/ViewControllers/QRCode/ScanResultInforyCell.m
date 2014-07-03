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

@interface ScanResultInforyCell()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation ScanResultInforyCell

-(void)loadWithDecode:(NSArray *) array
{
    _items=array;
    
    [table reloadData];
    table.scrollEnabled=false;
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
            return [ScanResultInforyHeaderCell heightWithDecode:decode];
            
        case SCANCODE_DECODE_TYPE_IMAGE:
            return [ScanResultInforyImageCell heightWithDecode:decode];
            
        case SCANCODE_DECODE_TYPE_SMALLTEXT:
            return [ScanResultInforyTextCell heightWithDecode:decode];
            
        case SCANCODE_DECODE_TYPE_BIGTEXT:
            return [ScanResultInforyTitleCell heightWithDecode:decode];
            
        case SCANCODE_DECODE_TYPE_VIDEO:
            return [ScanResultInforyVideoCell heightWithDecode:decode];
            
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
            
            [cell loadWithDecode:decode];
            
            return cell;
        }
            
        case SCANCODE_DECODE_TYPE_UNKNOW:
            return [UITableViewCell new];
    }
    
    return [UITableViewCell new];
}

+(NSString *)reuseIdentifier
{
    return @"ScanResultInforyCell";
}

+(float)heightWithDecode:(NSArray *) array
{
    float height=0;
    for(ScanCodeDecode *decode in array)
    {
        switch (decode.enumType) {
            case SCANCODE_DECODE_TYPE_BUTTONS:
                height+=[ScanResultInforyButtonCell heightWithDecode:decode];
                break;
                
            case SCANCODE_DECODE_TYPE_HEADER:
                height+=[ScanResultInforyHeaderCell heightWithDecode:decode];
                break;
                
            case SCANCODE_DECODE_TYPE_IMAGE:
                height+=[ScanResultInforyImageCell heightWithDecode:decode];
                break;
                
            case SCANCODE_DECODE_TYPE_SMALLTEXT:
                height+=[ScanResultInforyTextCell heightWithDecode:decode];
                break;
                
            case SCANCODE_DECODE_TYPE_BIGTEXT:
                height+=[ScanResultInforyTitleCell heightWithDecode:decode];
                break;
                
            case SCANCODE_DECODE_TYPE_VIDEO:
                height+=[ScanResultInforyVideoCell heightWithDecode:decode];
                break;
                
            case SCANCODE_DECODE_TYPE_UNKNOW:
                break;
        }
    }
    
    return height;
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