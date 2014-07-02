//
//  ScanResultInforyTitleCell.m
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultInforyTitleCell.h"
#import "OperationQRCodeDecode.h"

@implementation ScanResultInforyTitleCell

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

@implementation UITableView(ScanResultInforyTitleCell)

-(void)registerScanResultInforyTitleCell
{
    [self registerNib:[UINib nibWithNibName:[ScanResultInforyTitleCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ScanResultInforyTitleCell reuseIdentifier]];
}

-(ScanResultInforyTitleCell *)scanResultInforyTitleCell
{
    return [self dequeueReusableCellWithIdentifier:[ScanResultInforyTitleCell reuseIdentifier]];
}

@end