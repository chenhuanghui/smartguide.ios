//
//  ScanResultInforyButtonCell.m
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultInforyButtonCell.h"
#import "OperationQRCodeDecode.h"

@implementation ScanResultInforyButtonCell

-(void)loadWithDecode:(QRCodeDecode *)decode
{
    
}

+(NSString *)reuseIdentifier
{
    return @"ScanResultInforyButtonCell";
}

+(float)heightWithDecode:(QRCodeDecode *)decode
{
    return 0;
}

@end

@implementation UITableView(ScanResultInforyButtonCell)

-(void)registerScanResultInforyButtonCell
{
    [self registerNib:[UINib nibWithNibName:[ScanResultInforyButtonCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ScanResultInforyButtonCell reuseIdentifier]];
}

-(ScanResultInforyButtonCell *)ScanResultInforyButtonCell
{
    return [self dequeueReusableCellWithIdentifier:[ScanResultInforyButtonCell reuseIdentifier]];
}

@end