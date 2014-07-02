//
//  ScanResultInforyVideoCell.m
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultInforyVideoCell.h"
#import "OperationQRCodeDecode.h"

@implementation ScanResultInforyVideoCell

-(void)loadWithDecode:(QRCodeDecode *)decode
{
    
}

+(NSString *)reuseIdentifier
{
    return @"ScanResultInforyTitleCell";
}

+(float)heightWithDecode:(QRCodeDecode *)decode
{
    return 0;
}

@end

@implementation UITableView(ScanResultInforyVideoCell)

-(void)registerScanResultInforyVideoCell
{
    [self registerNib:[UINib nibWithNibName:[ScanResultInforyVideoCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ScanResultInforyVideoCell reuseIdentifier]];
}

-(ScanResultInforyVideoCell *)scanResultInforyVideoCell
{
    return [self dequeueReusableCellWithIdentifier:[ScanResultInforyVideoCell reuseIdentifier]];
}

@end