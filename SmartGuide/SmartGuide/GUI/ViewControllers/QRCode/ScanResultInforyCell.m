//
//  ScanResultInforyCell.m
//  Infory
//
//  Created by XXX on 7/2/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultInforyCell.h"
#import "OperationQRCodeDecode.h"
#import "ScanResultInforyHeaderCell.h"
#import "ScanResultInforyTitleCell.h"
#import "ScanResultInfory

@implementation ScanResultInforyCell

-(void)loadWithDecode:(NSArray *) array
{
    _items=array;
    
    [table reloadData];
}

+(NSString *)reuseIdentifier
{
    return @"ScanResultInforyCell";
}

+(float)heightWithDecode:(NSArray *) array
{
    return 386;
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