//
//  ScanResultInforyImageCell.m
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultInforyImageCell.h"
#import "OperationQRCodeDecode.h"

@implementation ScanResultInforyImageCell

-(void)loadWithDecode:(QRCodeDecode *)decode
{
    
}

+(NSString *)reuseIdentifier
{
    return @"ScanResultInforyImageCell";
}

+(float)heightWithDecode:(QRCodeDecode *)decode
{
    return 0;
}

@end

@implementation UITableView(ScanResultInforyImageCell)

-(void)registerScanResultInforyImageCell
{
    [self registerNib:[UINib nibWithNibName:[ScanResultInforyImageCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ScanResultInforyImageCell reuseIdentifier]];
}

-(ScanResultInforyImageCell *)scanResultInforyImageCell
{
    return [self dequeueReusableCellWithIdentifier:[ScanResultInforyImageCell reuseIdentifier]];
}

@end