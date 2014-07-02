//
//  ScanResultObjectCell.m
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultObjectCell.h"

@implementation ScanResultObjectCell

+(NSString *)reuseIdentifier
{
    return @"ScanResultObjectCell";
}

+(float)height
{
    return 94;
}

@end

@implementation UITableView(ScanResultObjectCell)

-(void)registerScanResultObjectCell
{
    [self registerNib:[UINib nibWithNibName:[ScanResultObjectCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ScanResultObjectCell reuseIdentifier]];
}

-(ScanResultObjectCell *)scanResultObjectCell
{
    return [self dequeueReusableCellWithIdentifier:[ScanResultObjectCell reuseIdentifier]];
}

@end