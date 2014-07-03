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
#import "ScanCodeRelatedContain.h"
#import "ScanResultViewController.h"
#import "LoadingMoreCell.h"

@interface ScanResultRelatedCell()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ScanResultRelatedCell

-(void)loadWithRelatedContain:(ScanCodeRelatedContain *)relatedContain
{
    _relatedContain=relatedContain;
    
    [table reloadData];
    table.userInteractionEnabled=true;
    table.scrollEnabled=false;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _relatedContain.relatiesObjects.count==0?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _relatedContain.relatiesObjects.count+(_relatedContain.canLoadMore.boolValue?1:0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_relatedContain.canLoadMore.boolValue && indexPath.row==_relatedContain.relatiesObjects.count)
        return 94;
    
    ScanCodeRelated *obj=_relatedContain.relatiesObjects[indexPath.row];
    
    return [ScanResultObjectCell heightWithRelated:obj];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_relatedContain.canLoadMore.boolValue && indexPath.row==_relatedContain.relatiesObjects.count)
    {
        if(!_relatedContain.isLoadingMore.boolValue)
        {
            _relatedContain.isLoadingMore=@(true);
            [_relatedContain save];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SCAN_RELATED_REQUEST_LOADMORE object:_relatedContain];
        }
        
        return [table loadingMoreCell];
    }
    
    ScanResultObjectCell *cell=[tableView scanResultObjectCell];
    
    [cell loadWithRelated:_relatedContain.relatiesObjects[indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScanResultObjectCell *cell=(ScanResultObjectCell*)[table cellForRowAtIndexPath:indexPath];
    
    if([cell isKindOfClass:[ScanResultObjectCell class]])
    {
        [self.delegate scanResultRelatedCell:self touchedObject:cell.obj];
    }
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [table registerScanResultObjectCell];
    [table registerLoadingMoreCell];
}

+(float)heightWithRelated:(ScanCodeRelatedContain *)relatedContain
{
    float height=0;
    
    for(ScanCodeRelated *obj in relatedContain.relatiesObjects)
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