//
//  ScanResultRelatedMoreCell.m
//  Infory
//
//  Created by XXX on 7/14/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultRelatedMoreCell.h"

@implementation ScanResultRelatedMoreCell

+(NSString *)reuseIdentifier
{
    return @"ScanResultRelatedMoreCell";
}

+(float)height
{
    return 80;
}

@end

@implementation UITableView(ScanResultRelatedMoreCell)

-(void)registerScanResultRelatedMoreCell
{
    [self registerNib:[UINib nibWithNibName:[ScanResultRelatedMoreCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ScanResultRelatedMoreCell reuseIdentifier]];
}

-(ScanResultRelatedMoreCell *)scanResultRelatedMoreCell
{
    return [self dequeueReusableCellWithIdentifier:[ScanResultRelatedMoreCell reuseIdentifier]];
}

@end