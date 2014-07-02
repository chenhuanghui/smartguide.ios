//
//  ScanResultNonInforyCell.m
//  Infory
//
//  Created by XXX on 7/2/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultNonInforyCell.h"

@implementation ScanResultNonInforyCell

+(NSString *)reuseIdentifier
{
    return @"ScanResultNonInforyCell";
}

+(float)height
{
    return 226;
}

@end

@implementation UITableView(ScanResultNonInforyCell)

-(void)registerScanResultNonInforyCell
{
    [self registerNib:[UINib nibWithNibName:[ScanResultNonInforyCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ScanResultNonInforyCell reuseIdentifier]];
}

-(ScanResultNonInforyCell *)scanResultNonInforyCell
{
    return [self dequeueReusableCellWithIdentifier:[ScanResultNonInforyCell reuseIdentifier]];
}

@end