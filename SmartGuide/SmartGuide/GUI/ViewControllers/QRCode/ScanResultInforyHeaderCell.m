//
//  ScanResultInforyHeaderCell.m
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultInforyHeaderCell.h"
#import "OperationQRCodeDecode.h"

@implementation ScanResultInforyHeaderCell

-(void)loadWithDecode:(QRCodeDecode *)decode
{
    
}

+(NSString *)reuseIdentifier
{
    return @"ScanResultInforyHeaderCell";
}

+(float)heightWithDecode:(QRCodeDecode *)decode
{
    return 0;
}

@end

@implementation UITableView(ScanResultInforyHeaderCell)

-(void)registerScanResultInforyHeaderCell
{
    [self registerNib:[UINib nibWithNibName:[ScanResultInforyHeaderCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ScanResultInforyHeaderCell reuseIdentifier]];
}

-(ScanResultInforyHeaderCell *)scanResultInforyHeaderCell
{
    return [self dequeueReusableCellWithIdentifier:[ScanResultInforyHeaderCell reuseIdentifier]];
}

@end