//
//  ScanResultRelatedCell.m
//  Infory
//
//  Created by XXX on 7/2/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultRelatedCell.h"
#import "ScanResultObjectCell.h"
#import "ScanCodeRelated.h"

@interface ScanResultRelatedCell()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ScanResultRelatedCell

-(void)loadWithRelated:(NSArray *)data
{
    _related=data;
    
    [table reloadData];
    table.userInteractionEnabled=false;
    table.scrollEnabled=false;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _related.count==0?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _related.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScanCodeRelated *obj=_related[indexPath.row];
    
    return [ScanResultObjectCell heightWithRelated:obj];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScanResultObjectCell *cell=[tableView scanResultObjectCell];
    
    [cell loadWithRelated:_related[indexPath.row]];
    
    return cell;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [table registerScanResultObjectCell];
}

+(float)heightWithRelated:(NSArray *)data
{
    float height=0;
    
    for(ScanCodeRelated *obj in data)
    {
        height+=[ScanResultObjectCell heightWithRelated:obj];
    }
    
    return height;
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