//
//  ScanResultRelatedCell.m
//  Infory
//
//  Created by XXX on 7/2/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultRelatedCell.h"

@interface ScanResultRelatedCell()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ScanResultRelatedCell

-(void)loadWithRelaties:(NSArray *)relaties
{
    _relaties=relaties;
    
    [table reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _relaties.count;
}



+(NSString *)reuseIdentifier
{
    return @"ScanResultRelatedCell";
}

@end

@implementation UITableView(ScanResultRelatedCell)

-(void)registerScanResultRelatedCell
{
    [self registerNib:[UINib nibWithNibName:[ScanResultRelatedCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ScanResultRelatedCell reuseIdentifier]];
}

-(ScanResultRelatedCell *)scanResultRelatedCell
{
    return [self dequeueReusableCellWithIdentifier:[ScanResultRelatedCell reuseIdentifier]];
}

@end