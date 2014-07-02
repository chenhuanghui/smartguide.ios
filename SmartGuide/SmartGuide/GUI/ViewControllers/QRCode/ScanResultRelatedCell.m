//
//  ScanResultRelatedCell.m
//  Infory
//
//  Created by XXX on 7/2/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultRelatedCell.h"
#import "ScanResultObjectCell.h"

@interface ScanResultRelatedCell()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ScanResultRelatedCell

-(void)loadWithRelaties:(NSString *)relaties
{
    _relaties=relaties;
    
    [table reloadData];
    table.userInteractionEnabled=false;
    table.scrollEnabled=false;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ScanResultObjectCell height];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScanResultObjectCell *cell=[tableView scanResultObjectCell];
    
    return cell;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [table registerScanResultObjectCell];
}

+(float)height
{
    return 20*80;
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