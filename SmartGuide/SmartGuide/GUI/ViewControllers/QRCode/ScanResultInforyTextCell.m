//
//  ScanResultInforyTextCell.m
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultInforyTextCell.h"
#import "OperationQRCodeDecode.h"

@implementation ScanResultInforyTextCell

-(void)loadWithDecode:(QRCodeDecode *)obj
{
    
}

+(NSString *)reuseIdentifier
{
    return @"ScanResultInforyTextCell";
}

+(float)heightWithDecode:(QRCodeDecode *)obj
{
    return 0;
}

@end

@implementation UITableView(ScanResultInforyTextCell)

-(void)registerScanResultInforyTextCell
{
    [self registerNib:[UINib nibWithNibName:[ScanResultInforyTextCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ScanResultInforyTextCell reuseIdentifier]];
}

-(ScanResultInforyTextCell *)scanResultInforyTextCell
{
    return [self dequeueReusableCellWithIdentifier:[ScanResultInforyTextCell reuseIdentifier]];
}

@end